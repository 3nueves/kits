## Kit intall-telegraf

install telegraf

### how to use
````
ikctl -i intall-telegraf -n <name host> -p <HOSTNAME_TELEGRAF> -s sudo
````

````
[agent]
  hostname = "$HOSTNAME_TELEGRAF"
  flush_interval = "15s"
  interval = "15s"
  logfile = "/var/log/telegraf/telegraf.log"
[[inputs.cpu]]
[[inputs.mem]]
[[inputs.system]]
[[inputs.disk]]
  mount_points = ["/"]
[[inputs.processes]]
[[inputs.net]]
  fieldpass = [ "bytes_*" ]
# InfluxDB server config
[[outputs.influxdb]]
  database = "telegraf"
  urls = [ "https://monitor.server.com:80" ]
  insecure_skip_verify = true
````
