# Define setting options
set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         45                         ;# max packet in ifq
set val(nn)             135                        ;# number of mobilenodes
set val(rp)             AODV                       ;# routing protocol
set val(x)              300                        ;# X dimension of topography
set val(y)              300                        ;# Y dimension of topography 
set val(stop)           10                   	   ;# time of simulation end
set packet_size 	1023				;#packet size 256

set ns              [new Simulator]

#Creating nam and trace file:
set tracefd       [open assignment5_3.tr w]
set namtrace      [open assignment5_3.nam w]   

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

set god_ [create-god $val(nn)]

# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON
                   
## Creating nodes      	
for {set i 0} {$i < $val(nn)} {incr i} {
  set node_($i) [$ns node]     
}
      
$node_(0) label "BaseStation 1"
$node_(1) label "BaseStation 2"

## Label and color nodes
for {set i 2} {$i < 10} {incr i} {
  $node_($i) color cyan
  $ns at 0.0 "$node_($i) color cyan"
  $node_($i) label "cafeteria$i"
}

for {set i 10} {$i < 20} {incr i} {
  $node_($i) color red
  $ns at 0.0 "$node_($i) color purple"
  $node_($i) label "block$i"
}

for {set i 20} {$i < 40} {incr i} {
  $node_($i) color red
  $ns at 0.0 "$node_($i) color blue"
  $node_($i) label "guard$i"
}

for {set i 40} {$i < 80} {incr i} {
  $node_($i) color red
  $ns at 0.0 "$node_($i) color green"
  $node_($i) label "office$i"
}

for {set i 80} {$i < 120} {incr i} {
  $node_($i) color aqua
  $ns at 0.0 "$node_($i) color orange"
  $node_($i) label "misc$i"
}


## Provide initial location of mobilenodes..
for {set i 0} {$i < $val(nn) } { incr i } {
  set xx [expr rand()*500]
  set yy [expr rand()*500]
  $node_($i) set X_ $xx
  $node_($i) set Y_ $yy
}

# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
$ns initial_node_pos $node_($i) 50
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}

# dynamic destination setting procedure..
$ns at 0.0 "destination"
proc destination {} {
      global ns val node_
      set time 1.0
      set now [$ns now]
      for {set i 0} {$i<$val(nn)} {incr i} {
            set xx [expr rand()*300]
            set yy [expr rand()*300]
            $ns at $now "$node_($i) setdest $xx $yy 10.0"
      }
      $ns at [expr $now+$time] "destination"
}


#stop procedure..
$ns at $val(stop) "stop"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
exec nam assignment5_3.nam &
}

$ns run
