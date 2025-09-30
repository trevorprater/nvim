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

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true })
