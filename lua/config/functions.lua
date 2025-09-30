local M = {}

function M.generate_commit_message()
  local handle = io.popen("git diff --staged")
  if not handle then
    vim.notify("Failed to execute git diff command.", vim.log.levels.ERROR)
    return
  end
  local diff = handle:read("*a")
  handle:close()

  if diff == "" then
    vim.notify("No staged changes to generate commit message from.", vim.log.levels.WARN)
    return
  end

  vim.notify("Generating commit message...", vim.log.levels.INFO)

  local prompt = "Generate a concise git commit message for these changes. Return only the commit message, no explanation:\n\n"
    .. diff
  local escaped_prompt = prompt:gsub('"', '\\"'):gsub("\n", "\\n")

  local cmd = string.format('claude "%s"', escaped_prompt)
  local result_handle = io.popen(cmd)
  if not result_handle then
    vim.notify("Failed to execute claude command.", vim.log.levels.ERROR)
    return
  end
  local commit_message = result_handle:read("*a")
  result_handle:close()

  if commit_message == "" then
    vim.notify("Failed to generate commit message.", vim.log.levels.ERROR)
    return
  end

  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "gitcommit"

  local message_lines = vim.split(commit_message:gsub("^%s*(.-)%s*$", "%1"), "\n")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, message_lines)

  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "# Staged changes:" })
  local diff_lines = vim.split(diff, "\n")
  for i, line in ipairs(diff_lines) do
    diff_lines[i] = "# " .. line
  end
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, diff_lines)

  vim.api.nvim_win_set_cursor(0, { 1, 0 })
end

return M
