{
	pkgs ? import <nixpkgs> { },
	lib ? pkgs.lib,
	stdenvNoCC ? pkgs.stdenvNoCC,
	llvmPackages ? pkgs.llvmPackages_18,
	target ? stdenvNoCC.hostPlatform,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
	name = "test-ffi-clang-dlang-ldc-llvm";

	src = ./src;

	buildInputs = [
		(pkgs.zig.override { inherit llvmPackages; })
		(pkgs.ldc.override { llvm_18 = llvmPackages.llvm; })
	];

	buildPhase = let
		zigTarget = (import ./utils.nix { inherit lib; }).nixTargetToZigTarget target.parsed;
		program = if target.isWindows then "program.exe" else "program";
	in ''
		export ZIG_GLOBAL_CACHE_DIR=$(mktemp -d)
		ldc2 -mtriple=${target.config} -c calc.d
		zig cc -target ${zigTarget} -c main.c -o main.o
		mkdir -p $out/bin
		zig build-exe calc.o main.o -lc -target ${zigTarget} -femit-bin=$out/bin/${program}
	'';

	meta = {
		mainProgram = "program";
	};
})
