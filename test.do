transcript off
onerror abort
echo "------- START OF SCRIPT -------"
restart -force
noview *
view signals
view wave
add wave -r *
add wave -unsigned count
view list
configure list -delta collapse
add list *
# ====== start of stimulus section ======

force clk 1 , 0 50 ns -r 100 ns
#############

####reset 
force clrN 0
run 100 ns

#### start 
force clrN 1 -r 100 ns
force te 1
run 24 us

#### reset counter
force te 0
run 100 ns

#### contiue
force clrN 1 -r 100 ns
force te 1
run 24 us

####reset 
force clrN 0
run 100 ns

# ======= end of stimulus section =======
echo "------- END OF SCRIPT -------"
echo "The time now is $now [string trim $resolution 01]"
