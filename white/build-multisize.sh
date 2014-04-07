#! /usr/bin/env bash

#! /usr/bin/env bash

export MAINDIR=$(pwd)
export SVGDIR=$MAINDIR/svg
export PNGDIR=$MAINDIR/png
export CURSDIR=$MAINDIR/Perspective/cursors
export ANIDIR=$MAINDIR/ani

mkdir $PNGDIR
mkdir $ANIDIR

# Build all SVG's to the PNG directory
# and remove animated ones
echo "Building bitmaps from vector art..."
for size in 36; do 
for i in $SVGDIR/*.svg
	do
	  inkscape -w $size -h $size --export-png=$PNGDIR/$(basename $i .svg)_$size.png $i
	done

for i in $SVGDIR/animation/*.svg
	do
	  inkscape -w $size -h $size --export-png=$ANIDIR/$(basename $i .svg)_$size.png $i
	done
done

mkdir -p $CURSDIR
 
# Make main cursors configs 
echo "Making main cursors..."
for size in 36; do 
echo "$size 2 2 $PNGDIR/alias_$size.png 10 replace" >>  $PNGDIR/alias.conf
echo "$size 7 6 $PNGDIR/all-scroll_$size.png 10 replace" >>  $PNGDIR/all-scroll.conf
echo "$size 18 18 $PNGDIR/cell_$size.png 10 replace" >>  $PNGDIR/cell.conf
echo "$size 18 18 $PNGDIR/col-resize_$size.png 10 replace" >>  $PNGDIR/col-resize.conf
echo "$size 2 2 $PNGDIR/copy_$size.png 10 replace" >>  $PNGDIR/copy.conf
echo "$size 18 18 $PNGDIR/crosshair_$size.png 10 replace" >>  $PNGDIR/crosshair.conf
echo "$size 2 2 $PNGDIR/default_$size.png 10 replace" >>  $PNGDIR/default.conf
# echo "$size 32 18 $PNGDIR/e-resize_$size.png 10 replace" >>  $PNGDIR/e-resize.conf
# echo "$size 27 7 $PNGDIR/ne-resize_$size.png 10 replace" >>  $PNGDIR/ne-resize.conf
echo "$size 2 2 $PNGDIR/no-drop_$size.png 10 replace" >>  $PNGDIR/no-drop.conf
echo "$size 2 2 $PNGDIR/not-allowed_$size.png 10 replace" >> $PNGDIR/not-allowed.conf
# echo "$size 18 3 $PNGDIR/n-resize_$size.png 10 replace" >>  $PNGDIR/n-resize.conf
# echo "$size 8 8 $PNGDIR/nw-resize_$size.png 10 replace" >>  $PNGDIR/nw-resize.conf
echo "$size 18 18 $PNGDIR/row-resize_$size.png 10 replace" >>  $PNGDIR/row-resize.conf
# echo "$size 29 29 $PNGDIR/se-resize_$size.png 10 replace" >>  $PNGDIR/se-resize.conf
# echo "$size 18 32 $PNGDIR/s-resize_$size.png 10 replace" >>  $PNGDIR/s-resize.conf
# echo "$size 9 26 $PNGDIR/sw-resize_$size.png 10 replace" >>  $PNGDIR/sw-resize.conf
echo "$size 4 19 $PNGDIR/text_$size.png 10 replace" >>  $PNGDIR/text.conf
echo "$size 18 18 $PNGDIR/vertical-text_$size.png 10 replace" >>  $PNGDIR/vertical-text.conf
# echo "$size 2 18 $PNGDIR/w-resize_$size.png 10 replace" >>  $PNGDIR/w-resize.conf
echo "$size 3 10 $PNGDIR/pointer_$size.png 10 replace" >>  $PNGDIR/pointer.conf
echo "$size 2 2 $PNGDIR/help_$size.png 10 replace" >>  $PNGDIR/help.conf
echo "$size `echo "scale=1; (21/36)*size" | bc | cut -d . -f -1` `echo "scale=1; (2/36)*$size" | bc | cut -d . -f -1` $PNGDIR/right-arrow_$size.png 10 replace" >>  $PNGDIR/right-arrow.conf
# This one's not in there, but I put it there for good measure
# as some desktops (Xfce, for one) use it.
# Could be symlinked to 'all-scroll' or 'copy' if you don't like it.
echo "$size 2 2 $PNGDIR/move_$size.png 10 replace" >>  $PNGDIR/move.conf

# Cursors from "nice to have" and "up for discussion" entries
echo "$size 2 2 $PNGDIR/context-menu_$size.png 10 replace" >>  $PNGDIR/context-menu.conf
echo "$size `echo "scale=1; (12/36)*$size" | bc | cut -d . -f -1` `echo "scale=1; (1/36)*$size" | bc | cut -d . -f -1` $PNGDIR/up-arrow_$size.png 10 replace" >>  $PNGDIR/up-arrow.conf
 echo "$size 16 12 $PNGDIR/ew-resize_$size.png 10 replace" >>  $PNGDIR/ew-resize.conf
 echo "$size 18 18 $PNGDIR/nesw-resize_$size.png 10 replace" >>  $PNGDIR/nesw-resize.conf
 echo "$size 18 18 $PNGDIR/ns-resize_$size.png 10 replace" >>  $PNGDIR/ns-resize.conf
 echo "$size 18 18 $PNGDIR/nwse-resize_$size.png 10 replace" >>  $PNGDIR/nwse-resize.conf
echo "$size 1 1 $PNGDIR/color-picker_$size.png 10 replace" >>  $PNGDIR/color-picker.conf

# Cursors not in the spec, but nice to have for completeness
echo "$size 7 6 $PNGDIR/grabbing_$size.png 10 replace" >>  $PNGDIR/grabbing.conf
echo "$size 1 18 $PNGDIR/pencil_$size.png 10 replace" >>  $PNGDIR/pencil.conf
echo "$size 18 18 $PNGDIR/pirate_$size.png 10 replace" >>  $PNGDIR/pirate.conf
echo "$size 18 18 $PNGDIR/X-cursor_$size.png 10 replace" >>  $PNGDIR/X-cursor.conf
echo "$size 18 18 $PNGDIR/zoom-in_$size.png 10 replace" >>  $PNGDIR/zoom-in.conf
echo "$size 18 18 $PNGDIR/zoom-out_$size.png 10 replace" >>  $PNGDIR/zoom-out.conf
done 

#making cursors
cd $PNGDIR
for conf in *.conf; do
cat $conf | xcursorgen - $CURSDIR/$(basename $conf .conf)
done
cd $MAINDIR

# Animated cursors
echo "Making animated cursors..."
cat > $ANIDIR/wait.conf <<EOF
36 11 6 busy-1_36.png 100
36 11 6 busy-2_36.png 100
36 11 6 busy-4_36.png 100
36 11 6 busy-5_36.png 100
36 11 6 busy-6_36.png 100
36 11 6 busy-7_36.png 100
36 11 6 busy-8_36.png 100
EOF

cat > $ANIDIR/progress.conf <<EOF
36 2 2 half-busy-1_36.png 100
36 2 2 half-busy-2_36.png 100
36 2 2 half-busy-4_36.png 100
36 2 2 half-busy-5_36.png 100
36 2 2 half-busy-6_36.png 100
36 2 2 half-busy-7_36.png 100
36 2 2 half-busy-8_36.png 100
EOF

cd $ANIDIR
xcursorgen $ANIDIR/wait.conf $CURSDIR/wait
xcursorgen $ANIDIR/progress.conf $CURSDIR/progress
cd $MAINDIR

# Source links for legacy and hash cursors
echo "Making legacy links..."
cd $CURSDIR
source $MAINDIR/links.txt
cd $MAINDIR

# Generate Theme file
echo "Generating theme index file..."
cat > $MAINDIR/kanon/index.theme <<EOF
[Icon Theme]
Name = Classicia
Comment = Classical cursor.
EOF

echo -e "Building complete.\nPlease run 'install.sh'."
exit 0
