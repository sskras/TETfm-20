#!/bin/bash

LD4-20211207-SSH-session-along-Zoom.times.ORIG | awk '{TIME+=$1; if($1>60) {$1/=47} print}' > LD4-20211207-SSH-session-along-Zoom.times
