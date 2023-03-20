-- [[ plug.lua ]]

return require('packer').startup(function(use)
	-- [[ Plugins Go Here ]]
	use 'wbthomason/packer.nvim'
	use {                                              -- filesystem navigation
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons'        -- filesystem icons
	}
	use {
		'goolord/alpha-nvim', -- a lua powered greeter 
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}
	use 'folke/tokyonight.nvim'
	use 'NvChad/nvim-colorizer.lua' -- the fastest Neovim colorizer	
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	-- CMP
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'

	--snippet engine
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	-- snippet engine
	-- use 'dcampos/nvim-snippy'
	-- use 'dcampos/cmp-snippy'

	--use 'onsails/lspkind-nvim'
end)
