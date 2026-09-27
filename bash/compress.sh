#!/usr/bin/env bash

# For PDFs, Ghost Script provides one of the best compression outputs using the
# PDFSETTINGS option with allowed values: printer, ebook, and screen
# printer (300 dpi) 
# ebook (150 dpi) 
# screen (72 dpi) 

# Validate number of arguments
if [[ $# -lt 2 ]]
  then
    echo -e "Insufficient arguments! Exiting.\n"
    exit 255
fi

# Validate input_file
if [[ -e $1 ]]
  then
    input_file=$1
    echo -e "Input file is: $1\n"
else
    echo -e "Input file not valid, or does not exist.\n"
    exit 254
fi

# Validate PDF_OPT
if [[ $2 == "printer" ]]
  then
    PDF_OPT="printer"
    echo -e "PDFSETTINGS is set to printer (300 dpi) \n"
elif [[ $2 == "ebook" ]]
  then
    PDF_OPT="ebook"
    echo -e "PDFSETTINGS is set to ebook (150 dpi) \n"
elif [[ $2 == "screen" ]]
  then
    PDF_OPT="screen"
    echo -e "PDFSETTINGS is set to screen (72 dpi) \n"
else
    echo -e "PDFSETTINGS is not set to printer/ebook/screen\n"
    echo -e "Exiting for now.\n"
    exit 253
fi

# Output is: output_file
output_file="$PDF_OPT"_"$input_file"
echo -e "output_file is set to: $output_file"

echo -e "Before running gs, print input_file, PDF_OPT, output_file "
echo -e "input_file : $input_file"
echo -e "PDF_OPT : $PDF_OPT"
echo -e "output_file : $output_file"

# Command to invoke Ghost Script or gs is:
GS_CMD="gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$PDF_OPT -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file"
echo -e "Executing $GS_CMD"
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$PDF_OPT -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$output_file $input_file

ls -lrt $input_file
ls -lrt $output_file

