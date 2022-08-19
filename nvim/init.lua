--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- Main imports
require('vars')      -- Variables
require('opts')      -- Options
require('keys')      -- Keymaps
require('plug')      -- Plugins

-- Lsp and cmp
require('nvim-lsp-installer').setup{}
require('lsp')

require('nvim-tree').setup{}
require('colorizer').setup{}
