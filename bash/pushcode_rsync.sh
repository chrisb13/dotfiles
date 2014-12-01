set -x


#Little bash script to push code back to CCRC datadirs 


#push cms_analysis files
rsync -avz ~/codescratch/cms_analysis/*.py z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/

rsync -avz ~/codescratch/cms_analysis/cookies/*.py z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/cookies/

rsync -avz ~/codescratch/cms_analysis/validation/*.py z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/cms_analysis/validation/

#push swissarmy files
rsync -avz ~/codescratch/swissarmy/ z3457920@squall.ccrc.unsw.edu.au:/home/z3457920/hdrive/repos/swissarmy/ 

