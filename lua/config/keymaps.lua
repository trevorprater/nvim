-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.keymap.set("n", "gtfo", ":q!<CR>", { noremap = true })

-- AI-generated commit messages
vim.keymap.set("n", "<leader>gm", function()
  require("config.functions").generate_commit_message()
end, { desc = "Generate commit message" })
