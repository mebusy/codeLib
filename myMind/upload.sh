# usage:  sh upload.sh [upload [dist_ip] ]

if [ `uname` != "Darwin" ] ; then
    echo 'you must run update.sh in MacOSX' 
    exit 1
fi


DIST_NAME=hdaserver
rm -f $DIST_NAME.zip


DIFF_FORMAT="-U0 "
# modify for PROD
# MFILE="conf/eventTool.conf"
# sed -i "" "s/\(webTools\/eventTool\)\([[:space:]]*;\)/\1PROD\2/" $MFILE
# git diff $DIFF_FORMAT $MFILE 

MCONF="nginx.conf"
sed -i "" "s/\(lua_code_cache[[:space:]][[:space:]]*\)off\([[:space:]]*;\)/\1on\2/" $MCONF
sed -i "" "s/#[[:space:]]*\(access_log[[:space:]][[:space:]]*off[[:space:]]*;\)/\1/" $MCONF
sed -i "" "s/\(^[[:space:]]*error_log\)/#\1/" $MCONF
git diff $DIFF_FORMAT    $MCONF 

MLUAINIT="lua/_init.lua"
sed -i "" "s/\(_G\.PROD[[:space:]]*=[[:space:]]*\).*/\1true/" $MLUAINIT
git diff $DIFF_FORMAT    $MLUAINIT 

# remove
# MLUAADS="lua/advertisement.lua"
# sed -i ""  "s/\(fakeIP[[:space:]]*=[[:space:]]*\).*/\1\"${DIST_IP}\"/" $MLUAADS
# git diff $DIFF_FORMAT    $MLUAADS 


zip -r $DIST_NAME.zip \
    conf \
    lua \
    nginx.conf \
    runServer.sh \
    setupServer.py \
    webTools/eventTool  \
    staticRes/ads/test1.jpg \
    staticRes/ads/test.png \
    -x conf/swaggerUI.conf  > /dev/null

wait &&




# revert 
# git checkout $MFILE 
git checkout $MCONF 
git checkout $MLUAINIT
# git checkout $MLUAADS


echo done



