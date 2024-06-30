# Changelog

## [2.3.1](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.3.0...v2.3.1) (2024-06-30)


### Bug Fixes

* **netcoredbg:** failing to start on Windows ([#133](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/133)) ([2bff39c](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/2bff39c891f89fb58096ea67ef404db305a9477b))

## [2.3.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.2.2...v2.3.0) (2024-06-07)


### Features

* automatically configure the vscode extension in `nvim-dap` ([#129](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/129)) ([a046867](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/a04686728284ce378a7f2891362c5df5fadf3658))


### Bug Fixes

* Start Delve debug in project mode, not file ([#122](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/122)) ([67210c0](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/67210c0e775adec55de9826b038e8b62de554afc))

## [2.2.2](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.2.1...v2.2.2) (2023-12-21)


### Bug Fixes

* Use integratedTerminal for Python and CodeLLDB ([#117](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/117)) ([9e82ded](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/9e82ded0515186edd4f69e4ce6b1a5f1b55b47e9))

## [2.2.1](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.2.0...v2.2.1) (2023-11-22)


### Bug Fixes

* debugpy path on Windows ([#115](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/115)) ([ab613d8](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/ab613d8233ad07d86f423b205fa3ec0db95b3b45))

## [2.2.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.1.1...v2.2.0) (2023-10-19)


### Features

* Enable the codelldb and cppdbg adapters to debug swift applications. ([#108](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/108)) ([6148b51](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/6148b51db945b55b3b725da39eaea6441e59dff8))
* Enable Zig debugging on codelldb ([#111](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/111)) ([1e5cdf1](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/1e5cdf182be5e4b7082fea96e82de380844bd593))

## [2.1.1](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.1.0...v2.1.1) (2023-06-10)


### Bug Fixes

* Fixed codelldb and cppdbg failing to setup on windows. ([#96](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/96)) ([961e9e8](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/961e9e867f6c4a028af6495798b505b749975f33))

## [2.1.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.0.4...v2.1.0) (2023-05-01)


### Features

* Add haskell to list of supported debug adapters ([#87](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/87)) ([7c18898](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/7c18898e3a8ed369bfa0cfcc4be7bccdf5d13ea7))


### Bug Fixes

* changed default prompt to be the fresh-installed stack version ([#90](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/90)) ([f0a476f](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/f0a476fba64d43a66d14fc33e284cbdc9d87fd97))
* use ghci-dap and -ignore-dot-ghci ([#91](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/91)) ([6fe5eac](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/6fe5eac6db65fdbad68bf638dea0a849ccb63fd7))

## [2.0.4](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.0.3...v2.0.4) (2023-04-23)


### Bug Fixes

* remove not used language_mappings defition ([#84](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/84)) ([9512a88](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/9512a88cc96f1c1d1e5dc56e3fd57e669d107bf4))

## [2.0.3](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.0.2...v2.0.3) (2023-04-23)


### Bug Fixes

* pcall return values order ([#82](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/82)) ([6bbb57b](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/6bbb57b9f9750c5ab8d8145a47eeb5192d456a48))

## [2.0.2](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.0.1...v2.0.2) (2023-04-22)


### Performance Improvements

* Lazily require adapter mappings ([#77](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/77)) ([a6e8d4a](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/a6e8d4ade0810cc0b9a250d59d8db088c3f0da5b))

## [2.0.1](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v2.0.0...v2.0.1) (2023-04-09)


### Bug Fixes

* check if bash-debug-adapter is available then get its data ([#60](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/60)) ([b3cf65e](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/b3cf65e354986775279d41486748a7a35e6965af))

## [2.0.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v1.2.2...v2.0.0) (2023-04-09)


### ⚠ BREAKING CHANGES

* 2.0 ([#59](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/59))

### Features

* 2.0 ([#59](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/59)) ([785265d](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/785265d9c92f7ce951bd6fe6e9675360fd3e86f8))

## [1.2.2](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v1.2.1...v1.2.2) (2023-03-31)


### Bug Fixes

* use vim.fn.exepath for all adapter commands ([#54](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/54)) ([7f54a17](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/7f54a17954e58a587b465bb6f42fa6144dd4b69d))

## [1.2.1](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v1.2.0...v1.2.1) (2023-03-28)


### Bug Fixes

* **codelldb:** use vim.fn.exepath for command ([#51](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/51)) ([#52](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/52)) ([f464b1c](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/f464b1cd69f4a3db21910d85a94f3181f39c6ab4))

## [1.2.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v1.1.0...v1.2.0) (2023-02-18)


### Features

* obtain executable paths dynamically ([3dff251](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/3dff2516884888acc1e005b9f53116cd89c1f30b))

## [1.1.0](https://github.com/jay-babu/mason-nvim-dap.nvim/compare/v1.0.0...v1.1.0) (2023-02-17)


### Features

* **cppdb:** Add asm filetype to configurations ([#42](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/42)) ([64f0b2e](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/64f0b2e9799fd0a6c635fbbf1d0e9ab4791a28a8))

## 1.0.0 (2023-02-16)


### ⚠ BREAKING CHANGES

* **js:** re-add js due to popular demand. https://github.com/jay-babu/mason-nvim-dap.nvim/issues/17"
* **js:** remove js. not officially supported by nvim-dap. https://github.com/jay-babu/mason-nvim-dap.nvim/issues/17

### Features

* **.github:** stale cronjob ([7d9f778](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/7d9f7781267d5aec86201f0a3befbc817eb509da))
* **adapter:** add support for dart ([#35](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/35)) ([a775db8](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/a775db8ac7c468fb05fcf67069961dba0d7feb56))
* add elixir-ls ([#7](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/7)) ([6d73fdc](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/6d73fdc1b355a4d04890a72e39325d9fbf0f2107))
* add lldb, bash, java, mock, puppet, netcore, php, js-debug-adapter ([30282c9](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/30282c9246e6bebb1016604b7e5012ad33da9cc1))
* allowing users to pass in function to override instead of simply a list ([#40](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/40)) ([858942c](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/858942c3f14c71c4284b02ad754b26a3f8dcd5d4))
* **codelldb:** support automatic_setup ([#20](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/20)) ([40c9a53](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/40c9a53c208a2d7e008b27d994ac001fadc7a5a2))
* **elixir:** support automate_setup ([#19](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/19)) ([d6049cf](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/d6049cfc465bde98f0218b6d3eba99094b382cb3))
* **kotlin:** adding kotlin-debug-adapter ([#26](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/26)) ([2c97ca2](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/2c97ca269b8d375c6e60f1872373e692cf73bc18))
* support overriding filetypes for adapters ([#29](https://github.com/jay-babu/mason-nvim-dap.nvim/issues/29)) ([d6cb770](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/d6cb770928b5cb9a6e3880d6bbb58858c1deeb18))


### Reverts

* **js:** re-add js due to popular demand. https://github.com/jay-babu/mason-nvim-dap.nvim/issues/17" ([6efa7cb](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/6efa7cb71db17813bd2630bc5ed6a413c869fc0f))


### bugfix

* **js:** remove js. not officially supported by nvim-dap. https://github.com/jay-babu/mason-nvim-dap.nvim/issues/17 ([48a4aa6](https://github.com/jay-babu/mason-nvim-dap.nvim/commit/48a4aa6769c83c5bedde349e2c047dbb770f1f71))
