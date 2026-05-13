local M = {}

local defaults = {
  transparent = true,
  italic_comments = true,
  dim_inactive = false,
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.get_options()
  return M.options
end

return M