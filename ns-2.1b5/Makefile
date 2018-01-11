# Generated automatically from Makefile.in by configure.
#  Copyright (c) 1994, 1995, 1996
# 	The Regents of the University of California.  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that: (1) source code distributions
#  retain the above copyright notice and this paragraph in its entirety, (2)
#  distributions including binary code include the above copyright notice and
#  this paragraph in its entirety in the documentation or other materials
#  provided with the distribution, and (3) all advertising materials mentioning
#  features or use of this software display the following acknowledgement:
#  ``This product includes software developed by the University of California,
#  Lawrence Berkeley Laboratory and its contributors.'' Neither the name of
#  the University nor the names of its contributors may be used to endorse
#  or promote products derived from this software without specific prior
#  written permission.
#  THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# @(#) $Header: /usr/src/mash/repository/vint/ns-2/Makefile.in,v 1.150 1999/03/16 03:05:41 salehi Exp $ (LBL)

#
# Various configurable paths (remember to edit Makefile.in, not Makefile)
#

# Top level hierarchy
prefix	= /usr/local
# Pathname of directory to install the binary
BINDEST	= /usr/local/bin
# Pathname of directory to install the man page
MANDEST	= /usr/local/man

BLANK	= # make a blank space.  DO NOT add anything to this line

# The following will be redefined under Windows (see WIN32 lable below)
CC	= gcc
CPP	= c++
LINK	= $(CPP)
MKDEP	= ./conf/mkdep
TCLSH	= /homes/wendi/ns/ns-allinone-2.1b5/tclbox/bin/tclsh8.0
TCL2C	= ../tclcl-1.0b8/tcl2c++
AR	= ar rc $(BLANK)

RANLIB	= ranlib
INSTALL	= ./install-sh -c
LN	= ln
TEST	= test
RM	= rm -f
PERL	= /opt/local/bin/perl


CCOPT	= -g -Wall
STATIC	= 
LDFLAGS	= $(STATIC)
LDOUT	= -o $(BLANK)

DEFINE	= -DNO_TK -DTCLCL_CLASSINSTVAR  -DNDEBUG -mv8 -msupersparc -D__svr4__ -DUSE_SHM -DHAVE_LIBTCLCL1_0B8 -DHAVE_TCLCL_H -DHAVE_LIBOTCL1_0A4 -DHAVE_OTCL_H -DHAVE_LIBTK8_0 -DHAVE_TK_H -DHAVE_LIBTCL8_0 -DHAVE_TCL_H   -DSTDC_HEADERS=1 -DHAVE_STRING_H=1 -DHAVE_TCL_H=1 -DHAVE_LIBTCL8_0=1 -DHAVE_TK_H=1 -DHAVE_LIBTK8_0=1 -DHAVE_OTCL_H=1 -DHAVE_LIBOTCL1_0A4=1 -DHAVE_TCLCL_H=1 -DHAVE_LIBTCLCL1_0B8=1 -DHAVE_GETRUSAGE=1 -DHAVE_SBRK=1 -DHAVE_STRTOLL=1 -DHAVE_LIBDL=1 -DMIT_uAMPS 

INCLUDES = \
	-I.  \
	-I../tclcl-1.0b8 -I../otcl-1.0a4 -I../tkbox/include -I../tclbox/include \
	-I./mit/rca -I./mit/uAMPS

LIB	= \
	-R../tclcl-1.0b8 -L../tclcl-1.0b8 -ltclcl -R../otcl-1.0a4 -L../otcl-1.0a4 -lotcl -R../tkbox/lib -L../tkbox/lib -ltk8.0 -R../tclbox/lib -L../tclbox/lib -ltcl8.0  \
	-lXext -lX11 \
	 -lsocket -lnsl -lintl -ldl -ldl \
	-lm -ldl 
#	-L${exec_prefix}/lib \

CFLAGS	= $(CCOPT) $(DEFINE)

# Explicitly define compilation rules since SunOS 4's make doesn't like gcc.
# Also, gcc does not remove the .o before forking 'as', which can be a
# problem if you don't own the file but can write to the directory.
.SUFFIXES: .cc	# $(.SUFFIXES)

.cc.o:
	@rm -f $@
	$(CPP) -c $(CFLAGS) $(INCLUDES) -o $@ $*.cc

