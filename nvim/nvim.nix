{ config, lib, pkgs, ...}:

{
  programs.neovim =
  let
    toLua = str: "lua << EOF\n$str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
	
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
		# language servers
      	lua-language-server
      	rnix-lsp

		# for copy/paste in vim
      	xclip
		wl-clipboard


		# telescope things
		ripgrep
		fd
    ];

	plugins = with pkgs.vimPlugins; [
		{
			plugin = nvim-lspconfig;
			config = toLuaFile ./plugin/lsp.lua;
		}
		{		
			plugin = telescope-nvim;
			config = toLuaFile ./plugin/telescope.lua;
		}
      		{
        		plugin = nvim-cmp;
        		config = toLuaFile ./plugin/cmp.lua;
      		}
		
      			cmp_luasnip
      			cmp-nvim-lsp

      			luasnip
		{
			plugin = (nvim-treesitter.withPlugins (p: [
				p.tree-sitter-nix
	  			p.tree-sitter-lua
        	]));
			config = toLuaFile ./plugin/treesitter.lua;
    	}
      	{
			plugin = catppuccin-nvim;
			config = "colorscheme catppuccin-mocha";
      	}
	];

	extraLuaConfig = ''
    ${builtins.readFile ./options.lua}
  	'';
  };
}
