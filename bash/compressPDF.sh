#!/usr/bin/bash

echo -e "Script compressPDF.sh started.\n"

echo -e "Usage: ./compressPDF.sh inputfile.pdf outputfile.pdf"
echo -e "Output file extension should be .pdf for PDF viewer."
echo -e "This script uses pdfinfo to display PDF metadata,"
echo -e "GhostScrupt (gs) to compress PDF, and evince to "
echo -e "view output PDF file.\n"

# Script takes two arguments
inputFile=$1
outputFile=$2

if [[ $# -ne 2 ]]; then
        echo -e "Check the script arguments!"
        echo -e "Usage: ./compressPDF.sh inputfile.pdf outputfile.pdf"
        exit 255
fi

# Input file
echo -e "Input file"
pdfinfo $inputFile

echo -e "\nCompress PDF using GhostScript (gs) and view using evince. \n"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$outputFile $inputFile

# Output file
echo -e "Output file"
pdfinfo $outputFile

echo -e "\nInput file was, see size "
ls -lh $inputFile

echo -e "\nOutput file is, see size "
ls -lh $outputFile

echo -e "\nScript processed `stat -c %s $inputFile` bytes to generate `stat -c %s $outputFile` bytes \n"

echo -e "Trying to open output PDF file using evince. \n"

evince $outputFile &

echo -e "Done\n"
echo -e "That's all!\n"
