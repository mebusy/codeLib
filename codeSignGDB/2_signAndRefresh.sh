#!/bin/sh

set -e

#code sign
codesign --entitlements gdb-entitlement.xml -fs gdb_codesign   $(which gdb)

# refresh
sudo killall taskgated



