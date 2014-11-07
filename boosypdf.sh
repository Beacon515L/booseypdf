#!/bin/bash
#booseypdf.sh v1.0 by Beacon515L
#https://github.com/Beacon515L/booseypdf/
#Usage: booseypdf.sh base_path outputfile.pdf
#Dependencies: wget, sed, tr, swfextract, imagemagick, pdfunite, find, awk
BASE_PATH="$1"
OUTPUT_FILE="$2"

mkdir temp
cd temp
echo "Getting and Parsing Metadata..."
wget -q -O - http://www.boosey.com/${BASE_PATH}/files/info.xml | sed  -e 's/FileSize.*//' -n -e 's/Zoomed Path=//p' | tr -d '<" ' | sed "s|^|http://www.boosey.com/${BASE_PATH}/|" | wget --progress=bar -i -
find -name '*.swf' | # find swfs
gawk 'BEGIN{ a=1 }{ printf "mv %s %04d.swf\n", $0, a++ }' | # build mv command
bash # run that command
echo "Extracting SWFs..."
for i in *.swf; do swfextract -p 2 -o $i.png $i; done
rm *.swf
echo "Converting to PDFs..."
for i in *.png; do convert $i $i.pdf; done
rm *.png
echo "Creating output file..."
ls -1r *.pdf | tr '\n' ' ' | sed "s/$/\ ${OUTPUT_FILE}/" | xargs pdfunite
mv ${OUTPUT_FILE} ..
cd ..
rm -R temp
echo "Done!"
