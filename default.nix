with import <nixpkgs> {};
{
  shellEnv =
    let
      mylibs = [ libGL glfw-wayland ];
      xlibs = with pkgs.xorg; [ libX11 libXext libxcb libXau libXdmcp ];
      libs = with pkgs; lib.makeLibraryPath (mylibs ++ glfw-wayland.propagatedBuildInputs ++ xlibs);
    in
      stdenvNoLibs.mkDerivation {
        name = "shell-environment";
        nativeBuildInputs = with pkgs; [ pkg-config tinycc clang strace ];
        buildInputs = mylibs;
        CARP_DIR="../Carp";
        PATH="../Carp/dist-newstyle/build/x86_64-linux/ghc-8.8.3/CarpHask-0.3.0.0/x/carp/build/carp";
        LIBRARY_PATH=libs;
        LD_LIBRARY_PATH=libs;
      };
}
