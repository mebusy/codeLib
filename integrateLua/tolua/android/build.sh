
ndk-build clean
ndk-build  #  "NDK_MODULE_PATH=.:../../luajit/prebuilt"


for TARGET in armeabi armeabi-v7a arm64-v8a x86 ; do 
    # echo $TARGET
    DIST=../prebuilt/android/$TARGET
    mkdir -p $DIST
    cp -f ./obj/local/$TARGET/*.a  $DIST

done


ndk-build clean
rm -rf obj
