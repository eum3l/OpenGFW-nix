{
  testers,
  opengfw,
  ...
}: let
  logFile = "/var/lib/opengfw/opengfw.log";
in
  testers.runNixOSTest {
    name = "OpenGFW Test";
    nodes.machine = {pkgs, ...}: {
      imports = [
        opengfw
      ];

      services.opengfw = {
        enable = true;
        inherit logFile;
        settings = {};
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
            expr = ''dns != nil && dns.qr && any(dns.questions, {.name endsWith "one.one"})'';
          }
        ];
      };
    };

    testScript = ''
      machine.wait_for_unit("opengfw.service")
      machine.wait_for_file("${logFile}")
      machine.copy_from_vm("${logFile}")
    '';
  }
