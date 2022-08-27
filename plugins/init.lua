return {
	["goolord/alpha-nvim"] = { disable = true },
	["lukas-reineke/indent-blankline.nvim"] = { disable = true },
	["p00f/nvim-ts-rainbow"] = { disable = true },
	{
		"jose-elias-alvarez/typescript.nvim",
		after = "mason-lspconfig.nvim",
		config = function()
			require("typescript").setup({
				server = astronvim.lsp.server_settings("tsserver"),
			})
		end,
	},
	{
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim",
		after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
		config = function()
			require("flutter-tools").setup({
				lsp = astronvim.lsp.server_settings("dartls"), -- get the server settings and built in capabilities/on_attach
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
		config = function()
			require("rust-tools").setup({
				server = astronvim.lsp.server_settings("rust_analyzer"), -- get the server settings and built in capabilities/on_attach
			})
		end,
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({})
		end,
	},
	{
		"shaunsingh/nord.nvim",
		as = "nord",
	},
	-- DAP
	{
		"mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"leoluz/nvim-dap-go",
		config = function()
			require("dap-go").setup()
		end,
	},
}
