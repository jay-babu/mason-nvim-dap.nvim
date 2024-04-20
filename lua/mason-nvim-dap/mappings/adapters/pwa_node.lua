return {
	type = 'server',
	host = 'localhost',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('js-debug-adapter'),
		args = { '${port}' },
	},
}
