return {
	type = 'server',
	host = '127.0.0.1',
	port = '${port}',
	executable = {
		command = vim.fn.exepath('js-debug-adapter'),
		args = { '${port}' },
	},
}
