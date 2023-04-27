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
	['coreclr'] = 'netcoredbg',
	['js'] = 'js-debug-adapter',
	['codelldb'] = 'codelldb',
	['bash'] = 'bash-debug-adapter',
	['javadbg'] = 'java-debug-adapter',
	['javatest'] = 'java-test',
	['mock'] = 'mockdebug',
	['puppet'] = 'puppet-editor-services',
	['elixir'] = 'elixir-ls',
	['kotlin'] = 'kotlin-debug-adapter',
	['dart'] = 'dart-debug-adapter',
	['haskell'] = 'haskell-debug-adapter',
}

M.package_to_nvim_dap = _.invert(M.nvim_dap_to_package)

return M
