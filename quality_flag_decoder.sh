#!/bin/bash

# Description:
#   This script takes a 13-bit quality flag integer as input and performs the following:
#   1. Prints the binary representation of the quality flag.
#   2. Prints the bits that are set (true) in the quality flag along with their corresponding description.
#
# Usage:
#   ./quality_flag_decoder.sh <quality_flag>
#
# Parameters:
#   quality_flag: An integer representing the 13-bit quality flag.
#
# Example:
#   ./quality_flag_decoder.sh 1028
#   Output:
#     Binary representation: 0010000000100
#     Bit 2 is on (M_G<3.9 or M_G>8.5)
#     Bit 10 is on (Metallicity outlier)

# Check if the quality flag argument is provided
if [ $# -eq 0 ]; then
    echo "Please provide a quality flag integer as an argument."
    exit 1
fi

# Get the quality flag from the command line argument
quality_flag=$1

# Convert the quality flag to binary representation
binary_representation=$(printf "%013d" $(echo "obase=2; $quality_flag" | bc))

# Print the binary representation
echo "Binary representation: $binary_representation"

# Define an array of strings for each bit
bit_strings=(
    "T_eff /K ∈ \[3800 − 6200\]"
    "log g<4.2 or suspect logg"
    "M_G<3.9 or M_G>8.5"
    "In KEBC"
    "Large d_xmatch,Kep−Gaia"
    "Confused Kep-Gaia crossmatch"
    "Gaia DR3 non-single star"
    "RUWE>1.4"
    "Crowded"
    "Far from main-sequence"
    "Metallicity outlier"
    "S21 CP/CB"
    "P_rot not in the homogeneous S19 S21 sample"
)

# Iterate over each bit and print the bits that are set (true) along with their description
for ((i=0; i<13; i++)); do
    bit=$((quality_flag & (1 << i)))
    if [ $bit -ne 0 ]; then
        echo "Bit $i is on (${bit_strings[i]})"
    fi
done
