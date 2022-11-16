#!/bin/bash
#
# Invoked build.xml, overriding the lolua++ property

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
TOLUA=./tolua++

cd ${SCRIPT_DIR}

PKG_NAME=testbinding
OUT_DIR=..
mkdir -p ${OUT_DIR}
#-L basic.lua 
${TOLUA}  -L cinvokelua.lua -o ${OUT_DIR}/${PKG_NAME}.cpp -H ${OUT_DIR}/${PKG_NAME}.h ${PKG_NAME}.pkg
sed -i '' "s/tolua_reg_types/tolua_${PKG_NAME}_reg_types/g"   ${OUT_DIR}/${PKG_NAME}.cpp



#DEST_FOLDER=/Volumes/WORK/WORK/TouchGame/TouchGame/Classes/c2dx_plus/
#cp -f out/*  $DEST_FOLDER
#cp -R -f ../c2dx_plus/c2dx_plus/  $DEST_FOLDER
