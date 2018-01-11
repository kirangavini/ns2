set ns [new Simulator]


set val(chan)       Channel/WirelessChannel         ;
# channel type
set val(prop)       Propagation/TwoRayGround    ;
# radio-propagation model
set val(ant)        Antenna/OmniAntenna              ;
# antenna type
set val(ll)         LL                                                ;
# link layer type
set val(ifq)        Queue/DropTail/PriQueue           ;
# interface queue type
set val(ifqlen)     50                                                   ;
# max packet in ifq
set val(netif)      Phy/WirelessPhy                          ;
# network interface type
set val(mac)        Mac/802_11                                ;
# MAC type
set val(rp)         DSR                                           ;
# routing (none)


#Open the NAM trace file
set nf [open out.nam w]

$ns namtrace-all $nf

$ns color 1 red
$ns color 2 blue
$ns color 3 green

$ns color 4 yellow


#Define a 'finish' procedure

proc finish {} {

          global ns nf 
   
       $ns flush-trace
 
          close $nf
       
          exec nam out.nam &
        
          exit 0
}


#Create nodes

set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]

set n4 [$ns node]

set n5 [$ns node]

set n6 [$ns node]

set n7 [$ns node]

set n8 [$ns node]

set n9 [$ns node]

set n10 [$ns node]

set n11 [$ns node]

set n12 [$ns node]

set n13 [$ns node]

set n14 [$ns node]

set n15 [$ns node]

set n16 [$ns node]

set n17 [$ns node]

set n18 [$ns node]

set n19 [$ns node]

set n20 [$ns node]

set n21 [$ns node]

set n22 [$ns node]

set n23 [$ns node]




#Label nodes


$n0 label "tank"
$n1 label "control building"

$n2 label "infantry 1"

$n3 label "m16 aircraft"

$n4 label "aircraft carrier 1"

$n5 label "infantry 2"

$n6 label "sniper1"

$n7 label "maintenance building"

$n8 label "hospital"

$n9 label "control tower"

$n10 label "infantry 3"

$n11 label "f15 tomcat"

$n12 label "BaseStation"

$n13 label "bomber"

$n14 label "blue angels"

$n15 label "sniper 2"

$n16 label "aircraft carrier 2"

$n17 label "submarine"

$n18 label "helicopter"

$n19 label "sniper 3"

$n20 label "infantry 4"

$n21 label "amunition building"

$n22 label "aicraft carrier 3"

$n23 label "sub-station"


$n0 color "red"
$n1 color "blue"

$n2 color "white"

$n3 color "yellow"

$n4 color "green"

$n5 color "purple"

$n6 color "red"

$n7 color "blue"

$n8 color "white"

$n9 color "yellow"

$n10 color "green"

$n11 color "purple"

$n12 color "red"

$n13 color "blue"

$n14 color "white"

$n15 color "yellow"

$n16 color "green"

$n17 color "purple"

$n18 color "red"

$n19 color "blue"

$n20 color "white"

$n21 color "yellow"

$n22 color "green"

$n23 color "purple"



#Create links between the nodes

$ns duplex-link $n2 $n7 2Mb 5.6ms DropTail

$ns duplex-link $n7 $n11 5Mb 5.6ms DropTail

$ns duplex-link $n11 $n16 1.7Mb 5.6ms DropTail

$ns duplex-link $n16 $n20 8Mb 5.6ms DropTail

$ns duplex-link $n20 $n23 3Mb 5.6ms DropTail

$ns duplex-link $n23 $n12 1.5Mb 5.6ms DropTail

$ns duplex-link $n1 $n6 12Mb 5.6ms DropTail

$ns duplex-link $n6 $n12 2.9Mb 5.6ms DropTail

$ns duplex-link $n0 $n5 1.2Mb 5.6ms DropTail

$ns duplex-link $n5 $n10 4.2Mb 5.6ms DropTail

$ns duplex-link $n10 $n15 10Mb 5.6ms DropTail

$ns duplex-link $n15 $n19 1.25Mb 5.6ms DropTail

$ns duplex-link $n19 $n12 2.5Mb 5.6ms DropTail

$ns duplex-link $n4 $n9 10.2Mb 5.6ms DropTail

$ns duplex-link $n9 $n14 11.4Mb 5.6ms DropTail

$ns duplex-link $n14 $n18 13Mb 5.6ms DropTail

$ns duplex-link $n18 $n22 2.6Mb 5.6ms DropTail

$ns duplex-link $n22 $n12 1.8Mb 5.6ms DropTail

$ns duplex-link $n3 $n8 5.7Mb 5.6ms DropTail

$ns duplex-link $n8 $n13 6.5Mb 5.6ms DropTail

$ns duplex-link $n13 $n17 7Mb 5.6ms DropTail

$ns duplex-link $n17 $n21 9Mb 5.6ms DropTail

$ns duplex-link $n21 $n12 9.1Mb 5.6ms DropTail




#Set Queue Size of link for all to 60
$ns queue-limit 
$n2 $n7 60
$ns queue-limit 
$n7 $n11 60
$ns queue-limit 
$n11 $n16 60
$ns queue-limit 
$n16 $n20 60
$ns queue-limit 
$n20 $n23 60
$ns queue-limit 
$n23 $n12 60
$ns queue-limit 
$n1 $n6 60
$ns queue-limit 
$n6 $n12 60
$ns queue-limit 
$n0 $n5 60
$ns queue-limit
 $n5 $n10 60
