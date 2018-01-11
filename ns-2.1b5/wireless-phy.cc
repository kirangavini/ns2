/* -*-  Mode:C++; c-basic-offset:8; tab-width:8; indent-tabs-mode:t -*-  *
 *
 * Copyright (c) 1996 Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *  This product includes software developed by the Computer Systems
 *  Engineering Group at Lawrence Berkeley Laboratory and the Daedalus
 *  research group at UC Berkeley.
 * 4. Neither the name of the University nor of the Laboratory may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * Ported from CMU/Monarch's code, nov'98 -Padma Haldar.
   wireless-phy.cc
*/

#include <math.h>

#include <packet.h>

#include <mobilenode.h>
#include <phy.h>
#include <propagation.h>
#include <modulation.h>
#include <omni-antenna.h>
#include <wireless-phy.h>

/* ======================================================================
   WirelessPhy Interface
   ====================================================================== */
static class WirelessPhyClass: public TclClass {
public:
        WirelessPhyClass() : TclClass("Phy/WirelessPhy") {}
        TclObject* create(int, const char*const*) {
                return (new WirelessPhy);
        }
} class_WirelessPhy;


WirelessPhy::WirelessPhy() : Phy()
{
  node_ = 0;
  propagation_ = 0;
  modulation_ = 0;
#ifdef MIT_uAMPS
  bandwidth_ = 1000000;                // 100 Mbps
  Efriss_amp_ = 100 * 1e-12;           // Friss amp energy (J/bit/m^2)
  Etwo_ray_amp_ = 0.013 * 1e-12;       // Two-ray amp energy (J/bit/m^4)
  EXcvr_ = 50 * 1e-9;                  // Xcvr energy (J/bit)
  // Use this base threshold to get a "hearing radius" of ~ 1 m
  Pfriss_amp_ = Efriss_amp_ * bandwidth_;      // Friss power (W/m^2)
  Ptwo_ray_amp_ = Etwo_ray_amp_ * bandwidth_;  // Two-ray power (W/m^4)
  PXcvr_ = EXcvr_ * bandwidth_;        // Xcvr power (W)
  sleep_ = 0;                          // 0 = awake, 1 = asleep
  alive_ = 1;                          // 0 = dead, 1 = alive
  ss_ = 1;                             // amount of spreading
  time_finish_rcv_ = 0;                            
  dist_ = 0;                           // approx. distance to transmitter 
#else
  bandwidth_ = 2*1e6;                 // 2 Mb
  Pt_ = pow(10, 2.45) * 1e-3;         // 24.5 dbm, ~ 281.8mw
#endif
  lambda_ = SPEED_OF_LIGHT / (914 * 1e6);  // 914 mHz
  L_ = 1.0;
  freq_ = -1.0;

  /*
   *  It sounds like 10db should be the capture threshold.
   *
   *  If a node is presently receiving a packet a a power level
   *  Pa, and a packet at power level Pb arrives, the following
   *  comparion must be made to determine whether or not capture
   *  occurs:
   *
   *    10 * log(Pa) - 10 * log(Pb) > 10db
   *
   *  OR equivalently
   *
   *    Pa/Pb > 10.
   *
   */
  
  CPThresh_ = 10.0;
#ifdef MIT_uAMPS
  /*
   * Set CSThresh_ for receiver sensitivity and RXThresh_ for required SNR.
   */
  CSThresh_ = 1e-10;
  RXThresh_ = 6e-9;
#else
  CSThresh_ = 1.559e-11;
  RXThresh_ = 3.652e-10;
#endif

  //bind("CPThresh_", &CPThresh_);
  //bind("CSThresh_", &CSThresh_);
  //bind("RXThresh_", &RXThresh_);
  //bind("bandwidth_", &bandwidth_);
  //bind("Pt_", &Pt_);
  //bind("freq_", &freq_);
  //bind("L_", &L_);

#ifdef MIT_uAMPS
  bind("bandwidth_",&bandwidth_);
  bind("CSThresh_", &CSThresh_);
  bind("RXThresh_", &RXThresh_);
  bind("Efriss_amp_", &Efriss_amp_);
  bind("Etwo_ray_amp_", &Etwo_ray_amp_);
  bind("EXcvr_", &EXcvr_); 
  bind("freq_", &freq_); 
  bind("L_", &L_); 
  bind("sleep_",&sleep_);
  bind("alive_",&alive_);
  bind("ss_",&ss_);
  bind("dist_",&dist_);
#endif


  if (freq_ != -1.0) 
    { // freq was set by tcl code
      lambda_ = SPEED_OF_LIGHT / freq_;
    }
}

