{ ... }:
let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  nixpkgs = import sources.nixpkgs { };
in with nixpkgs;
stdenv.mkDerivation {
  name = "slides";
  buildInputs = [ elmPackages.elm elmPackages.elm-format niv.niv nodePackages.npm nodejs-12_x python3 ];
}