.c.o:
	@rm -f $@
	$(CC) -c $(CFLAGS) $(DEFINE) $(INCLUDES) -o $@ $*.c


GEN_DIR	= gen/
LIB_DIR	= lib/
NS	= ns
NSX	= nsx
NSE	= nse

# WIN32: uncomment the following line to include specific make for VC++
# !include <conf/makefile.win>


OBJ_CC = \
	random.o rng.o ranvar.o misc.o timer-handler.o \
	scheduler.o object.o \
	packet.o ip.o route.o connector.o ttl.o \
	trace.o trace-ip.o \
	classifier.o classifier-addr.o classifier-hash.o classifier-virtual.o \
	classifier-mcast.o classifier-mpath.o replicator.o \
	classifier-mac.o \
	app.o telnet.o tcplib-telnet.o \
	trafgen.o traffictrace.o pareto.o expoo.o cbr_traffic.o \
	tbf.o resv.o sa.o saack.o \
	measuremod.o estimator.o adc.o ms-adc.o timewindow-est.o acto-adc.o \
        pointsample-est.o salink.o actp-adc.o hb-adc.o expavg-est.o\
	param-adc.o null-estimator.o \
	adaptive-receiver.o vatrcvr.o consrcvr.o \
	agent.o message.o udp.o session-rtp.o rtp.o rtcp.o ivs.o \
	tcp.o tcp-sink.o tcp-reno.o tcp-newreno.o \
	tcp-vegas.o tcp-rbp.o tcp-full.o \
	scoreboard.o tcp-sack1.o tcp-fack.o \
	tcp-asym.o tcp-asym-sink.o tcp-fs.o tcp-asym-fs.o \
	tcp-int.o chost.o tcp-session.o nilist.o \
	integrator.o queue-monitor.o flowmon.o loss-monitor.o \
	queue.o drop-tail.o simple-intserv-sched.o red.o \
	semantic-packetqueue.o semantic-red.o ack-recons.o \
	sfq.o fq.o drr.o cbq.o \
	hackloss.o errmodel.o \
	delay.o snoop.o \
	dynalink.o rtProtoDV.o net-interface.o \
	ctrMcast.o mcast_ctrl.o srm.o \
	sessionhelper.o delaymodel.o srm-ssm.o \
	srm-topo.o \
	mftp.o mftp_snd.o mftp_rcv.o codeword.o \
	alloc-address.o address.o \
	$(LIB_DIR)int.Vec.o $(LIB_DIR)int.RVec.o \
	$(LIB_DIR)dmalloc_support.o \
	webcache/http.o webcache/tcp-simple.o webcache/pagepool.o \
	webcache/inval-agent.o webcache/tcpapp.o webcache/http-aux.o \
	lanRouter.o tfcc.o filter.o pkt-counter.o \
	Decapsulator.o Encapsulator.o \
	channel.o mac.o ll.o \
	mac-802_11.o \
	mac-802_3.o \
	mip.o mip-reg.o \
	propagation.o tworayground.o antenna.o omni-antenna.o \
	bi-connector.o node.o mobilenode.o \
	arp.o god.o dem.o topography.o modulation.o priqueue.o \
	phy.o wired-phy.o wireless-phy.o \
	mac-timers.o cmu-trace.o varp.o \
	dsdv/dsdv.o dsdv/rtable.o \
	dsr/dsragent.o dsr/hdr_sr.o dsr/mobicache.o dsr/path.o \
	dsr/requesttable.o dsr/routecache.o \
	ns-process.o   
#	rap/raplist.o rap/rap.o rap/rapsink.o rap/utilities.o 
# mac-csma.o mac-multihop.o\

###########################################################################
#
# MIT additions
#
OBJ_MIT = \
		mit/rca/rcagent.o mit/rca/rca-ll.o mit/rca/resource.o  \
		mit/rca/energy.o \
		mac-sensor-timers.o mac-sensor.o mit/uAMPS/bsagent.o

###########################################################################


# what was here before is now in emulate/
OBJ_C =

OBJ_COMPAT = $(OBJ_GETOPT) win32.o
#XXX compat/win32x.o compat/tkConsole.o

OBJ_NAM = \
	nam/animation.o \
	nam/nam-drop.o \
	nam/nam-edge.o \
	nam/nam-node.o \
	nam/nam-packet.o \
	nam/nam-queue.o \
	nam/nam-trace.o \
	nam/paint.o \
	nam/state.o \
	nam/transform.o \
	nam/netview.o \
	nam/netmodel.o

