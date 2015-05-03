#!/bin/sh

TARDIR=../gomi_alpha/image4app

ls ${TARDIR}/*blk-*.png | parallel mogrify -verbose -resize x750 {}
ls ${TARDIR}/*-list.png | parallel mogrify -verbose -resize x750 {}
ls ${TARDIR}/*.png | parallel pngquant -v --ext .png --force 256 {}
