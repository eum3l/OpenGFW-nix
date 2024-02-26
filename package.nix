{
  lib,
  buildGoModule,
  src,
}:
buildGoModule rec {
  pname = "opengfw";
  version = "0.2.2";

  inherit src;
  vendorHash = "sha256-NT9KJFodTjd2HVTGDEnhfcdtl9UNaqzwTwwMHoujmAo=";
  doCheck = false;

  meta = with lib; {
    mainProgram = "OpenGFW";
    description = "A flexible, easy-to-use, open source implementation of GFW on Linux";
    longDescription = ''
      OpenGFW is a flexible, easy-to-use, open source implementation of GFW on Linux
      that's in many ways more powerful than the real thing.
      It's cyber sovereignty you can have on a home router.
    '';
    homepage = "https://github.com/apernet/OpenGFW";
    license = licenses.mpl20;
    platforms = platforms.linux;
  };
}
