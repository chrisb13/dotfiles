set -x

#Little bash script to grab code off CCRC datadirs 
mkdir -p  ~/codescratch/cms_analysis/
mkdir -p  ~/codescratch/swissarmy/
rsync -avz z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/*.py ~/codescratch/cms_analysis/ 
rsync -avz z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/cookies/*.py ~/codescratch/cms_analysis/cookies/ 
rsync -avz z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/validation/*.py ~/codescratch/cms_analysis/validation/ 

rsync -avz z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/swissarmy/ ~/codescratch/swissarmy/ 

