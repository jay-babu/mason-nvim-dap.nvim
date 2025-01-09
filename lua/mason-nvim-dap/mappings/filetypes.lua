local _ = require('mason-core.functional')
local settings = require('mason-nvim-dap.settings')

local M = {
  ['bash'] = { 'sh' },
  ['chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['codelldb'] = { 'c', 'cpp', 'rust', 'swift', 'zig' },
  ['coreclr'] = { 'cs', 'fsharp' },
  ['cppdbg'] = { 'c', 'cpp', 'rust', 'asm', 'swift' },
  ['dart'] = { 'dart' },
  ['delve'] = { 'go' },
  ['firefox'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['kotlin'] = { 'kotlin' },
  ['mix_task'] = { 'elixir' },
  ['node2'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['php'] = { 'php' },
  ['python'] = { 'python' },
  ['haskell'] = { 'haskell' },
  ['erlang'] = { 'erlang' },
  ['pwa-node'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['pwa-chrome'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['pwa-msedge'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['pwa-terminal'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },
  ['pwa-extensionHost'] = { 'javascriptreact', 'typescriptreact', 'typescript', 'javascript' },

}

return M
