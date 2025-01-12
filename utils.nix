{
	lib ? (import <nixpkgs> { }).lib,
}:
{
	nixTargetToZigTarget = target: with lib; let
		kernel = {
			none = t: "${t.cpu.name}-freestanding-${t.abi.name}";
			linux = t: "${t.cpu.name}-linux-${t.abi.name}";
			darwin = t: "${t.cpu.name}-macos-none";
			ios = t: "${t.cpu.name}-ios-none";
			windows = t: "${t.cpu.name}-windows-gnu";
			wasi = t: "${t.cpu.name}-wasi-musl";
			openbsd = t: "${t.cpu.name}-openbsd-none";
			netbsd = t: "${t.cpu.name}-netbsd-none";
			freebsd = t: "${t.cpu.name}-freebsd-none";
		};
		cpu = {
			armv5tel = s: "thumb-${removePrefix "armv5tel-" s}";
			armv6l = s: "arm-${removePrefix "armv6l-" s}";
			armv7a = s: "arm-${removePrefix "armv7a-" s}";
			armv7l = s: "arm-${removePrefix "armv7l-" s}";
			i686 = s: "x86-${removePrefix "i686-" s}";
		};
	in cpu."${target.cpu.name}" or (_: _) (kernel."${target.kernel.name}" target);
}