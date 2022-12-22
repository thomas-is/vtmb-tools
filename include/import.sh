#!/bin/bash

backup() {
  if [ ! -f "$VDATA_SYSTEM/clandoc000.txt" ] ; then
    echo "can't find $VDATA_SYSTEM/clandoc000.txt"
    exit 1
  fi
  if [ ! -f "$VDATA_SYSTEM/clandoc000.txt.bak" ] ; then
    cp "$VDATA_SYSTEM/clandoc000.txt" "$VDATA_SYSTEM/clandoc000.txt.bak"
  fi
}

restore() {
  if [ ! -f "$VDATA_SYSTEM/clandoc000.txt.bak" ] ; then
    echo "can't find $VDATA_SYSTEM/clandoc000.txt.bak"
    exit 1
  fi
  echo "restore $VDATA_SYSTEM/clandoc000.txt"
  cp "$VDATA_SYSTEM/clandoc000.txt.bak" "$VDATA_SYSTEM/clandoc000.txt"
}

escape() {
  echo $@ | sed 's/\//\\\//g'
}

filename() {
  echo $1 | rev | cut -f1 -d"/" | rev
}

import() {
  echo "$1 $2"
  PC_MODELS="$( escape $( $1 ) )"
  NPC_MODEL="$( escape $( $2 ) )"
  if [ "$PC_MODELS" = "" ] ; then
    echo "Empty PC_MODELS!"
    exit 1
  fi
  if [ "$NPC_MODEL" = "" ] ; then
    echo "Empty NPC_MODEL!"
    exit 1
  fi
  for MODEL in $PC_MODELS
  do
    printf "  %-32s > %-32s\n" "$( filename $MODEL )" "$( filename $NPC_MODEL )"
    sed -i "s/$MODEL/$NPC_MODEL/g" $VDATA_SYSTEM/clandoc000.txt
  done
}


