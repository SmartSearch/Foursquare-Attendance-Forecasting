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
source("utils/settings.R")

forecast_attendance <- function(file,city,nb_days_train) {
  end <- NULL
  start <- NULL
  future_hours <- NULL
  num_hours_forecast <- 48
  
  # We read the time series file that has been obtained using the attendance
  # crawler.
  ts <- read.csv(file,sep=",",header=T)

  # We then determine the starting and ending points of the training period.
  if(is.null(end))
    end <- tail(which(as.numeric(format(as.POSIXlt(ts$Date), "%H")) == 23),n=1)
  if(is.null(start))
    start <- end+1-(strtoi(nb_days_train)*24)
  

  # This variable hold the time series that will be used to train the forecasting
  # model.
  nts <- ts[start:end,]

  # Defining the hours that will be forecasted. This program currently provides 
  # forecasts for the next 48 hours.
  if(is.null(future_hours))
    future_hours <- seq(from = as.POSIXlt(ts$Date[end])+3600, to = as.POSIXlt(ts$Date[end])+num_hours_forecast*3600, by = "hour")
  
  response <- matrix(NA,nrow=length(future_hours),ncol=1)
  
  eventdata <- ts(nts$here_now, frequency=24)
  
  if(all(nts$here_now == 0) || (length(setdiff(nts$here_now,rep(0,24))) < 2)) {
    for(i in 1:length(future_hours))
      response[i,] <- paste(format(future_hours[i],"%Y-%m-%d %H:%M:%S"),0,sep=",")
  }
  else {
    # Uncomment these four lines if you want to forecast using Neural Networks.
    #
    #fit <- nnetar(eventdata)
    #fore_nnet<-forecast(fit,h=48)
    #neural_nets  <- as.data.frame(fore_nnet)$Point
    #neural_nets[neural_nets<0] <- 0
    
    # Uncomment these four lines if you want to forecast using Exponential Smoothing.
    #
    #fit<-ets(eventdata,opt.crit='mse')
    #fore_ets<-forecast(fit,48)
    #exp_smooth  <- as.data.frame(fore_ets)$Point
    #exp_smooth[exp_smooth<0] <- 0
    

    # As ARIMA showed the best results, we only use this method here.
    # However, its accuracy comes at the expense of running time, if you
    # need a fast method you might want to use ETS.
    #
    fit<-auto.arima(eventdata)
    fore_arima<-forecast(fit,h=48)
  
    # Formatting the results of the forecasts.
    arima  <- as.data.frame(fore_arima)$Point
    arima[arima<0] <- 0
    
    for(i in 1:length(future_hours))
      response[i,] <- paste(format(future_hours[i],"%Y-%m-%d %H:%M:%S"),arima[i],sep=",")
  }
    
  return(response)
}
