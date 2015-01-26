set -x

#Little bash script to grab plots off CCRC datadirs 
mkdir -p  ~/plot_temp/

#getting the toy files
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data42/z3457920/paper_plots/20141202_leeuwincurrent/* ~/plot_temp/
