`mason-nvim-dap` bridges `mason.nvim` with the `nvim-dap` plugin - making it easier to use both plugins together.


# Introduction

`mason-nvim-dap.nvim` closes some gaps that exist between `mason.nvim` and `nvim-dap`. Its main responsibilities are:

-   provide extra convenience APIs such as the `:DapInstall` command
-   allow you to (i) automatically install, and (ii) automatically set up a predefined list of adapters
-   translate between `dap` adapter names and `mason.nvim` package names (e.g. `python` <-> `debugpy`)

It is recommended to use this extension if you use `mason.nvim` and `nvim-dap`.

**Note: this plugin uses the `dap` adapter names in the APIs it exposes - not `mason.nvim` package names.


# Requirements

-   neovim `>= 0.7.0`
-   [`mason.nvim`](https://github.com/williamboman/mason.nvim)
-   [`nvim-dap`](https://github.com/mfussenegger/nvim-dap)


# Installation

## [Packer](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jayp0521/mason-nvim-dap.nvim",
}
```

## vim-plug

```vim
Plug 'williamboman/mason.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'jayp0521/mason-nvim-dap.nvim'
```


# Setup

It's important that you set up the plugins in the following order:

1. `mason.nvim`
2. `dap`
3. `mason-nvim-dap.nvim`

Pay extra attention to this if you're using a plugin manager to load plugins for you, as there are no guarantees it'll
load plugins in the correct order unless explicitly instructed to.

```lua
require("mason").setup()
require("dap").setup()
require("mason-nvim-dap").setup()
```

Refer to the [Configuration](#configuration) section for information about which settings are available.


# Commands

-   `:DapInstall [<adapter>...]` - installs the provided adapter
-   `:DapUninstall <adapter> ...` - uninstalls the provided adapter


# Configuration

You may optionally configure certain behavior of `mason-nvim-dap.nvim` when calling the `.setup()` function. Refer to
the [default configuration](#default-configuration) for a list of all available settings.

Example:

```lua
require("mason-nvim-dap").setup({
    ensure_installed = { "python", "delve" }
})
```

## Default configuration

```lua
local DEFAULT_SETTINGS = {
    -- A list of adapters to install if they're not already installed.
    -- This setting has no relation with the `automatic_installation` setting.
    ensure_installed = {},
    -- Run `require("dap").setup`.
    -- Will automatically install masons tools based on selected adapters in `dap`.
    automatic_installation = false,
}
```


# Setup handlers usage

# Setup handlers usage

The `setup_handlers()` function provides a dynamic way of setting up sources and any other needed logic, It can also do that during runtime.

```lua
local dap = require("dap")

require ('mason-nvim-dap').setup({
    ensure_installed = {'stylua', 'jq'}
})

require 'mason-nvim-dap'.setup_handlers {
    function(source_name)
      -- all sources with no handler get passed here
    end,
    python = function()
        dap.adapters.python = {
	        type = "executable",
	        command = "/usr/bin/python3",
	        args = {
		        "-m",
		        "debugpy.adapter",
	        },
        }

        dap.configurations.python = {
	        {
		        type = "python",
		        request = "launch",
		        name = "Launch file",
		        program = "${file}", -- This configuration will launch the current file if used.
	        },
        }
    end,
}
```

# Available Dap Adapters

See https://github.com/jayp0521/mason-nvim-dap/blob/main/lua/mason-nvim-dap/mappings/source.lua
