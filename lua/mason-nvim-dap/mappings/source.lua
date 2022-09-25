local _ = require('mason-core.functional')

local M = {}

---Maps nvim_dap adapter name to its corresponding package name.
M.nvim_dap_to_package = {
	['python'] = 'debugpy',
	['cppdbg'] = 'cpptools',
	['delve'] = 'delve',
	['node2'] = 'node-debug2-adapter',
	['chrome'] = 'chrome-debug-adapter',
	['firefox'] = 'firefox-debug-adapter',
	['php'] = 'php-debug-adapter',
	['coreclr'] = 'netcoredbp',
}

M.package_to_nvim_dap = _.invert(M.nvim_dap_to_package)

return M
