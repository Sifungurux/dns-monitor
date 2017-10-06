set autoscale
unset log
unset label
set title "DNS RESPONSE"
set xlabel "Dns resolutions"
set ylabel "Response in seconds"
set terminal png size 800,600
set output 'dns.png'
plot '/var/log/dns-query.log' using 0:3 with lines
