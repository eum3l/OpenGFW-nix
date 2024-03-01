{
  lib,
  buildGoModule,
  src,
}:
buildGoModule rec {
  pname = "opengfw";
  version = "0.2.3";

  inherit src;
  vendorHash = "sha256-NT9KJFodTjd2HVTGDEnhfcdtl9UNaqzwTwwMHoujmAo=";
  doCheck = false;

  meta = with lib; {
    mainProgram = "OpenGFW";
    description = "A flexible, easy-to-use, open source implementation of GFW on Linux";
    longDescription = ''
      OpenGFW is your very own DIY Great Firewall of China, available as a flexible,
      easy-to-use open source program on Linux. Why let the powers that be have all the fun? 
      It's time to give power to the people and democratize censorship. 
      Bring the thrill of cyber-sovereignty right into your home router 
      and start filtering like a pro - you too can play Big Brother.
    '';
    homepage = "https://github.com/apernet/OpenGFW";
    license = licenses.mpl20;
    platforms = platforms.linux;
  };
}
