rm -rf build 

yarn build

DIST=../../webTools/eventTool

rm -rf $DIST
mkdir -p $DIST
cp -R -f build/*  $DIST/





