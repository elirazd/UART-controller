transcript off
onerror abort
echo "------- START OF SCRIPT -------"
restart -force
noview *
view signals
view wave
add wave *
view list
configure list -delta collapse
add list *
# ====== start of stimulus section ======

force clk 1 , 0 50 ns -r 100 ns
#############

####reset 
force resetN 0
run 100 ns

#### get an input 
force resetN 1 -r 100 ns
force write_din 1
force din 10100101
run 100 ns

#### write_din start bit
force write_din 0
run 22 us

#### contiue
force write_din 0
run 176 us

#### write_din stop bit
force write_din 0
run 44 us

#### get an input 
force resetN 1 -r 100 ns
force write_din 1
force din 10100101
run 100 ns

#### write_din start bit
force write_din 0
run 22 us

#### contiue
force write_din 0
run 176 us

#### write_din stop bit
force write_din 0
run 22 us

# ======= end of stimulus section =======
echo "------- END OF SCRIPT -------"
echo "The time now is $now [string trim $resolution 01]"
