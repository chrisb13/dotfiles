set -x

#Little bash script to grab code off CCRC datadirs 
mkdir -p  ~/codescratch/cms_analysis/
mkdir -p  ~/codescratch/swissarmy/
rsync -havz --delete z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/ ~/codescratch/cms_analysis/ --include="*/" --include="*.py" --include="*.m" --include="*.md" --include="*.txt" --include="*.log" --include="*.sh" --include="*.list"  --include="*.nml" --exclude="*"
rsync -havz --delete z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/.git/ ~/codescratch/cms_analysis/.git/

rsync -havz z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/swissarmy/ ~/codescratch/swissarmy/ 

