return {
  "folke/sidekick.nvim",
  event = "VeryLazy",
  opts = {
    -- Configure CLI tools for Claude Code and other AI assistants
    cli = {
      -- Claude Code CLI integration
      claude = {
        cmd = "claude", -- assumes claude CLI is in PATH
        args = {},
      },
      -- GitHub Copilot CLI integration (if you have it installed)
      copilot = {
        cmd = "gh",
        args = { "copilot", "suggest" },
      },
    },
    -- Next Edit Suggestions (NES) configuration
    nes = {
      enabled = true,
      auto_update = true, -- automatically update suggestions while typing
      debounce = 500, -- ms to wait before updating
      diff = {
        enabled = true,
        style = "inline", -- "inline" or "split"
      },
    },
  },
  keys = {
    -- Toggle AI CLI terminal (using <leader>sk to avoid conflict with avante)
    { "<leader>sk", function() require("sidekick.cli").toggle({ focus = true }) end, desc = "Toggle Sidekick CLI", mode = { "n", "v" } },
    -- Select AI prompt
    { "<leader>sp", function() require("sidekick.cli").select_prompt() end, desc = "Sidekick Prompt", mode = { "n", "v" } },
    -- Toggle Claude specifically
    { "<leader>sc", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, desc = "Sidekick Claude", mode = { "n", "v" } },
    -- Jump to or apply next edit suggestion
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>"
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
      mode = { "i", "n" }
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "zbirenbaum/copilot.lua", -- for Copilot LSP integration
  },
}