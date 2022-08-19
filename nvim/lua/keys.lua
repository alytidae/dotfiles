--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- Remap the key used to leave insert mode
map('i', 'jk', '<ESC>', {})

-- Nvim Tree
map('n', '<C-f>', [[:NvimTreeToggle<CR>]], {})

-- Tabs
map('n', '<C-n>', [[:tabnew<CR>]], {}) 
map('n', '<C-l>', [[:tabnext<CR>]], {})
map('n', '<C-h>', [[:tabprevious<CR>]], {})
map('n', '<C-q>', [[:tabclose<CR>]], {})

-- Clear search highlighting with <leader> and c
map('n', '<C-c>', '[[:nohlsearch<CR>]]', {})
