{
	description = "FFI D functions in C";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
	};

	outputs = { self, nixpkgs }: 
	let
		linuxSystems = ["x86_64-linux" "aarch64-linux"];
		darwinSystems = ["x86_64-darwin" "aarch64-darwin"];
		allSystems = linuxSystems ++ darwinSystems;
		forAllSystems = function:
			nixpkgs.lib.attrsets.genAttrs allSystems (system: function nixpkgs.legacyPackages.${system});
	in {
		packages = forAllSystems (pkgs: {
			default = pkgs.callPackage ./default.nix {
				llvmPackages = pkgs.llvmPackages_18;
			};
		});
	};
}