OBJ_EMULATE_CC = \
	emulate/net-ip.o \
	emulate/net.o \
	emulate/tap.o \
	emulate/ether.o \
	emulate/net-pcap.o \
	emulate/internet.o \
	emulate/ping_responder.o \
	emulate/arp.o \
	emulate/icmp.o \
	emulate/nat.o

OBJ_EMULATE_C = \
	emulate/inet.o

OBJ_GEN = $(GEN_DIR)version.o $(GEN_DIR)ns_tcl.o $(GEN_DIR)ptypes.o

SRC =	$(OBJ_C:.o=.c) $(OBJ_CC:.o=.cc) $(OBJ_NAM:.o=.cc) $(OBJ_MIT:.o=.cc)\
	$(OBJ_EMULATE_C:.o=.c) $(OBJ_EMULATE_CC:.o=.cc) \
	tclAppInit.cc tkAppInit.cc

OBJ =	$(OBJ_C) $(OBJ_CC) $(OBJ_GEN) $(OBJ_COMPAT) $(OBJ_MIT)

CLEANFILES = ns nsx ns.dyn $(OBJ) $(OBJ_NAM) $(OBJ_EMULATE_CC) \
	$(OBJ_EMULATE_C) tclAppInit.o \
	$(GEN_DIR)* core core.$(NS) core.$(NSX) core.$(NSE) \
	ptypes2tcl ptypes2tcl.o

$(NS): $(OBJ) tclAppInit.o Makefile
	$(LINK) $(LDFLAGS) $(LDOUT)$@ \
		tclAppInit.o $(OBJ) $(LIB)

Makefile: Makefile.in
	@echo "Makefile.in is newer than Makefile."
	@echo "You need to re-run configure."
	false

$(NSE): $(OBJ) tclAppInit.o $(OBJ_EMULATE_CC) $(OBJ_EMULATE_C)
	$(LINK) $(LDFLAGS) $(LDOUT)$@ \
		tclAppInit.o $(OBJ) \
		$(OBJ_EMULATE_CC) $(OBJ_EMULATE_C)  $(LIB) -lpcap

$(NSX): $(OBJ) tkAppInit.o $(OBJ_NAM)
	$(LINK) $(LDFLAGS) $(LDOUT)$@ \
		tkAppInit.o $(OBJ) $(OBJ_NAM) $(LIB)

ns.dyn: $(OBJ) tclAppInit.o
	$(LINK) $(LDFLAGS) -o $@ \
		tclAppInit.o $(OBJ) $(LIB)

PURIFY	= purify -cache-dir=/tmp
ns-pure: $(OBJ) tclAppInit.o
	$(PURIFY) $(LINK) $(LDFLAGS) -o $@ \
		tclAppInit.o $(OBJ) $(LIB)

NS_TCL_LIB = \
	tcl/lib/ns-compat.tcl \
	tcl/lib/ns-default.tcl \
	tcl/lib/ns-errmodel.tcl \
	tcl/lib/ns-lib.tcl \
	tcl/lib/ns-link.tcl \
	tcl/lib/ns-mobilenode.tcl \
	tcl/lib/ns-cmutrace.tcl \
	tcl/lib/ns-node.tcl \
	tcl/lib/ns-hiernode.tcl \
	tcl/lib/ns-packet.tcl \
	tcl/lib/ns-queue.tcl \
	tcl/lib/ns-source.tcl \
	tcl/lib/ns-nam.tcl \
	tcl/lib/ns-trace.tcl \
	tcl/lib/ns-agent.tcl \
	tcl/lib/ns-random.tcl \
	tcl/lib/ns-namsupp.tcl \
	tcl/lib/ns-address.tcl \
	tcl/lib/ns-intserv.tcl \
	tcl/rtp/session-rtp.tcl \
	tcl/lib/ns-mip.tcl \
	tcl/rtglib/dynamics.tcl \
	tcl/rtglib/route-proto.tcl \
	tcl/rtglib/algo-route-proto.tcl \
        tcl/interface/ns-iface.tcl \
        tcl/mcast/ns-mcast.tcl \
        tcl/mcast/McastProto.tcl \
        tcl/mcast/DM.tcl \
	tcl/mcast/srm.tcl \
	tcl/mcast/srm-adaptive.tcl \
	tcl/mcast/srm-ssm.tcl \
	tcl/mcast/timer.tcl \
	tcl/mcast/McastMonitor.tcl \
	tcl/mcast/mftp_snd.tcl \
	tcl/mcast/mftp_rcv.tcl \
	tcl/mcast/mftp_rcv_stat.tcl \
        tcl/ctr-mcast/CtrMcast.tcl \
        tcl/ctr-mcast/CtrMcastComp.tcl \
        tcl/ctr-mcast/CtrRPComp.tcl \
	tcl/rlm/rlm.tcl \
	tcl/rlm/rlm-ns.tcl \
	tcl/session/session.tcl \
	tcl/lib/ns-route.tcl \
	tcl/emulate/ns-emulate.tcl \
	tcl/lan/vlan.tcl \
	tcl/lan/ns-ll.tcl \
	tcl/lan/ns-mac.tcl \
	tcl/webcache/http-agent.tcl \
	tcl/webcache/http-server.tcl \
	tcl/webcache/http-cache.tcl 

