{
  lib,
  buildGoModule,
  platforms,
  src,
  version,
}:
buildGoModule {
  inherit version src;
  pname = "opengfw";
  vendorHash = "sha256-x+ZFHk35KKtrZ0rN4Wnj7C2ioCmJynKM0O6+opp9X/k=";

  meta = with lib; {
    inherit platforms;
    mainProgram = "OpenGFW";
    description = "A flexible, easy-to-use, open source implementation of GFW on Linux";
    longDescription = ''
      OpenGFW is your very own DIY Great Firewall of China, available as a flexible,
      easy-to-use open source program on Linux. Why let the powers that be have all the fun?
      It's time to give power to the people and democratize censorship.
      Bring the thrill of cyber-sovereignty right into your home router
      and start filtering like a pro - you too can play Big Brother.
    '';
    homepage = "https://gfw.dev/";
    license = licenses.mpl20;
  };
}
