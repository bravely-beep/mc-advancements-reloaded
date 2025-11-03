{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }:
    let 
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      devShells."x86_64-linux".default = pkgs.mkShell rec {
        buildInputs = with pkgs; [
          # Java
          jdk
          # GL
          libGL
          glfw3-minecraft
          # Audio
          libpulseaudio
          openal
          flite
        ];
        LD_LIBRARY_PATH = with pkgs; pkgs.lib.makeLibraryPath buildInputs;
        # Add Java library path for native libraries
        shellHook = ''
          export JAVA_OPTS="-Djava.library.path=${LD_LIBRARY_PATH}"
        '';
      };
    };
}