#!/bin/bash
etatActif()
{
	vm=$1
	virsh start $1
}

etatArret_douce()
{
	vm=$1
	virsh shutdown $1

}

etatArret_brutal()
{
	vm=$1
	virsh destroy $1

}
