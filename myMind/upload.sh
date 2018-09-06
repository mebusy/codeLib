# usage:  sh upload.sh [upload [dist_ip] ]

if [ `uname` != "Darwin" ] ; then
    echo 'you must run update.sh in MacOSX' 
    exit 1
fi


DIST_NAME=mindserver
rm -f $DIST_NAME.zip


DIFF_FORMAT="-U0 "

MCONF="nginx.conf"
sed -i "" "s/\(lua_code_cache[[:space:]][[:space:]]*\)off\([[:space:]]*;\)/\1on\2/" $MCONF
sed -i "" "s/#[[:space:]]*\(access_log[[:space:]][[:space:]]*off[[:space:]]*;\)/\1/" $MCONF
sed -i "" "s/\(^[[:space:]]*error_log\)/#\1/" $MCONF
git diff $DIFF_FORMAT    $MCONF 



zip -r $DIST_NAME.zip \
    conf \
    lua \
    nginx.conf \
    runServer.sh \
    webTools/eventTool  \
    *.py \
    -x conf/swaggerUI.conf  > /dev/null

wait &&




# revert 
git checkout $MCONF 


echo done



