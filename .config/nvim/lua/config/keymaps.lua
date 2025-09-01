-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- modify keybindings that are not specific to plugins, modify core neovim functionality

-- Fast saving
vim.keymap.set("n", "<localleader>w", ":write!<CR>")
vim.keymap.set("n", "<localleader>q", ":q!<CR>", { silent = true })

-- Exit on jj and jk
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Exit on jj and jk
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("i", "jk", "<ESC>")
