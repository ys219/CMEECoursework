#!/bin/bash

for f in *.TIF:
    do
        echo "Converting $f";
        convert "$f" "$(basename "$f" .tif) . jpg";
    done
    