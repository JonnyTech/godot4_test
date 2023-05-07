#!/bin/bash
godot=/opt/godot
srcdir=./test/
outdir=$srcdir/build
$godot --export-release "Linux/X11" $outdir/linux$(date +%y%m%d%H%M%S) $srcdir/project.godot
cp $srcdir/settings.json $srcdir/bg.ogv $outdir
