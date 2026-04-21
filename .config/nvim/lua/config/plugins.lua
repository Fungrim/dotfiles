local plugins = {
    {
        'glepnir/nerdicons.nvim', cmd = 'NerdIcons', config = function() require('nerdicons').setup({}) end
    },
    { 
        'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {
        'nvim-telescope/telescope.nvim', version = 'v0.1.9',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons' 
        }
    }
}

local opts = { 

}

require("lazy").setup(plugins, opts)
require("catppuccin").setup()

-- colorscheme
vim.cmd.colorscheme = "catppuccin"

-- map telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
