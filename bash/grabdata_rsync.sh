set -x

#Little bash script to grab data off CCRC datadirs 
mkdir -p  ~/data_temp/

#getting the toy files
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdcore01/output/pandasHDF/toyhdf/*.h5 ~/data_temp/expt_lc_fwdcore01_toy/ 
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdwesternboundary01/output/pandasHDF/toyhdf/*.h5 ~/data_temp/expt_lc_fwdwesternboundary01_toy/ 

#getting a big file
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdcore01/output/pandasHDF/*02*.h5 ~/data_temp/expt_lc_fwdcore01/ 
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdwesternboundary01/output/pandasHDF/*02*.h5 ~/data_temp/expt_lc_fwdwesternboundary01/ 

#getting cookie files..
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/cookiecutting07/*.p ~/data_temp/cookie_cutters/

#getting some NEMO files..
rsync -havz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data23/z3457920/nemoforcingplot2/*ave* ~/data_temp/nemo_average_files/


