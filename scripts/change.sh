#!/usr/bin/bash

#ext1=$1	 # Argumento ext1 es la extensión inicial 
#ext2=$2	 # Argumento ext2 es la extensión final 

echo 'entro';

RUTA1="/home/mecom2012/mecom/exp/100sample"
RUTA2="/home/mecom2012/mecom/exp/100sample/res"

for i in RUTA 
do 
if [ -f "$RUTA/$i" ]; then 
echo "SI";
arg=${i%%.'jpg'} 
#if [ ! -f "$RUTA/$arg" ]; then 
#arg1=${arg#$i} 
convert #" -resample 380x380 $RUTA/$arg1.$ext1" "$RUTA2/$arg1.$ext1" 
else
echo "NO";
fi
done 


exit 0
