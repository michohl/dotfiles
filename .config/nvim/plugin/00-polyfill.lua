-- Polyfill vim.notify in case it's called before nvim-notify loads
if not vim.notify then
  vim.notify = function(msg, level, opts)
    vim.api.nvim_echo({ { tostring(msg), "ErrorMsg" } }, true, opts or {})
  end
end
