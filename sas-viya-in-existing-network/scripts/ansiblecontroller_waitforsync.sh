#!/bin/bash
# set -x
# set -v
# make sure we have at least java8 and ansible 2.3.2.0

DIRECTORY_NFS_SHARE="/exports/bastion"
DIRECTORY_READYNESS_FLAGS="${DIRECTORY_NFS_SHARE}/setup/readyness_flags"


wait_count=0
stop_waiting_count=600

while [ ! -e "${DIRECTORY_READYNESS_FLAGS}/CAS_ready" ]; do
	echo "CASController not ready, waiting 1 second"
	sleep 1
	if [ "$((wait_count++))" -gt "$stop_waiting_count" ]; then
		exit 1
	fi
done
echo "CAS marked ready for ansible"
while [ ! -e "${DIRECTORY_READYNESS_FLAGS}/Stateful_ready" ]; do
	echo "StatefulServices not ready, waiting 1 second"
	sleep 1
	if [ "$((wait_count++))" -gt "$stop_waiting_count" ]; then
		exit 1
	fi
done
echo "Stateful Services marked ready for ansible"
while [ ! -e "${DIRECTORY_READYNESS_FLAGS}/Programming_ready" ]; do
	echo "ProgrammingServices not ready, waiting 1 second"
	sleep 1
	if [ "$((wait_count++))" -gt "$stop_waiting_count" ]; then
		exit 1
	fi
done
echo "ProgrammingServices marked ready for ansible"
while [ ! -e "${DIRECTORY_READYNESS_FLAGS}/Visual_ready" ]; do
	echo "VisualServices not ready, waiting 1 second"
	sleep 1
	if [ "$((wait_count++))" -gt "$stop_waiting_count" ]; then
		exit 1
	fi
done
echo "VisualServices marked ready for ansible"

