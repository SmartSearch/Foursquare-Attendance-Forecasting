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
 
options(warn=-1)
suppressPackageStartupMessages(library(forecast,quietly=T,verbose=F))

forecast_attendance <- function(f,city) {
  write(f, stderr())
#  forecast_file <- paste("/local/tr.smart/foursquare/",city,"_forecasts/live_arima/",f,".forecast",sep="")
#  if(file.exists(forecast_file) && (Sys.Date() <= as.Date(file.info(forecast_file)$mtime)))
#    return()

  end <- NULL
  start <- NULL
  future_hours <- NULL
  
  ts <- read.csv(paste("/local/tr.smart/foursquare/",city,"_specific_crawl/",f,".ts",sep=""),sep=",",header=T)
  if(is.null(end))
    end <- tail(which(as.numeric(format(as.POSIXlt(ts$Date), "%H")) == 23),n=1)
  if(is.null(start))
    start <- end+1-(strtoi(28)*24)
    #start <- head(which(as.numeric(format(as.POSIXlt(ts$Date), "%H")) == 0),n=1)
  
  nts <- ts[start:end,]

  
  if(is.null(future_hours))
    future_hours <- seq(from = as.POSIXlt(ts$Date[end])+3600, to = as.POSIXlt(ts$Date[end])+48*3600, by = "hour")
  
  response <- matrix(NA,nrow=length(future_hours),ncol=1)
  
  eventdata <- ts(nts$here_now, frequency=24)
  
  if(all(nts$here_now == 0) || (length(setdiff(nts$here_now,rep(0,24))) < 2)) {
    for(i in 1:length(future_hours))
      response[i,] <- paste(format(future_hours[i],"%Y-%m-%d %H:%M:%S"),0,sep=",")
  }
  else {
    # we forecast using neural networks
    #fit <- nnetar(eventdata)
    #fore_nnet<-forecast(fit,h=48)
    
    #fit<-ets(eventdata,opt.crit='mse')
    #fore_ets<-forecast(fit,48)
    
    fit<-auto.arima(eventdata)
    fore_arima<-forecast(fit,h=48)
    
    #neural_nets  <- as.data.frame(fore_nnet)$Point
    #neural_nets[neural_nets<0] <- 0
    
    #exp_smooth  <- as.data.frame(fore_ets)$Point
    #exp_smooth[exp_smooth<0] <- 0
    
    arima  <- as.data.frame(fore_arima)$Point
    arima[arima<0] <- 0
    
    for(i in 1:length(future_hours))
      response[i,] <- paste(format(future_hours[i],"%Y-%m-%d %H:%M:%S"),arima[i],sep=",")
  }
    
#  write(response,file=forecast_file)
  return(response)
}
