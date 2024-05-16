# Options 
### services.opengfw.dir
> Working directory of the OpenGFW service and home of `opengfw.user`.
+ **Type:** (optionally newline-terminated) single-line string
+ **Default:** "/var/lib/opengfw"
 
### services.opengfw.enable
> Whether to enable OpenGFW, A flexible, easy-to-use, open source implementation of GFW on Linux
.
+ **Type:** boolean
+ **Default:** false
+ **Example:** true
 
### services.opengfw.logFile
> File to write the output to instead of systemd.
+ **Type:** null or path
+ **Default:** null
+ **Example:** "/var/lib/opengfw/opengfw.log"
 
### services.opengfw.logFormat
> Format of the logs. [logFormatMap](https://github.com/apernet/OpenGFW/blob/d7737e92117a11c9a6100d53019fac3b9d724fe3/cmd/root.go#L62)
+ **Type:** one of "json", "console"
+ **Default:** "json"
+ **Example:** "console"
 
### services.opengfw.logLevel
> Level of the logs. [logLevelMap](https://github.com/apernet/OpenGFW/blob/d7737e92117a11c9a6100d53019fac3b9d724fe3/cmd/root.go#L55)
+ **Type:** one of "debug", "info", "warn", "error"
+ **Default:** "info"
+ **Example:** "warn"
 
### services.opengfw.package
> The opengfw package to use.
+ **Type:** package
+ **Default:** pkgs.opengfw
 
### services.opengfw.pcapReplay
> Path to PCAP replay file.
In pcap mode, none of the actions in the rules have any effect.
This mode is mainly for debugging.
+ **Type:** null or path
+ **Default:** null
+ **Example:** "./opengfw.pcap"
 
### services.opengfw.rules
> Rules passed to OpenGFW. [Example rules](https://gfw.dev/docs/rules)
+ **Type:** list of (submodule)
+ **Default:** [ ]
+ **Example:** [
  {
    action = "block";
    expr = "string(http?.req?.headers?.host) endsWith \"v2ex.com\"";
    name = "block v2ex http";
  }
  {
    action = "block";
    expr = "string(socks?.req?.addr) endsWith \"google.com\" && socks?.req?.port == 80";
    name = "block google socks";
  }
  {
    action = "modify";
    expr = "dns != nil && dns.qr && any(dns.questions, {.name endsWith \"v2ex.com\"})";
    modifier = {
      args = {
        a = "0.0.0.0";
        aaaa = "::";
      };
      name = "dns";
    };
    name = "v2ex dns poisoning";
  }
]
 
### services.opengfw.rules.*.action
> Action of the rule. [Supported actions](https://gfw.dev/docs/rules#supported-actions)
+ **Type:** one of "allow", "block", "drop", "modify"
+ **Default:** "allow"
+ **Example:** "block"
 
### services.opengfw.rules.*.expr
> [Expr Language](https://expr-lang.org/docs/language-definition) expression using [analyzers](https://gfw.dev/docs/analyzers) and [functions](https://gfw.dev/docs/functions).
+ **Type:** string
+ **Example:** "dns != nil && dns.qr && any(dns.questions, {.name endsWith \"google.com\"})"
 
### services.opengfw.rules.*.log
> Whether to enable logging for the rule.
+ **Type:** boolean
+ **Default:** true
+ **Example:** false
 
### services.opengfw.rules.*.modifier
> Modification of specified packets when using the `modify` action. [Available modifiers](https://github.com/apernet/OpenGFW/tree/master/modifier)
+ **Type:** null or (submodule)
+ **Default:** null
 
### services.opengfw.rules.*.modifier.args
> Arguments passed to the modifier.
+ **Type:** attribute set
+ **Example:** {
  a = "0.0.0.0";
  aaaa = "::";
}
 
### services.opengfw.rules.*.modifier.name
> Name of the modifier.
+ **Type:** (optionally newline-terminated) single-line string
+ **Example:** "dns"
 
### services.opengfw.rules.*.name
> Name of the rule.
+ **Type:** (optionally newline-terminated) single-line string
+ **Example:** "block google dns"
 
### services.opengfw.rulesFile
> Path to file containing OpenGFW rules.
+ **Type:** null or path
+ **Default:** null
 
### services.opengfw.settings
> Settings passed to OpenGFW. [Example config](https://gfw.dev/docs/build-run/#config-example)
+ **Type:** null or (submodule)
+ **Default:** null
 
### services.opengfw.settings.io
> IO settings.
+ **Type:** submodule
+ **Default:** { }
 
### services.opengfw.settings.io.local
> Set to false if you want to run OpenGFW on FORWARD chain. (e.g. on a router)
+ **Type:** boolean
+ **Default:** true
+ **Example:** false
 
### services.opengfw.settings.io.queueSize
> IO queue size.
+ **Type:** signed integer
+ **Default:** 1024
+ **Example:** 2048
 
### services.opengfw.settings.io.rcvBuf
> Netlink receive buffer size.
+ **Type:** signed integer
+ **Default:** 4194304
+ **Example:** 2097152
 
### services.opengfw.settings.io.rst
> Set to true if you want to send RST for blocked TCP connections, needs `local = false`.
+ **Type:** boolean
+ **Default:** "`!config.services.opengfw.settings.io.local`"
+ **Example:** false
 
### services.opengfw.settings.io.sndBuf
> Netlink send buffer size.
+ **Type:** signed integer
+ **Default:** 4194304
+ **Example:** 2097152
 
### services.opengfw.settings.replay
> PCAP replay settings.
+ **Type:** submodule
+ **Default:** { }
 
### services.opengfw.settings.replay.realtime
> Whether the packets in the PCAP file should be replayed in "real time" (instead of as fast as possible).
+ **Type:** boolean
+ **Default:** false
+ **Example:** true
 
### services.opengfw.settings.ruleset
> The path to load specific local geoip/geosite db files.
If not set, they will be automatically downloaded from [Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat).
+ **Type:** submodule
+ **Default:** { }
 
### services.opengfw.settings.ruleset.geoip
> Path to `geoip.dat`.
+ **Type:** null or path
+ **Default:** null
 
### services.opengfw.settings.ruleset.geosite
> Path to `geosite.dat`.
+ **Type:** null or path
+ **Default:** null
 
### services.opengfw.settings.workers
> Worker settings.
+ **Type:** submodule
+ **Default:** { }
 
### services.opengfw.settings.workers.count
> Number of workers.
Recommended to be no more than the number of CPU cores
+ **Type:** signed integer
+ **Default:** 4
+ **Example:** 8
 
### services.opengfw.settings.workers.queueSize
> Worker queue size.
+ **Type:** signed integer
+ **Default:** 16
+ **Example:** 32
 
### services.opengfw.settings.workers.tcpMaxBufferedPagesPerConn
> TCP max total bufferd pages per connection.
+ **Type:** signed integer
+ **Default:** 64
+ **Example:** 128
 
### services.opengfw.settings.workers.tcpMaxBufferedPagesTotal
> TCP max total buffered pages.
+ **Type:** signed integer
+ **Default:** 4096
+ **Example:** 8192
 
### services.opengfw.settings.workers.tcpTimeout
> How long a connection is considered dead when no data is being transferred.
Dead connections are purged from TCP reassembly pools once per minute.
+ **Type:** string
+ **Default:** "10m"
+ **Example:** "5m"
 
### services.opengfw.settings.workers.udpMaxStreams
> UDP max streams.
+ **Type:** signed integer
+ **Default:** 4096
+ **Example:** 8192
 
### services.opengfw.settingsFile
> Path to file containing OpenGFW settings.
+ **Type:** null or path
+ **Default:** null
 
### services.opengfw.user
> Username of the OpenGFW user.
+ **Type:** (optionally newline-terminated) single-line string
+ **Default:** "opengfw"