int
WirelessPhy::command(int argc, const char*const* argv)
{
  TclObject *obj;    
  if(argc == 3) {
          if( (obj = TclObject::lookup(argv[2])) == 0) {
      fprintf(stderr, "WirelessPhy: %s lookup of %s failed\n", 
        argv[1], argv[2]);
      return TCL_ERROR;
    }
    if (strcmp(argv[1], "propagation") == 0) {
      assert(propagation_ == 0);
      propagation_ = (Propagation*) obj;
      return TCL_OK;
    }
    else if (strcasecmp(argv[1], "antenna") == 0) {
      ant_ = (Antenna*) obj;
      return TCL_OK;
    }
    else if (strcasecmp(argv[1], "node") == 0) {
      assert(node_ == 0);
      node_ = (MobileNode*) obj;
      return TCL_OK;
    }
#ifdef MIT_uAMPS
    else if (strcasecmp(argv[1], "attach-energy") == 0) {
      energy_ = (EnergyResource*) obj;
      return TCL_OK;
    }
#endif
  }
  return Phy::command(argc,argv);
}
 
void 
WirelessPhy::sendDown(Packet *p)
{

  /*
   * Sanity Check
   */
  assert(initialized());

#ifdef MIT_uAMPS
  /* 
   * The power for transmission depends on the distance between
   * the transmitter and the receiver.  If this distance is
   * less than the crossover distance:
   *       (c_d)^2 =  16 * PI^2 * L * hr^2 * ht^2
   *               ---------------------------------
   *                           lambda^2
   * the power falls off using the Friss equation.  Otherwise, the
   * power falls off using the two-ray ground reflection model.
   * Therefore, the power for transmission of a bit is:
   *      Pt = Pfriss_amp_*d^2 if d < c_d
   *      Pt = Ptwo_ray_amp_*d^4 if d >= c_d. 
   * The total power dissipated per bit is PXcvr_ + Pt.
   */
  hdr_cmn *ch = HDR_CMN(p);
  hdr_rca *rca_hdr = HDR_RCA(p);
  double d = rca_hdr->get_dist();
  double hr, ht;        // height of recv and xmit antennas
  double tX, tY, tZ;    // transmitter location 
  node_->getLoc(&tX, &tY, &tZ);
  ht = tZ + ant_->getZ();
  hr = ht;              // assume receiving node and antenna at same height
  double crossover_dist = sqrt((16 * PI * PI * L_ * ht * ht * hr * hr) 
                             / (lambda_ * lambda_));
  if (d < crossover_dist) 
    if (d > 1)
       Pt_ = Efriss_amp_ * bandwidth_ * d * d;
    else 
      // Pfriss_amp_ is the minimum transmit amplifier power.
      Pt_ = Efriss_amp_ * bandwidth_;
  else
    Pt_ = Etwo_ray_amp_ * bandwidth_ * d * d * d * d;
  PXcvr_ = EXcvr_ * bandwidth_;
  
  if (energy_->remove(pktEnergy(Pt_, PXcvr_, ch->size())) != 0) 
    alive_ = 0;
#endif

  /*
   *  Stamp the packet with the interface arguments
   */
  p->txinfo_.stamp(node_, ant_->copy(), Pt_, lambda_);

  // Send the packet
  channel_->recv(p, this);
}

