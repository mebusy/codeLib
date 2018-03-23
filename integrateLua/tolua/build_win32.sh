
#!/bin/bash
# 32 Bit Version
# need MinGW  , env  cmder / Gow

DIST="prebuilt/window/x86"
mkdir -p ${DIST}

cp ../luajit/prebuilt/win32/* ./
cp ../curl/prebuilt/win32/* ./
cp ../openssl/prebuilt/win32/* ./

rm *.o


python _winMakeWinIncludes.py


MACRO="-D_WIN32 -D_WINDOWS"   #

INC="-Isrc -I../luajit/include \
	 -I../lua_3rd_lib/luasocket-2.0.2/src \
	 -I../lua_3rd_lib/luasocket-2.0.2/src/win \
	 -I../lua_3rd_lib/md5-1.1.2/src \
	 -I../lua_3rd_lib/lua-curl/src \
	 -I../lua_3rd_lib/cLua \
	 -I../curl/include/win32 \
	 -I../openssl/include/win32 \
	 -Iinclude_win "



gcc -m32 -O2 -std=gnu99 -c \
	../lua_3rd_lib/lua-curl/src/*.c \
	src/*.c \
	../lua_3rd_lib/md5-1.1.2/src/*.c \
	../lua_3rd_lib/cLua/lualoadexts.c \
	../lua_3rd_lib/luasocket-2.0.2/src/auxiliar.c \
	../lua_3rd_lib/luasocket-2.0.2/src/buffer.c \
	../lua_3rd_lib/luasocket-2.0.2/src/except.c \
	../lua_3rd_lib/luasocket-2.0.2/src/inet.c \
	../lua_3rd_lib/luasocket-2.0.2/src/io.c \
	../lua_3rd_lib/luasocket-2.0.2/src/luasocket.c \
	../lua_3rd_lib/luasocket-2.0.2/src/mime.c \
	../lua_3rd_lib/luasocket-2.0.2/src/options.c \
	../lua_3rd_lib/luasocket-2.0.2/src/select.c \
	../lua_3rd_lib/luasocket-2.0.2/src/tcp.c \
	../lua_3rd_lib/luasocket-2.0.2/src/timeout.c \
	../lua_3rd_lib/luasocket-2.0.2/src/udp.c \
	../lua_3rd_lib/luasocket-2.0.2/src/win/wsocket.c \
	${INC}




# c++ code can not work : Different Compilers may not Interoperate
# -std=c++11 
#g++ ${MACRO}  -m32 -O2  -c \
#	src_misc/*.cpp \
#	src_misc/win/*.cpp \
#	../luabinding/luabinding/*.cpp \
#	${INC}

OBJS="`python _winGetObjsList.py`"

gcc -shared \
    -o ${DIST}/tolua.dll \
     ${OBJS}  \
	-lws2_32 \
    -Wl,--allow-multiple-definition  \
	-Wl,--whole-archive  lua51.lib -Wl,--no-whole-archive   -Wl,--output-def,tolua.def,--out-implib,libtolua.a  libcurl.lib

#  libcurl.lib libssl.lib libcrypto.lib

rm -rf lua51.*
rm *.o
rm -rf libcurl.*
rm -rf libssl*.*
rm -rf libcrypto*.*

# cp windows files 
python _winModifyCPPfilesForWIN32.py src_misc ../luabinding/luabinding


# -Wl,lua51.dll,lua51.lib   -static-libgcc -static-libstdc++


# MSVC LIB tool
# lib.exe /machine:i386 /def:tolua.def
