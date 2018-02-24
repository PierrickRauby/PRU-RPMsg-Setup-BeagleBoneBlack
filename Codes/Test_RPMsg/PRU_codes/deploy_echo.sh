#! /bin/bash
# Copyright (C) 2016 Pierrick Rauby <PierrickRauby - pierrick.rauby@gmail.com>
#
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#	* Redistributions of source code must retain the above copyright
#	  notice, this list of conditions and the following disclaimer.
#
#	* Redistributions in binary form must reproduce the above copyright
#	  notice, this list of conditions and the following disclaimer in the
#	  documentation and/or other materials provided with the
#	  distribution
#
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#############################################################################
echo "**** Starting ****"
echo "building Halt_PRU"

alias cd_PRU_Halt="cd PRU_Halt"
cd_PRU_Halt

make clean
make
echo "copying files into /lib/firmware/am335x-pru0-fw"
cp gen/*.out /lib/firmware/am335x-pru0-fw
echo "done"
echo "building PRU_RPMsg_Echo_Interrupt1"

alias cd_PRU_RPMsg_Echo_Interrupt1="cd ../PRU_RPMsg_Echo_Interrupt1"
cd_PRU_RPMsg_Echo_Interrupt1

make clean
make
echo "copying files into /lib/firmware/am335x-pru1-fw"
cp gen/*.out /lib/firmware/am335x-pru1-fw
echo "done"

echo "Rebooting PRUs"
echo 'stop' > /sys/class/remoteproc/remoteproc1/state
echo 'stop' > /sys/class/remoteproc/remoteproc2/state
echo 'start' > /sys/class/remoteproc/remoteproc1/state
echo 'start' > /sys/class/remoteproc/remoteproc2/state

echo "done"
