{ pkgs }:

with pkgs:
mkShell {
	name = "flakeEnv";
	buildInputs = [ rnix-lsp ];
	shellHook = "
	alias nrb="nixos-rebuild build --flake ."
	alias nrt="sudo nixos-rebuild test --flake ."
	alias nrs="sudo nixos-rebuild switch --flatke."
	";
}
