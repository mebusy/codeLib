
# -I : header search path
# -L : lib search path
# -l :  which lib to link 
gcc -I./luajit/include standaloneIntegrate.cpp -L./luajit/prebuilt/mac   -lluajit

