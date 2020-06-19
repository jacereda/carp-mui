with import <nixpkgs> {};
{
  shellEnv =
    let
      carp = callPackage ../Carp/default.nix {};
      linuxLibs = [ wayland egl-wayland libGL libxkbcommon libffi];
      mylibs = stdenv.lib.optionals stdenv.isLinux linuxLibs;
      libs = with pkgs; lib.makeLibraryPath mylibs;
    in
      stdenvNoLibs.mkDerivation {
        name = "shell-environment";
        nativeBuildInputs = with pkgs; [ pkg-config tinycc clang strace git ];
        buildInputs = mylibs;
        PATH="${carp}/bin";
        LIBRARY_PATH=libs;
        LD_LIBRARY_PATH=libs;
      };
}
