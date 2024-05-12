{ testers, opengfw, ... }:
let
  logFile = "/var/lib/opengfw/opengfw.log";
in
testers.runNixOSTest {
  name = "OpenGFW Test";
  nodes.machine =
    { pkgs, ... }:
    {
      imports = [ opengfw ];

      services.opengfw = {
        inherit logFile;
        enable = true;
        pcapReplay = ./test.pcap;
        settings = { };
        rules = [
          {
            name = "google dns poisoning";
            action = "modify";
            modifier = {
              name = "dns";
              args = {
                a = "127.0.0.1";
                aaaa = "::";
              };
            };
            expr = ''dns != nil && dns.qr && any(dns.questions, {.name endsWith "google.com"})'';
          }
        ];
      };
    };

  testScript = ''
    machine.wait_for_unit("opengfw.service")
    machine.wait_until_fails("systemctl is-active opengfw.service")
    machine.copy_from_vm("${logFile}")
  '';
}
