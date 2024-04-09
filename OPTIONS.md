# Options

<h3>services.opengfw.enable</h3>
<dd>
<p>Whether to enable OpenGFW, A flexible, easy-to-use, open source implementation of GFW on Linux
.</p>

<p><span class="emphasis"><em>Type:</em></span>
boolean</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">false</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">true</code></p>

</dd>

---
<h3>services.opengfw.package</h3>
<dd>
<p>The opengfw package to use.</p>

<p><span class="emphasis"><em>Type:</em></span>
package</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">pkgs.opengfw</code></p>

</dd>

---
<h3>services.opengfw.dir</h3>
<dd>
<p>Working directory of the OpenGFW service and home of <code class="literal">opengfw.user</code>.</p>

<p><span class="emphasis"><em>Type:</em></span>
(optionally newline-terminated) single-line string</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;/var/lib/opengfw&quot;</code></p>

</dd>

---
<h3>services.opengfw.logFile</h3>
<dd>
<p>File to write the output to instead of systemd.</p>

<p><span class="emphasis"><em>Type:</em></span>
null or path</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;/var/lib/opengfw/opengfw.log&quot;</code></p>

</dd>

---
<h3>services.opengfw.logFormat</h3>
<dd>
<p>Format of the logs. <a class="link" href="https://github.com/apernet/OpenGFW/blob/d7737e92117a11c9a6100d53019fac3b9d724fe3/cmd/root.go#L62"  target="_top">logFormatMap</a></p>

<p><span class="emphasis"><em>Type:</em></span>
one of “json”, “console”</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;json&quot;</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;console&quot;</code></p>

</dd>

---
<h3>services.opengfw.logLevel</h3>
<dd>
<p>Level of the logs. <a class="link" href="https://github.com/apernet/OpenGFW/blob/d7737e92117a11c9a6100d53019fac3b9d724fe3/cmd/root.go#L55"  target="_top">logLevelMap</a></p>

<p><span class="emphasis"><em>Type:</em></span>
one of “debug”, “info”, “warn”, “error”</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;info&quot;</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;warn&quot;</code></p>

</dd>

---
<h3>services.opengfw.rules</h3>
<dd>
<p>Rules passed to OpenGFW. <a class="link" href="https://gfw.dev/docs/rules"  target="_top">Example rules</a></p>

<p><span class="emphasis"><em>Type:</em></span>
list of (submodule)</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">[ ]</code></p>

<p><span class="emphasis"><em>Example:</em></span></p><pre><code class="programlisting">[
  {
    action = &quot;block&quot;;
    expr = &quot;string(http?.req?.headers?.host) endsWith \&quot;v2ex.com\&quot;&quot;;
    name = &quot;block v2ex http&quot;;
  }
  {
    action = &quot;block&quot;;
    expr = &quot;string(socks?.req?.addr) endsWith \&quot;google.com\&quot; &amp;&amp; socks?.req?.port == 80&quot;;
    name = &quot;block google socks&quot;;
  }
  {
    action = &quot;modify&quot;;
    expr = &quot;dns != nil &amp;&amp; dns.qr &amp;&amp; any(dns.questions, {.name endsWith \&quot;v2ex.com\&quot;})&quot;;
    modifier = {
      args = {
        a = &quot;0.0.0.0&quot;;
        aaaa = &quot;::&quot;;
      };
      name = &quot;dns&quot;;
    };
    name = &quot;v2ex dns poisoning&quot;;
  }
]
</code></pre>

</dd>

---
<h3>services.opengfw.rules.*.action</h3>
<dd>
<p>Action of the rule. <a class="link" href="https://gfw.dev/docs/rules#supported-actions"  target="_top">Supported actions</a></p>

<p><span class="emphasis"><em>Type:</em></span>
one of “allow”, “block”, “drop”, “modify”</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;allow&quot;</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;block&quot;</code></p>

</dd>

---
<h3>services.opengfw.rules.*.expr</h3>
<dd>
<p><a class="link" href="https://expr-lang.org/docs/language-definition"  target="_top">Expr Language</a> expression using <a class="link" href="https://gfw.dev/docs/analyzers"  target="_top">analyzers</a> and <a class="link" href="https://gfw.dev/docs/functions"  target="_top">functions</a>.</p>

<p><span class="emphasis"><em>Type:</em></span>
string</p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;dns != nil &amp;&amp; dns.qr &amp;&amp; any(dns.questions, {.name endsWith \&quot;google.com\&quot;})&quot;</code></p>

</dd>

---
<h3>services.opengfw.rules.*.log</h3>
<dd>
<p>Wether to enable logging for the rule.</p>

<p><span class="emphasis"><em>Type:</em></span>
boolean</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">true</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">false</code></p>

</dd>

---
<h3>services.opengfw.rules.*.modifier</h3>
<dd>
<p>Modification of specified packets when using the <code class="literal">modify</code> action. <a class="link" href="https://github.com/apernet/OpenGFW/tree/master/modifier"  target="_top">Available modifiers</a></p>

<p><span class="emphasis"><em>Type:</em></span>
null or (submodule)</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.rules.*.modifier.args</h3>
<dd>
<p>Arguments passed to the modifier.</p>

