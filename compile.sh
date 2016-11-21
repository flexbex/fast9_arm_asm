#!/bin/bash
COMP_FLAGS=" -Wall -mcpu=cortex-a53  -mfpu=neon-fp-armv8 -mfloat-abi=hard -mlittle-endian -munaligned-access -std=c++11"
g++ -c $COMP_FLAGS  fast9.s -o fast9.o
g++ -c $COMP_FLAGS  main.cpp -o main.o
g++ fast9.o main.o -o fast9 
./fast9