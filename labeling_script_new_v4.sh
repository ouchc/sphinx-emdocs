#/bin/bash
#########################################
# Set Parameters Here
# Only use integer values for scale_length
# Set scale length in nanometers
#
# Scale label is offset from left side of scale bar
# adjust this value to center label. Current values
# work well with these scale bar length and label names
# for each magnification

# Magification #1
mag1="1750"
apix1="32.91"
scale_length_1="1000"
scale_label_1="1000 nm"
scale_label_offset_1="10"

# Magnification #2
mag2="17.5k"
apix2="2.277"
scale_length_2="100"
scale_label_2="100 nm"
scale_label_offset_2="55"

# Magnification #3
mag3="45k"
apix3="0.87"
scale_length_3="50"
scale_label_3="50 nm"
scale_label_offset_3="100"

# Scale bar location options
# We will use coordinate 2750,1900 as an anchor point for the right-most position on our scale bar. labeling will be relative to that point.
scale_x2="2750"
y_anchor="1900"

# Fonts will be positioned at a y value of 1940
y_text="1940"

#########################################
# Multiply pixel size by 1000 to work with integers

apix1_x1000=$(echo $apix1 | awk '{ print $1 * 1000}')
apix2_x1000=$(echo $apix2 | awk '{ print $1 * 1000}')
apix3_x1000=$(echo $apix3 | awk '{ print $1 * 1000}')

mkdir -p ${mag1}
mkdir -p ${mag2}
mkdir -p ${mag3}


# Magnification 1 
# Divide by 2 since we are shrinking images by 50%
# and position label with offset pixels from the left side of the scale bar.
scale_length_in_pix_1=$( echo $scale_length_1 $apix1 | awk '{ printf "%.0f", $1 / $2 *10 / 2}')
scale_mag1_x1=$(( $scale_x2 - $scale_length_in_pix_1 ))
scale_label_mag1_x1=$(( $scale_mag1_x1 + $scale_label_offset_1 ))

# Magnification 2
scale_length_in_pix_2=$( echo $scale_length_2 $apix2 | awk '{ printf "%.0f", $1 / $2 *10 / 2}')
scale_mag2_x1=$(( $scale_x2 - $scale_length_in_pix_2 ))
scale_label_mag2_x1=$(( $scale_mag2_x1 + $scale_label_offset_2 ))

# Magnification 3
scale_length_in_pix_3=$( echo $scale_length_3 $apix3 | awk '{ printf "%.0f", $1 / $2 *10 / 2}')
scale_mag3_x1=$(( $scale_x2 - $scale_length_in_pix_3 ))
scale_label_mag3_x1=$(( $scale_mag3_x1 + $scale_label_offset_3 ))

for stack_file in *.st;
    do
    
    # Grab base filename of stack
    echo ""
    echo "Working on $stack_file"
    stack_name=$(echo $stack_file | sed 's|.st||g')
    pix_size=$(header $stack_file | grep Pixel | sed 's|.*[ ]\([ 0-9][ 0-9][ 0-9][ 0-9].[ 0-9][ 0-9][ 0-9][ 0-9]\).*|\1|g' | xargs printf '%0.4f')
    # avoid using bc for comparision on pixel size. Multiply by 1000 to work with integer values instead of floating point
    pix_size_x1000=$(echo $pix_size | awk '{ print $1 * 1000 }')
    #if [ $(echo "${pix_size} > 1000.0" | bc -l) -eq 1 ];
    #echo $pix_size_x1000
    if [ ${pix_size_x1000} -gt ${apix1_x1000} ];
        then
        echo "Skipping LMM stack"
        echo ""

    # Loop for mag1
    elif [ ${pix_size_x1000} -eq ${apix1_x1000} ];
    #elif [ $(echo "${pix_size} > 10.0" | bc -l) -eq 1 ];
        then
        mrc2tif $stack_name.st ${mag1}/$stack_name
        
        for tif_file in ${mag1}/*.tif 
            do
            base_name=$(echo $tif_file | sed 's|.tif||g')
            echo "Writing $base_name.jpg"
            convert $base_name.tif -resize 50% -normalize temp.jpg
            convert temp.jpg -fill black -stroke black -strokewidth 14 -draw "line ${scale_mag1_x1},${y_anchor},${scale_x2},${y_anchor}" -font Arial-bold -pointsize 32 -fill black -strokewidth 1 -annotate +${scale_label_mag1_x1}+${y_text}  "$scale_label_1" $base_name.jpg
            done
        rm ${mag1}/*.tif
        echo ""
        echo "$stack_name done"
        echo ""
        echo ""
    
    # Loop for mag2
    elif [ ${pix_size_x1000} -eq ${apix2_x1000} ];
    #elif [ $(echo "$pix_size > 1.0" | bc -l) -eq 1 ];
        then
        mrc2tif $stack_name.st ${mag2}/$stack_name
        
        for tif_file in ${mag2}/*.tif 
            do
            base_name=$(echo $tif_file | sed 's|.tif||g')
            echo "Writing $base_name.jpg"
            convert $base_name.tif -resize 50% -normalize temp.jpg
            convert temp.jpg -fill black -stroke black -strokewidth 14 -draw "line ${scale_mag2_x1},${y_anchor},${scale_x2},${y_anchor}" -font Arial-bold -pointsize 32 -fill black -strokewidth 1 -annotate  +${scale_label_mag2_x1}+${y_text}  "$scale_label_2" $base_name.jpg
            done
        rm ${mag2}/*.tif
        echo ""
        echo "$stack_name done"
        echo ""
        echo ""
    
    # Loop for mag3
    elif [ ${pix_size_x1000} -eq ${apix3_x1000} ];
    #elif [ $(echo "$pix_size < 1.0" | bc -l) -eq 1 ];
        then
        mrc2tif $stack_name.st ${mag3}/$stack_name
        
        for tif_file in ${mag3}/*.tif 
            do
            base_name=$(echo $tif_file | sed 's|.tif||g')
            echo "Writing $base_name.jpg"
            convert $base_name.tif -resize 50% -normalize temp.jpg
            convert temp.jpg -fill black -stroke black -strokewidth 14 -draw "line ${scale_mag3_x1},${y_anchor},${scale_x2},${y_anchor}" -font Arial-bold -pointsize 32 -fill black -strokewidth 1 -annotate +${scale_label_mag3_x1}+${y_text}  "$scale_label_3" $base_name.jpg
            done
        rm ${mag3}/*.tif
        echo ""
        echo "$stack_name done"
        echo ""
        echo ""
    fi

done

rm temp.jpg

echo "ALL DONE!"
