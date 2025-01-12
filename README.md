# Simple FFI of D functions in C

Built with LLVM

## Build

```sh
nix build
```

## Run

```sh
nix run
```

## Cross compile

### For macOS x86_64

```sh
nix build .#cross.aarch64-darwin.x86_64-apple-darwin
```

### For Windows x86_64

```sh
nix build .#cross.aarch64-darwin.x86_64-w64-mingw32
```

### For Windows aarch64

```sh
nix build .#cross.aarch64-darwin.aarch64-w64-mingw32
```

### For Windows i686

```sh
nix build .#cross.aarch64-darwin.i686-w64-mingw32
```

### For Linux x86_64

```sh
nix build .#cross.aarch64-darwin.x86_64-unknown-linux-gnu
```

### For Linux aarch64

```sh
nix build .#cross.aarch64-darwin.aarch64-unknown-linux-gnu
```

### For Linux i686

```sh
nix build .#cross.aarch64-darwin.i686-unknown-linux-gnu
```
