-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("n", "gtfo", ":q!<CR>", { noremap = true })

-- Focus diagnostic floating window
vim.api.nvim_set_keymap(
  "n",
  "fd",
  '<cmd>lua vim.diagnostic.open_float(nil, {focus=true, scope="cursor", focusable=true})<CR>',
  { noremap = true, silent = true }
)
