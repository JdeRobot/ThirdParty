# Used to quick start builds with ros-catkin on linux systems.

PWD:=$(shell pwd)
CMAKE_INSTALL_PREFIX:=${PWD}/install

help:
	@echo ""
	@echo "Usage: make <target>"
	@echo "   sources:   clone the sources into a local ros workspace"
	@echo "   configure: cmake configure the sources in a parallel build"
	@echo "   build:     compile sources"
	@echo "   install:   install into local parallel directory"
	@echo "   clean:     remove all build and install directories."
	@echo ""

sources:
	rm -rf src
	mkdir -p src
	cd src; rosws init --catkin
	cd src; rosws merge https://raw.github.com/stonier/ecl_tools/master/rosinstall/ecl_groovy.rosinstall
	cd src; rosws update

configure: clean
	mkdir -p build
	mkdir -p install
	cd build; cmake -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../src

build:
	cd build; make -j5

tests:
	cd build; make -j5 tests

install:
	cd build; make install

clean:
	rm -rf build
	rm -rf install

.PHONY: sources configure build install clean
