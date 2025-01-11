{
	pkgs ? import <nixpkgs> { },
	lib ? pkgs.lib,
	llvmPackages ? pkgs.llvmPackages_18,
}:

let
	stdenv = llvmPackages.stdenv;
in stdenv.mkDerivation (finalAttrs: {
	name = "test-ffi-clang-dlang-ldc-llvm";

	src = ./src;

	buildInputs = [
		llvmPackages.llvm
		(pkgs.ldc.override { llvm_18 = llvmPackages.llvm; })
	];

	buildPhase = ''
		ldc2 -c calc.d
		clang -c main.c
		mkdir -p $out/bin
		clang main.o calc.o -o $out/bin/program
	'';

	meta = {
		mainProgram = "program";
	};
})
