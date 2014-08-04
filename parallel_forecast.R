# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# SMART FP7 - Search engine for MultimediA enviRonment generated contenT  
# Webpage: http://smartfp7.eu                                             
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/. 
# 
# The Original Code is Copyright (c) 2012-2014 the University of Glasgow
# All Rights Reserved
# 
# Contributor(s):
#  @author Romain Deveaud <romain.deveaud at glasgow.ac.uk>
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

library(tools,quietly=T,verbose=F)
library(parallel,quietly=T,verbose=F)
suppressPackageStartupMessages(library("./forecast_attendance.R",quietly=T,verbose=F))

get_files <- function(city) {
  ts_files <- list.files(paste("/local/tr.smart/foursquare/",city,"_specific_crawl",sep=""),pattern="\\.ts$",full.names=T)
  return(ts_files)
}

args <- commandArgs()
files <- get_ts_files(args[6])
mclapply(files,update_forecast, city=args[6], mc.cores=8, mc.silent=T)
