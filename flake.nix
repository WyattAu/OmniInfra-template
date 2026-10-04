{
  # OmniInfra dev environment — nix owns the IaC gate toolchain.
  description = "OmniInfra-template development environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            opentofu
            tflint
            conftest
            terraform-docs
            trivy
            sops
            age
            git
          ];
        };
      });
    };
}
