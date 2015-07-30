set -x

#Little bash script to grab code off nci 
mkdir -p  ~/codescratch/nci/cdftools2
mkdir -p  ~/codescratch/nci/cdftools3
rsync -havz --delete cyb561@raijin.nci.org.au:/home/561/cyb561/cdftools/ ~/codescratch/nci/cdftools2/ --include="*/" --include="*.f90"  --exclude="*"

rsync -havz --delete cyb561@raijin.nci.org.au:/home/561/cyb561/cdftools/temp/CDFTOOLS_3.0 ~/codescratch/nci/cdftools3/ --include="*/" --include="*.f90"  --exclude="*"

