#!/usr/bin/ruby

STDOUT.sync = true # disable buffering

$target_urls = [
  "8.8.8.8",
  "8.8.4.4",
  "4.2.2.2",
  "4.2.2.1",
  "www.google.com",
  "www.yahoo.co.jp",
  "www.bing.com",
  "www.wikipedia.org",
  "www.whitehouse.gov",
  "www.kyoto-u.ac.jp",
  "www.facebook.com",
  "www.akamai.com",
]

$timeout = "/usr/bin/timeout"
$waittime = 1
$ping = "/usr/bin/ping"
$opts = "-c 1"
$redir = ">/dev/null 2>&1"

$interval = 60
$sample_url_num = 4

$logfile = open("log_#{Time.now.strftime("%Y%m%d%H%M%S")}.txt", "w")

def log(time, suc, url)
  $logfile.puts "#{time},#{suc},#{url}"
end

loop do
  time = Time.now

  puts time.to_s
  $target_urls.each do |url|
    suc = system("#{$timeout} #{$waittime} #{$ping} #{$opts} #{url} #{$redir}")
    puts "\t#{suc ? "\e[32mSuccess.\e[0m" : "\e[31mFailure.\e[0m"}\t#{url}"
    log(time, suc, url)
  end

  delta = (time + $interval) - Time.now
  sleep delta if delta > 0
end