$(GEN_DIR)ns_tcl.cc: $(NS_TCL_LIB)
	$(TCLSH) bin/tcl-expand.tcl tcl/lib/ns-lib.tcl | $(TCL2C) et_ns_lib > $@

$(GEN_DIR)version.c: VERSION
	$(RM) $@
	$(TCLSH) bin/string2c.tcl version_string < VERSION > $@

$(GEN_DIR)ptypes.cc: ptypes2tcl packet.h
	./ptypes2tcl > $@

ptypes2tcl: ptypes2tcl.o
	$(LINK) $(LDFLAGS) $(LDOUT)$@ ptypes2tcl.o

ptypes2tcl.o: ptypes2tcl.cc packet.h

install: force
	$(INSTALL) -m 555 -o bin -g bin ns $(DESTDIR)$(BINDEST)

install-man: force
	$(INSTALL) -m 444 -o bin -g bin ns.1 $(DESTDIR)$(MANDEST)/man1

clean:
	$(RM) $(CLEANFILES)

distclean:
	$(RM) $(CLEANFILES) Makefile config.cache config.log config.status \
	    gnuc.h os-proto.h

tags:	force
	ctags -wtd *.cc *.h ../Tcl/*.cc ../Tcl/*.h

TAGS:	force
	etags *.cc *.h ../Tcl/*.cc ../Tcl/*.h

tcl/lib/TAGS:	force
	( \
		cd tcl/lib; \
		$(TCLSH) ../../bin/tcl-expand.tcl ns-lib.tcl | grep '^### tcl-expand.tcl: begin' | awk '{print $$5}' >.tcl_files; \
		etags --lang=none -r '/^[ \t]*proc[ \t]+\([^ \t]+\)/\1/' `cat .tcl_files`; \
		etags --append --lang=none -r '/^\([A-Z][^ \t]+\)[ \t]+\(instproc\|proc\)[ \t]+\([^ \t]+\)[ \t]+/\1::\3/' `cat .tcl_files`; \
	)

depend: $(SRC)
	$(MKDEP) $(CFLAGS) $(INCLUDES) $(SRC)

srctar:
	@cwd=`pwd` ; dir=`basename $$cwd` ; \
	    name=ns-`cat VERSION | tr A-Z a-z` ; \
	    tar=ns-src-`cat VERSION`.tar.gz ; \
	    list="" ; \
	    for i in `cat FILES` ; do list="$$list $$name/$$i" ; done; \
	    echo \
	    "(rm -f $$tar; cd .. ; ln -s $$dir $$name)" ; \
	     (rm -f $$tar; cd .. ; ln -s $$dir $$name) ; \
	    echo \
	    "(cd .. ; tar cfh $$tar [lots of files])" ; \
	     (cd .. ; tar cfh - $$list) | gzip -c > $$tar ; \
	    echo \
	    "rm ../$$name; chmod 444 $$tar" ;  \
	     rm ../$$name; chmod 444 $$tar

force:

test:	force
	./validate

# Create makefile.vc for Win32 development by replacing:
# "# !include ..." 	-> 	"!include ..."
makefile.vc:	Makefile.in
	$(PERL) bin/gen-vcmake.pl < Makefile.in > makefile.vc
#	$(PERL) -pe 's/^# (\!include)/\!include/o' < Makefile.in > makefile.vc
