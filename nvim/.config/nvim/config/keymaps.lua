vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

keymap("i", "jk", "<Esc>", {
    desc = "Exit insert mode",
})

keymap("x", "<leader>p", [["_dP]], {
    desc = "Paste without replacing register",
})

