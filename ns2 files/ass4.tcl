# 99 nodes in total, Wi-Fi
 Priority queue size <= 43,
 TCP Reno / UDP size = 1023B

# 3 base stations: station-6 (20%), station-29 (30%) and station-66 (50%)


set val(chan)       Channel/WirelessChannel         ;
# channel type

set val(prop)       Propagation/TwoRayGround    ;
# radio-propagation model

set val(ant)        Antenna/OmniAntenna              ;
# antenna type

set val(ll)                LL                                                ;
# link layer type

set val(ifq)        Queue/DropTail/PriQueue           ;
# interface queue type

set val(ifqlen)     43                                                   ;
# max packet in ifq

set val(netif)      Phy/WirelessPhy                          ;
# network interface type

set val(mac)        Mac/802_11                                ;
# MAC type

set val(rp)             DSDV                                           ;
# rass4ing (none)
set val(nn)        96                               ;
#
set val(x)         600                             ;
#set val(y)         500 

                            ;
#Create a simulator object

set ns [new Simulator]



#Open the NAM trace file

set nf [open ass4.nam w]

$ns namtrace-all-wireless  $nf $val(x) $val(y)



#Trace File creation

set tf [open ass4.tr w]



#Tracing all the events and cofiguration

$ns trace-all $tf


set topo [new Topography]

$topo load_flatgrid $val(x) $val(y)


create-god $val(nn)


$ns node-config -adhocRass4ing 

$val(rp) 
\
		 -llType $val(ll)
 \
		 -macType $val(mac)
 \
		 -ifqType $val(ifq)
 \
		 -ifqLen $val(ifqlen)
 \
		 -antType $val(ant)
 \
		 -propType $val(prop)
 \
		 -phyType $val(netif)
 \
		 -channelType $val(chan)
 \
		 -topoInstance $topo 
\
		 -agentTrace ON 
\
		 -rass4erTrace ON
 \
		 -macTrace OFF 
\
		 -movementTrace ON




#Define a 'finish' procedure

proc finish {} {
        
global ns nf
 
 $ns flush-trace
      
  #Close the NAM trace file
      
  close $nf
        
  #Execute NAM on the trace file
     
   exec nam ass4.nam &
        
exit 0



# base stations

set s6 [$ns node]

set s29 [$ns node]

set s66 [$ns node]


$s6 set X_ 250

$s6 set Y_ 150

$s6 set Z_ 0


$s29 set X_ 130

$s29 set Y_ 220

$s29 set Z_ 0


$s66 set X_ 320

$s66 set Y_ 350

$s66 set Z_ 0


$ns initial_node_pos $s6 40

$ns initial_node_pos $s29 40

$ns initial_node_pos $s66 40




for {set i 0} {$i < 28} {incr i}
 {
	set camera($i) [$ns node]
	
     $ns at 0.0 "$camera($i) label 
     \"camera-$i\""
	
    $camera($i) set X_ [expr rand()*600]
    $camera($i) set Y_ [expr rand()*500]

    $camera($i) set Z_ 0
	


    $ns initial_node_pos $camera($i) 30

	
    set tcp($i) [new Agent/TCP/Reno]

    $tcp($i) set class_ 2
	
    $ns attach-agent $camera($i) $tcp($i)

    set sink($i) [new Agent/TCPSink]
	
    $ns attach-agent $s29 $sink($i)
	
    $ns connect $tcp($i) $sink($i)


	
    set cbr($i) [new Application/Traffic/CBR]
	
    $cbr($i) attach-agent $tcp($i)
	
    $cbr($i) set type_ CBR
	
    $cbr($i) set packet_size_ 1023
	
    $cbr($i) set rate_ 1mb
	
    $cbr($i) set random_ false

	
    $ns at 0.1 "$cbr($i) start"
	
    $ns at 4.5 "$cbr($i) stop"
}







   for {set i 28} {$i < 48} {incr i} 
    {
	set guard($i) [$ns node]
	
    $ns at 0.0 "$guard($i) label \"guard-$i\""

    $guard($i) set X_ [expr rand()*600]

    $guard($i) set Y_ [expr rand()*500]

    $guard($i) set Z_ 0
	

    $ns initial_node_pos $guard($i) 30

	
    set tcp($i) [new Agent/TCP/Reno]

    $tcp($i) set class_ 2
	
    $ns attach-agent $guard($i) $tcp($i)
	
    set sink($i) [new Agent/TCPSink]
	
    $ns attach-agent $s6 $sink($i)
	
    $ns connect $tcp($i) $sink($i)


	
    set cbr($i) [new Application/Traffic/CBR]

    $cbr($i) attach-agent $tcp($i)
	
    $cbr($i) set type_ CBR
	
    $cbr($i) set packet_size_ 1023
	
    $cbr($i) set rate_ 1mb
	
    $cbr($i) set random_ false


    $ns at 0.1 "$cbr($i) start"

    $ns at 4.5 "$cbr($i) stop"
}





    for {set i 48} {$i < 96} {incr i} 
{
	set prison($i) [$ns node]
	
     $ns at 0.0 "$prison($i) label \"prison-$i\""

    $prison($i) set X_ [expr rand()*500]
	
$prison($i) set Y_ [expr rand()*400]

	$prison($i) set Z_ 0
	
$ns initial_node_pos $prison($i) 30


	set tcp($i) [new Agent/TCP/Reno]
	
$tcp($i) set class_ 2
	
$ns attach-agent $prison($i) $tcp($i)

	set sink($i) [new Agent/TCPSink]

	$ns attach-agent $s66 $sink($i)

	$ns connect $tcp($i) $sink($i)


	set cbr($i) [new Application/Traffic/CBR]

	$cbr($i) attach-agent $tcp($i)
	$cbr($i)
 set type_ CBR
	$
cbr($i) set packet_size_ 1023

	$cbr($i) set rate_ 1mb
	
$cbr($i) set random_ false

	
$ns at 0.1 "$cbr($i) start"
	
$ns at 4.5 "$cbr($i) stop"
}




#Call the finish procedure after 5 seconds of simulation time


$ns at 5 "$ns nam-end-wireless 5"

$ns at 5.0 "finish"



#Run the simulation

$ns run

