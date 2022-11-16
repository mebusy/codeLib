echo —————————————————————————
echo usage: rebuildMediaAPK.sh mediaInfo apkFile keyStoreFile  key_alias

MEDIA_INFO=$1
if [ -z "$MEDIA_INFO" ]
then
        echo "short of media info "
	exit 1
	
else
        echo "*media info: $MEDIA_INFO"
fi

APK_INFO=$2
if [ -z "$APK_INFO" ]
then
        echo "short of api info "
	exit 1
	
else
        echo "*apk info: $APK_INFO"
fi


KEY_STORE=$3
if [ -z "$KEY_STORE" ]
then
        echo "short of keyStoreFile "
	exit 1
	
else
        echo "*key store: $KEY_STORE"
fi

KEY_ALIAS=$4
if [ -z "$KEY_ALIAS" ]
then
        echo "short of key alias "
	exit 1
	
else
        echo "*key alias: $KEY_ALIAS"
fi



FOLDER_APK=TEMP
rm -rf $FOLDER_APK

rm -f _unsigned.apk
rm -f _signed_*.apk


./apktool   d  -f  $APK_INFO -o $FOLDER_APK




if [ "$?" -eq "0" ] ; then
        echo
        
else
				echo error unpack
        exit 1
fi


cp -f package/$MEDIA_INFO/netease_data   $FOLDER_APK/assets/

./apktool   b  $FOLDER_APK -o _unsigned.apk


if [ "$?" -eq "0" ] ; then
        echo
        
else
				echo error pack
        exit 1
fi


rm -rf $FOLDER_APK

# -digestalg SHA1 -sigalg MD5withRSA  , need by jdk1.8
jarsigner -digestalg SHA1 -sigalg MD5withRSA -storepass uboft7 -keystore $KEY_STORE   _unsigned.apk $KEY_ALIAS  # -tsa http://timestamp.digicert.com 
if [ "$?" -eq "0" ] ; then
        echo
        
else
				echo error jarsinger
        exit 1
fi



./zipalign -v 4 _unsigned.apk _signed_"${APK_INFO%.*}"_$MEDIA_INFO.apk
if [ "$?" -eq "0" ] ; then
        echo
        
else
				echo error zipalign
        exit 1
fi

rm -f _unsigned.apk

echo 'all successfully'
echo 

