# devctx: per-shell account context (git, ssh, gh, gcloud, kubernetes).
# Everything is environment variables, so several shells can use different
# accounts at once. Usage: devctx <account> | devctx --clear | devctx
# Inside tmux the session name selects the account (see the hook at the bottom).

typeset -gA _DEVCTX_EMAIL=( personal contact@larsan.net fungrim lars@fungrim.com umbri lars@umbri.se george lars@fungrim.com )
typeset -gA _DEVCTX_SSH=(   personal personal            fungrim fungrim          umbri umbri         george fungrim )
typeset -gA _DEVCTX_PAT=(   personal personal            fungrim fungrim          umbri personal      george fungrim )
typeset -gA _DEVCTX_GCLOUD=( personal personal           fungrim fungrim          umbri umbri         george getgeorge )

_DEVCTX_VARS=( DEVCTX GIT_SSH_COMMAND GIT_CONFIG_COUNT GIT_CONFIG_KEY_0 GIT_CONFIG_VALUE_0 GH_TOKEN CLOUDSDK_CONFIG CLOUDSDK_ACTIVE_CONFIG_NAME KUBECONFIG )
_DEVCTX_SHIMS=$HOME/.local/fungrim/devctx/shims

devctx() {
  case $1 in
    "")
      echo "${DEVCTX:-<none>}"; return ;;
    -c|--clear)
      unset $_DEVCTX_VARS
      path=( ${path:#$_DEVCTX_SHIMS} )
      return ;;
  esac

  local a=$1
  if [[ -z ${_DEVCTX_EMAIL[$a]} ]]; then
    echo "devctx: unknown account '$a' (${(kj:, :)_DEVCTX_EMAIL})" >&2
    return 1
  fi

  export DEVCTX=$a
  export GIT_SSH_COMMAND="ssh -F $HOME/.ssh/config.${_DEVCTX_SSH[$a]}"
  export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=user.email GIT_CONFIG_VALUE_0=${_DEVCTX_EMAIL[$a]}
  export GH_TOKEN="$(<$HOME/.gitauth/pat_${_DEVCTX_PAT[$a]}.txt)"
  export CLOUDSDK_CONFIG=$HOME/.config/gcloud-$a
  export CLOUDSDK_ACTIVE_CONFIG_NAME=${_DEVCTX_GCLOUD[$a]}
  export KUBECONFIG=$HOME/.kube/config-$a
  unset GOOGLE_APPLICATION_CREDENTIALS
  # shim: stops the GKE auth plugin sharing a token cache between accounts
  [[ ${path[1]} == $_DEVCTX_SHIMS ]] || path=( $_DEVCTX_SHIMS $path )
}

# tm <account>: open (or switch to) the tmux session for an account
tm() {
  local s=${1:?usage: tm <account>}
  if [[ -n $TMUX ]]; then
    tmux has-session -t "=$s" 2>/dev/null || tmux new-session -d -s "$s"
    tmux switch-client -t "=$s"
  else
    tmux new-session -A -s "$s"
  fi
}

# p10k segment
prompt_devctx() {
  [[ -n $DEVCTX ]] && p10k segment -f 16 -b 178 -t "$DEVCTX"
}

# In tmux the session name is the account; any other session gets a clean slate
# (the tmux server may have inherited variables from the shell that started it).
if [[ -n $TMUX ]]; then
  devctx "$(tmux display-message -p '#S')" 2>/dev/null || devctx --clear
fi
