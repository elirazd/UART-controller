transcript off
onerror abort
echo "------- START OF SCRIPT -------"
vcom tcount.vhd
vcom dcount.vhd
vcom outff.vhd
vcom smt.vhd
vcom dint.vhd
vcom tb_transmitter.vhd
vsim tb_transmitter
restart -force
noview *
view signals
view wave
add wave *

view list
configure list -delta collapse
add list *
# ====== start of stimulus section ======
force clk 0 , 1 20 ns -r 40 ns
run 140 us

# ======= end of stimulus section =======
echo "------- END OF SCRIPT -------"
echo "The time now is $now [string trim $resolution 01]"
