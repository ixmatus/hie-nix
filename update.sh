#!/bin/sh

set -xe

# needed since that's how stack2nix finds compiler, etc
NIXPKGS_COMMIT=$(nix-instantiate --eval -E "(builtins.fromJSON (builtins.readFile ./nixpkgs-src.json)).rev")
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/$NIXPKGS_COMMIT.tar.gz

STACK2NIX=$(nix-build -A stack2nix --no-out-link)/bin/stack2nix

COMMIT=1a5640f4790bde364dcd0a61617c5ca5b85b145a
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.6.2.yaml > ghc-8.6.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.4.4.yaml > ghc-8.4.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
