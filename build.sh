#!/bin/bash
godot=/opt/godot
srcdir=./test
outdir=build
outfile=test$(date +%y%m%d%H%M%S)
mkdir $srcdir/$outdir
$godot --export-release "Linux/X11" $outdir/$outfile $srcdir/project.godot
cp $srcdir/settings.json $srcdir/bg.ogv $srcdir/$outdir
