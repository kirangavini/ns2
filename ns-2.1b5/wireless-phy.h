/* -*-	Mode:C++; c-basic-offset:8; tab-width:8; indent-tabs-mode:t -*-  *
 *
 * Copyright (c) 1997 Regents of the University of California.
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
 *	This product includes software developed by the Computer Systems
 *	Engineering Group at Lawrence Berkeley Laboratory.
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

   wireless-phy.h
   -- a SharedMedia network interface

*/

#ifndef ns_WirelessPhy_h
#define ns_WirelessPhy_h


#include "propagation.h"
#include "modulation.h"
#include "omni-antenna.h"
#include "phy.h"
#include "mobilenode.h"

#ifdef MIT_uAMPS
#include <mit/rca/energy.h>
#endif

class Phy;
class Propagation;

class WirelessPhy : public Phy {
 public:
	WirelessPhy();
	
	void sendDown(Packet *p);
	int sendUp(Packet *p);
	
	inline double getL() {return L_;}
	
	inline double getLambda() {return lambda_;}
  
	virtual int command(int argc, const char*const* argv);
	virtual void dump(void) const;
	//MobileNode* node(void) const { return node_; }
	
	//void setnode (MobileNode *node) { node_ = node; }
	
 protected:
#ifdef MIT_uAMPS
	double Efriss_amp_;				// Xmit amp energy (J/bit/m^2)
	double Etwo_ray_amp_;			// Xmit amp energy (J/bit/m^4)
	double EXcvr_;						// Xcvr energy (J/bit)
  double Pfriss_amp_;				// Friss base transmission power (W/m^2)
  double Ptwo_ray_amp_;			// Two-ray base transmission power (W/m^4)
	double PXcvr_;      			// Xcvr Power (W)
  int sleep_;								// 0 = awake, 1 = asleep
  int alive_;								// 0 = dead, 1 = alive
  int ss_;								  // amount of spreading
  double time_finish_rcv_;			
  double dist_;			        // approx. distance to transmitter
#endif
  double Pt_;								// transmission power (W)
  double freq_;       			// frequency
  double lambda_;						// wavelength (m)
  double L_;								// system loss factor
  
  double RXThresh_;					// receive power threshold (W)
  double CSThresh_;					// carrier sense threshold (W)
  double CPThresh_;					// capture threshold (db)
  
  Antenna *ant_;

#ifdef MIT_uAMPS
	EnergyResource *energy_;  // Energy resource

private:
	double pktEnergy(double pt, double pxcvr, int nbytes);
#endif

  Propagation *propagation_;	// Propagation Model
  Modulation *modulation_;		// Modulation Scheme
  MobileNode* node_;
  
 private:
  
  inline int	initialized() {
	  return (node_ && uptarget_ && downtarget_ && propagation_);
  }
  

};

#endif /* !ns_WirelessPhy_h */