<p><span class="emphasis"><em>Type:</em></span>
attribute set</p>

<p><span class="emphasis"><em>Example:</em></span></p><pre><code class="programlisting">{
  a = &quot;0.0.0.0&quot;;
  aaaa = &quot;::&quot;;
}
</code></pre>

</dd>

---
<h3>services.opengfw.rules.*.modifier.name</h3>
<dd>
<p>Name of the modifier.</p>

<p><span class="emphasis"><em>Type:</em></span>
(optionally newline-terminated) single-line string</p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;dns&quot;</code></p>

</dd>

---
<h3>services.opengfw.rules.*.name</h3>
<dd>
<p>Name of the rule.</p>

<p><span class="emphasis"><em>Type:</em></span>
(optionally newline-terminated) single-line string</p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;block google dns&quot;</code></p>

</dd>

---
<h3>services.opengfw.rulesFile</h3>
<dd>
<p>Path to file containing OpenGFW rules.</p>

<p><span class="emphasis"><em>Type:</em></span>
null or path</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.settings</h3>
<dd>
<p>Settings passed to OpenGFW. <a class="link" href="https://gfw.dev/docs/build-run/#config-example"  target="_top">Example config</a></p>

<p><span class="emphasis"><em>Type:</em></span>
null or (submodule)</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.settings.geo</h3>
<dd>
<p>The path to load specific local geoip/geosite db files.
If not set, they will be automatically downloaded from (Loyalsoldier/v2ray-rules-dat)[https://github.com/Loyalsoldier/v2ray-rules-dat].</p>

<p><span class="emphasis"><em>Type:</em></span>
submodule</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">{ }</code></p>

</dd>

---
<h3>services.opengfw.settings.geo.geoip</h3>
<dd>
<p>Path to <code class="literal">geoip.dat</code>.</p>

<p><span class="emphasis"><em>Type:</em></span>
null or path</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.settings.geo.geosite</h3>
<dd>
<p>Path to <code class="literal">geosite.dat</code>.</p>

<p><span class="emphasis"><em>Type:</em></span>
null or path</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.settings.io</h3>
<dd>
<p>IO settings.</p>

<p><span class="emphasis"><em>Type:</em></span>
submodule</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">{ }</code></p>

</dd>

---
<h3>services.opengfw.settings.io.local</h3>
<dd>
<p>Set to false if you want to run OpenGFW on FORWARD chain. (e.g. on a router)</p>

<p><span class="emphasis"><em>Type:</em></span>
boolean</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">true</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">false</code></p>

</dd>

---
<h3>services.opengfw.settings.io.queueSize</h3>
<dd>
<p>IO queue size.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">1024</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">2048</code></p>

</dd>

---
<h3>services.opengfw.settings.io.rcvBuf</h3>
<dd>
<p>Netlink receive buffer size.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">4194304</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">2097152</code></p>

</dd>

---
<h3>services.opengfw.settings.io.rst</h3>
<dd>
<p>Set to true if you want to send RST for blocked TCP connections, needs <code class="literal">local = false</code>.</p>

<p><span class="emphasis"><em>Type:</em></span>
boolean</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;!config.services.opengfw.settings.io.local&quot;</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">false</code></p>

</dd>

---
<h3>services.opengfw.settings.io.sndBuf</h3>
<dd>
<p>Netlink send buffer size.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">4194304</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">2097152</code></p>

</dd>

---
<h3>services.opengfw.settings.workers</h3>
<dd>
<p>Worker settings.</p>

<p><span class="emphasis"><em>Type:</em></span>
submodule</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">{ }</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.count</h3>
<dd>
<p>Number of workers.
Recommended to be no more than the number of CPU cores</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">4</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">8</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.queueSize</h3>
<dd>
<p>Worker queue size.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">16</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">32</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.tcpMaxBufferedPagesPerConn</h3>
<dd>
<p>TCP max total bufferd pages per connection.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">64</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">128</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.tcpMaxBufferedPagesTotal</h3>
<dd>
<p>TCP max total buffered pages.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">4096</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">8192</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.tcpTimeout</h3>
<dd>
<p>How long a connection is considered dead when no data is being transferred.
Dead connections are purged from TCP reassembly pools once per minute.</p>

<p><span class="emphasis"><em>Type:</em></span>
string</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;10m&quot;</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">&quot;5m&quot;</code></p>

</dd>

---
<h3>services.opengfw.settings.workers.udpMaxStreams</h3>
<dd>
<p>UDP max streams.</p>

<p><span class="emphasis"><em>Type:</em></span>
signed integer</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">4096</code></p>

<p><span class="emphasis"><em>Example:</em></span>
<code class="literal">8192</code></p>

</dd>

---
<h3>services.opengfw.settingsFile</h3>
<dd>
<p>Path to file containing OpenGFW settings.</p>

<p><span class="emphasis"><em>Type:</em></span>
null or path</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">null</code></p>

</dd>

---
<h3>services.opengfw.user</h3>
<dd>
<p>Username of the OpenGFW user.</p>

<p><span class="emphasis"><em>Type:</em></span>
(optionally newline-terminated) single-line string</p>

<p><span class="emphasis"><em>Default:</em></span>
<code class="literal">&quot;opengfw&quot;</code></p>

</dd>