$ns queue-limit 
$n10 $n15 60
$ns queue-limit 
$n15 $n19 60
$ns queue-limit 
$n19 $n12 60
$ns queue-limit 
$n4 $n9 60
$ns queue-limit
 $n9 $n14 60
$ns queue-limit
 $n14 $n18 60
$ns queue-limit 
$n18 $n22 60
$ns queue-limit 
$n22 $n12 60
$ns queue-limit
 $n3 $n8 60
$ns queue-limit 
$n8 $n13 60
$ns queue-limit 
$n13 $n17 60
$ns queue-limit 
$n17 $n21 60
$ns queue-limit
 $n21 $n12 60



#Monitor the queue for link (n2-n3). (for NAM)

$ns duplex-link-op $n2 $n7 queuePos 0.5

$ns duplex-link-op $n7 $n11 queuePos 0.5

$ns duplex-link-op $n11 $n16 queuePos 0.5

$ns duplex-link-op $n16 $n20 queuePos 0.5

$ns duplex-link-op $n20 $n23 queuePos 0.5

$ns duplex-link-op $n23 $n12 queuePos 0.5

$ns duplex-link-op $n1 $n6 queuePos 0.5

$ns duplex-link-op $n6 $n12 queuePos 0.5

$ns duplex-link-op $n0 $n5 queuePos 0.5

$ns duplex-link-op $n5 $n10 queuePos 0.5

$ns duplex-link-op $n10 $n15 queuePos 0.5

$ns duplex-link-op $n15 $n19 queuePos 0.5

$ns duplex-link-op $n19 $n12 queuePos 0.5

$ns duplex-link-op $n4 $n9 queuePos 0.5

$ns duplex-link-op $n9 $n14 queuePos 0.5

$ns duplex-link-op $n14 $n18 queuePos 0.5

$ns duplex-link-op $n18 $n22 queuePos 0.5

$ns duplex-link-op $n22 $n12 queuePos 0.5

$ns duplex-link-op $n3 $n8 queuePos 0.5

$ns duplex-link-op $n8 $n13 queuePos 0.5

$ns duplex-link-op $n13 $n17 queuePos 0.5

$ns duplex-link-op $n17 $n21 queuePos 0.5

$ns duplex-link-op $n21 $n12 queuePos 0.5






#Setup a TCP connection
set tcp [new Agent/TCP]

$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]

$ns attach-agent $n12 $sink

$ns connect $tcp $sink

$tcp set fid_ 1


set tcp1 [new Agent/TCP]

$ns attach-agent $n2 $tcp1
set sink1 [new Agent/TCPSink]

$ns attach-agent $n12 $sink1

$ns connect $tcp1 $sink1

$tcp1 set fid_ 3



#Setup a FTP over TCP connection

set ftp [new Application/FTP]

$ftp attach-agent $tcp

$ftp set type_ FTP

$ftp set packet_size_ 512



set ftp1 [new Application/FTP]

$ftp1 attach-agent $tcp1

$ftp1 set type_ FTP

$ftp1 set packet_size_ 512



#Setup a UDP connection

set udp [new Agent/UDP]

$ns attach-agent $n1 $udp

set null [new Agent/Null]

$ns attach-agent $n12 $null

$ns connect $udp $null

$udp set fid_ 2



set udp1 [new Agent/UDP]

$ns attach-agent $n3 $udp1

set null1 [new Agent/Null]

$ns attach-agent $n12 $null1

$ns connect $udp1 $null1

$udp1 set fid_ 4



set udp2 [new Agent/UDP]

$ns attach-agent $n4 $udp2

set null2 [new Agent/Null]

$ns attach-agent $n12 $null2

$ns connect $udp2 $null2

$udp2 set fid_ 5



#Setup a CBR over UDP connection

set cbr [new Application/Traffic/CBR]

$cbr attach-agent $udp

$cbr set type_ CBR

$cbr set packet_size_ 512

$cbr set rate_ 1mb

$cbr set random_ false



set cbr1 [new Application/Traffic/CBR]

$cbr1 attach-agent $udp1

$cbr1 set type_ CBR

$cbr1 set packet_size_ 512

$cbr1 set rate_ 1mb

$cbr1 set random_ false



set cbr2 [new Application/Traffic/CBR]

$cbr2 attach-agent $udp2

$cbr2 set type_ CBR

$cbr2 set packet_size_ 512

$cbr2 set rate_ 1mb

$cbr2 set random_ false





#Schedule events for the CBR and FTP agents

$ns at 0.1 "$cbr start"

$ns at 1.0 "$ftp start"

$ns at 4.0 "$ftp stop"

$ns at 4.5 "$cbr stop"

$ns at 0.2 "$cbr1 start"

$ns at 1.0 "$ftp1 start"

$ns at 4.0 "$ftp1 stop"

$ns at 4.4 "$cbr1 stop"

$ns at 0.3 "$cbr2 start"

$ns at 4.3 "$cbr2 stop"



#Call the finish procedure after 5 seconds of simulation time

$ns at 5.0 "finish"



#Print CBR packet size and interval

puts "CBR packet size = [$cbr set packet_size_]"

puts "CBR interval = [$cbr set interval_]"




#Run the simulation

$ns run


