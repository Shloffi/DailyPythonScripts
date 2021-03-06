#!/bin/bash
scramv1 project CMSSW CMSSW_6_2_12
cd CMSSW_6_2_12/src
eval `scramv1 runtime -sh`
tar -xf ../../dps.tar
cd DailyPythonScripts/
cd external/
rm -r vpython/
cd rootpy
make clean
cd ../RooUnfold
make clean
cd ../TopAnalysis
make clean
cd ../../
git submodule init && git submodule update
./setup.sh
eval `scramv1 runtime -sh`
. environment.sh
rm -r unfolding
mkdir unfolding
time python experimental/BLTUnfold/runJobsCrab.py -j $1

echo "Unfolding folder contents:"
ls unfolding
tar -cf unfolding.$2.$1.tar unfolding
mv unfolding.$2.$1.tar ../../../
echo "DailyPythonScripts folder contents:"
ls
echo "Base folder contents:"
ls ../../../