int 
WirelessPhy::sendUp(Packet *p)
{
  /*
   * Sanity Check
   */
  assert(initialized());

  PacketStamp s;
  double Pr;
  int pkt_recvd = 0;

#ifdef MIT_uAMPS
  hdr_cmn *ch = HDR_CMN(p);
  hdr_rca *rca_hdr = HDR_RCA(p);
  /* 
   * Record when this packet ends and its code.
   */
  int code = rca_hdr->get_code();
  cs_end_[code] = Scheduler::instance().clock() + txtime(p);
  /* 
   * If the node is asleep, drop the packet. 
   */
  if (sleep_) {
      //printf("Sleeping node... carrier sense ends at %f\n", cs_end_);
      //fflush(stdout);
      pkt_recvd = 0;
      goto DONE;
  } 
#endif 

  if(propagation_) {

    s.stamp(node_, ant_, 0, lambda_);
    
    Pr = propagation_->Pr(&p->txinfo_, &s, this);
    
    if (Pr < CSThresh_) {
      pkt_recvd = 0;
      //printf("Pr < CSThresh!!!!\n");
      //fflush(stdout);
      goto DONE;
    }

    if (Pr < RXThresh_) {
      /*
       * We can detect, but not successfully receive
       * this packet.
       */
      hdr_cmn *hdr = HDR_CMN(p);
      hdr->error() = 1;
#if DEBUG > 3
      printf("SM %f.9 _%d_ drop pkt from %d low POWER %e/%e\n",
       Scheduler::instance().clock(), node_->index(),
       p->txinfo_.getNode()->index(),
       Pr,RXThresh);
#endif
    }
  }
  

  if(modulation_) {
    hdr_cmn *hdr = HDR_CMN(p);
    hdr->error() = modulation_->BitError(Pr);
  }

#ifdef MIT_uAMPS
  /* 
   * Only remove energy from nodes that are awake and not currently
   * transmitting a packet.
   */
  if (Scheduler::instance().clock() >= time_finish_rcv_) {
    PXcvr_ = EXcvr_ * bandwidth_;
    if (energy_->remove(pktEnergy((double)0, PXcvr_,ch->size())) != 0)
      alive_ = 0;
    time_finish_rcv_ = Scheduler::instance().clock() + txtime(p);
  }
  /*
   * Determine approximate distance of node transmitting node 
   * from received power.
   */
  double hr, ht;        // height of recv and xmit antennas
  double rX, rY, rZ;    // receiver location
  double d1, d2;
  double crossover_dist, Pt, M;
  node_->getLoc(&rX, &rY, &rZ);
  hr = rZ + ant_->getZ();
  ht = hr;              // assume transmitting node antenna at same height

  crossover_dist = sqrt((16 * PI * PI * L_ * ht * ht * hr * hr)
                             / (lambda_ * lambda_));
  Pt = p->txinfo_.getTxPr();
  M = lambda_ / (4 * PI);
  d1 = sqrt( (Pt * M * M) / (L_ * Pr) );
  d2 = sqrt(sqrt( (Pt * hr * hr * ht * ht) / Pr) );
  if (d1 < crossover_dist)
    dist_ = d1;
  else
    dist_ = d2;
  rca_hdr->dist_est() = (int) ceil(dist_);
#endif

  /*
   * The MAC layer must be notified of the packet reception
   * now - ie; when the first bit has been detected - so that
   * it can properly do Collision Avoidance / Detection.
   */
  pkt_recvd = 1;

DONE:
  p->txinfo_.getAntenna()->release();
  //*RxPr = Pr;

  /* WILD HACK: The following two variables are a wild hack.
     They will go away in the next release...
     They're used by the mac-802_11 object to determine
     capture.  This will be moved into the net-if family of 
     objects in the future. */
  p->txinfo_.RxPr = Pr;
  p->txinfo_.CPThresh = CPThresh_;

  return pkt_recvd;
}

void
WirelessPhy::dump(void) const
{
  Phy::dump();
  fprintf(stdout,
    "\tPt: %f, Gt: %f, Gr: %f, lambda: %f, L: %f\n",
    Pt_, ant_->getTxGain(0,0,0,lambda_), ant_->getRxGain(0,0,0,lambda_), lambda_, L_);
  fprintf(stdout, "\tbandwidth: %f\n", bandwidth_);
  fprintf(stdout, "--------------------------------------------------\n");
}


#ifdef MIT_uAMPS
double
WirelessPhy::pktEnergy(double pt, double pxcvr, int nbytes)
{

  /* 
   * Energy (in Joules) is power (in Watts=Joules/sec) divided by 
   * bandwidth (in bits/sec) multiplied by the number of bytes, times 8 bits.
   */
  // If data has been spread, power per DATA bit should be the same
  // as if there was no spreading ==> divide transmit power
  // by spreading factor.
  double bits = (double) nbytes * 8;
  pt /= ss_;
  double j = bits * (pt + pxcvr) / bandwidth_;
  return(j);
}

#endif


