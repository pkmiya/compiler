#!/bin/bash
filename=$1
./gen "./data/${filename}.tc"
./exe "./data/${filename}.to"