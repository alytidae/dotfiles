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
	use 'yonlu/omni.vim'
	use 'NvChad/nvim-colorizer.lua' -- the fastest Neovim colorizer	
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	-- CMP
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/nvim-cmp'
    	use 'hrsh7th/cmp-buffer'
    	use 'hrsh7th/cmp-path'

	--snippet engine
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use 'simrat39/rust-tools.nvim'

	-- snippet engine
	-- use 'dcampos/nvim-snippy'
	-- use 'dcampos/cmp-snippy'

	--use 'onsails/lspkind-nvim'
end)
