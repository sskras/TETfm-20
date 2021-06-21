#!/bin/bash

echo "$0: Startuoju, cmd-line: "$*

FNAME_PREFIX="saukrs-bandomasis"

ns kursinis-saukrs.tcl -- 2ms 0.00 $FNAME_PREFIX"_2ms_0%-loss_HSTCP_+_BIC"
