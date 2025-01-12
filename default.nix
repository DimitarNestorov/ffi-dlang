{
	pkgs ? import <nixpkgs> { },
	lib ? pkgs.lib,
	stdenvNoCC ? pkgs.stdenvNoCC,
	llvmPackages ? pkgs.llvmPackages_18,
	target ? stdenvNoCC.hostPlatform.config,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
	name = "test-ffi-clang-dlang-ldc-llvm";

	src = ./src;

	buildInputs = [
		(pkgs.zig.override { inherit llvmPackages; })
		(pkgs.ldc.override { llvm_18 = llvmPackages.llvm; })
	];

	buildPhase = ''
		export ZIG_GLOBAL_CACHE_DIR=$(mktemp -d)
		ldc2 -c calc.d
		zig cc -c main.c
		mkdir -p $out/bin
		zig build-exe calc.o main.o -lc -femit-bin=$out/bin/program
	'';

	meta = {
		mainProgram = "program";
	};
})
