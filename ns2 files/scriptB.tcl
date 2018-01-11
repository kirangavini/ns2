set val(ifq)        Queue/DropTail           ;# interface queue type
set val(ifqlen)     45                                                   ;# max packet in ifq
set val(rp)             DSDV                                           ;# routing (none)

#Create a simulator object
set ns [new Simulator]

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
        #Close the NAM trace file
        close $nf
        #Execute NAM on the trace file
        exec nam out.nam &
        exit 0
}

#Create four nodes
set n0base [$ns node]
set n1hop1 [$ns node]
set n2hop2 [$ns node]
set n3node8 [$ns node]

#Create links between the nodes
$ns duplex-link $n0base $n1hop1 12MB 9ms DropTail
$ns duplex-link $n1hop1 $n2hop2 12MB 9ms DropTail
$ns duplex-link $n2hop2 $n3node8 12MB 9ms DropTail

for {set i 4} {$i < 14} {incr i} {
	set office($i) [$ns node]
	$ns at 0.0 "$office($i) label \"office-$i\""
	$ns duplex-link $n0base $office($i) 10MB 9ms DropTail
	$ns queue-limit $n0base $office($i) 45

	set tcp($i) [new Agent/TCP]
	$tcp($i) set class_ 2
	$ns attach-agent $n0base $tcp($i)
	set sink($i) [new Agent/TCPSink]
	$ns attach-agent $office($i) $sink($i)
	$ns connect $tcp($i) $sink($i)

	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) attach-agent $tcp($i)
	$cbr($i) set type_ CBR
	$cbr($i) set packet_size_ 1000
	$cbr($i) set rate_ 1mb
	$cbr($i) set random_ false

	$ns at 0.1 "$cbr($i) start"
	$ns at 4.5 "$cbr($i) stop"
}

for {set i 14} {$i < 24} {incr i} {
	set vehicle($i) [$ns node]
	$ns at 0.0 "$vehicle($i) label \"vehicle-$i\""
	$ns duplex-link $n1hop1 $vehicle($i) 6MB 9ms DropTail
	$ns queue-limit $n1hop1 $vehicle($i) 45

	set udp($i) [new Agent/UDP]
	$ns attach-agent $n1hop1 $udp($i)
	set null($i) [new Agent/Null]
	$ns attach-agent $vehicle($i) $null($i)
	$ns connect $udp($i) $null($i)
	$udp($i) set fid_ 2

	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) attach-agent $udp($i)
	$cbr($i) set type_ CBR
	$cbr($i) set packet_size_ 1000
	$cbr($i) set rate_ 1mb
	$cbr($i) set random_ false

	$ns at 0.1 "$cbr($i) start"
	$ns at 4.5 "$cbr($i) stop"
}

for {set i 24} {$i < 34} {incr i} {
	set person($i) [$ns node]
	$ns at 0.0 "$person($i) label \"person-$i\""
	$ns duplex-link $n2hop2 $person($i) 3MB 9ms DropTail
	$ns queue-limit $n2hop2 $person($i) 45

	set udp($i) [new Agent/UDP]
	$ns attach-agent $n2hop2 $udp($i)
	set null($i) [new Agent/Null]
	$ns attach-agent $person($i) $null($i)
	$ns connect $udp($i) $null($i)
	$udp($i) set fid_ 2

	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) attach-agent $udp($i)
	$cbr($i) set type_ CBR
	$cbr($i) set packet_size_ 1000
	$cbr($i) set rate_ 1mb
	$cbr($i) set random_ false

	$ns at 0.1 "$cbr($i) start"
	$ns at 4.5 "$cbr($i) stop"
}

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run

