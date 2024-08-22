#!/bin/bash

apt install build-essential module-assistant
m-a prepare
apt install --reinstall dkms
