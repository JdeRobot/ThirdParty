#!/bin/sh


for pkginfo in *.info
do
	pkgname=${pkginfo%.info}
	echo $pkgname
	target=build/$pkgname/DEBIAN
	mkdir -p $target
	cp $pkginfo $target/control
	dpkg --build build/$pkgname
done

