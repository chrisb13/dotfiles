set -x

#Little bash script to push code back to CCRC datadirs 

#push cms_analysis files
#note that I have not included delete option so files deleted locally will not
#be mirrored back to CCRC datadirs
rsync -havz ~/codescratch/cms_analysis/ z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/ --include="*/" --include="*.py"  --include="*.md" --include="*.txt" --include="*.log" --include="*.sh" --include="*.list"  --include="*.nml" --exclude="*"

#push swissarmy files
rsync -avz ~/codescratch/swissarmy/ z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/swissarmy/ 

