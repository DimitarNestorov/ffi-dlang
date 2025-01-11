{
	description = "FFI D functions in C";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
	};

	outputs = { self, nixpkgs }: 
	let
		pkgs = nixpkgs.legacyPackages."aarch64-darwin";
	in {
		packages."aarch64-darwin".default = pkgs.callPackage ./default.nix {
			llvmPackages = pkgs.llvmPackages_18;
		};
	};
}
