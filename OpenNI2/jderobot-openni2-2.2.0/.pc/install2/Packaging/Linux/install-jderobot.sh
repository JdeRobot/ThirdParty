#!/bin/sh -e

WORK_DIR=`pwd`

echo "Installing in $DESTDIR"

mkdir -p $DESTDIR/etc/udev/rules.d/
cp $WORK_DIR/Packaging/Linux/primesense-usb.rules $DESTDIR/etc/udev/rules.d/55-primesense-usb.rules

cd $WORK_DIR/Bin/*Release/
LIBS=`find .| grep so`
LIBS2=`find .| grep a$`
BIN=`find . -type f | grep -v so | grep -v a$`

INSTALL_LIBS="$DESTDIR/usr/lib/openni2/"
INSTALL_BIN="$DESTDIR//usr/bin/openni2/"
INSTALL_INCLUDE="$DESTDIR/usr/include/openni2/"

mkdir -p $INSTALL_LIBS
mkdir -p $INSTALL_BIN
mkdir -p $INSTALL_INCLUDE


echo "Installing libs ..." 
for lib in $LIBS; do
	echo "     $lib"
	cp -a $lib $INSTALL_LIBS
done

for lib in $LIBS2; do
	echo "     $lib"
	cp -a $lib $INSTALL_LIBS
done

echo "Installing bin ..."
for bin in $BIN; do
	echo "     $bin"
	cp -a $bin $INSTALL_BIN
done

echo "Installing include ..."
cd -
cp -a Include/* $INSTALL_INCLUDE

echo "/usr/lib/openni2/" >  /etc/ld.so.conf.d/openni2.conf
/etc/init.d/udev restart
