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

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
        ]));
	config = toLuaFile ./plugin/treesitter.lua;
      }
      {
	plugin = catppuccin-nvim;
	config = "colorscheme catppuccin-mocha";
      }
    ];
  };
}
