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


# This file contains utilities for loading the settings and parameters
# used by programs related to crawling and forecasting the attendance
# of Foursquare venues.
#
# It is intended to mirror the `Settings` class of the FoursquareAttendanceCrawler
# project (see https://github.com/SmartSearch/Foursquare-Attendance-Crawler).


suppressPackageStartupMessages(library(jsonlite,quietly=T,verbose=F))

settingsPath <- "/path/to/attendance/crawl/folder/etc/settings.json"

loadedJSON <- NULL

loadJSON <- function() {
  loadedJSON <<- fromJSON(settingsPath)
}

getFolder <- function() {
# Returns the folder where all the attendance data has been downloaded.
  if(is.null(loadedJSON))
    loadJSON()

  path <- loadedJSON$crawl_folder
  if(substr(path,nchar(path),nchar(path)) != .Platform$file.sep)
    path <- paste(path, .Platform$file.sep, sep = "")

  return(path)
}

getCityCenterLat <- function (city) {
  if(is.null(loadedJSON))
    loadJSON()

  return(loadedJSON$centers[[city]]$lat)
}

getCityCenterLng <- function(city) {
  if(is.null(loadedJSON))
    loadJSON()

  return(loadedJSON$centers[[city]]$lng)
}

getCityTimezone <- function(city) {
  if(is.null(loadedJSON))
    loadJSON()

  return(loadedJSON$timezones[[city]])
}

getCityCredentialsSecret <- function(city) {
  if(is.null(loadedJSON))
    loadJSON()

  return(loadedJSON$foursquare_api_accounts[[city]]$client_secret)
}

getCityCredentialsId <- function(city) {
  if(is.null(loadedJSON))
    loadJSON()

  return(loadedJSON$foursquare_api_accounts[[city]]$client_id)
}
