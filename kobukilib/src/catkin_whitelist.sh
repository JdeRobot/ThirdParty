#!/bin/sh

cat | awk '{printf "%s;", $1}' | sed "s,;$,,"
