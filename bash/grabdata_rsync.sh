set -x

#Little bash script to grab data off CCRC datadirs 
mkdir -p  ~/data_temp/

#getting the toy files
rsync -avz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdcore01/output/pandasHDF/toyhdf/*.h5 ~/data_temp/expt_lc_fwdcore01_toy/ 
rsync -avz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdwesternboundary01/output/pandasHDF/toyhdf/*.h5 ~/data_temp/expt_lc_fwdwesternboundary01_toy/ 

#getting a big file
rsync -avz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdcore01/output/pandasHDF/*02*.h5 ~/data_temp/expt_lc_fwdcore01/ 
rsync -avz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/expt_lc_fwdwesternboundary01/output/pandasHDF/*02*.h5 ~/data_temp/expt_lc_fwdwesternboundary01/ 

#getting cookie files..
rsync -avz --progress z3457920@squall.ccrc.unsw.edu.au:/srv/ccrc/data32/z3457920/leeuwincurrent2/cookiecutting07/*.p ~/data_temp/cookie_cutters/

