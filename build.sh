#!/bin/bash
godot=/opt/godot
srcdir=./test
outdir=build
outfile=test$(date +%y%m%d%H%M%S)
find . -type f -name '*.import' -delete
mkdir $srcdir/$outdir
$godot --export-release "Linux/X11" $outdir/$outfile $srcdir/project.godot
$godot --export-release "Windows Desktop" $outdir/$outfile.exe $srcdir/project.godot
cp $srcdir/settings.json $srcdir/bg.ogv $srcdir/$outdir
$srcdir/$outdir/$outfile #-- hello.db
