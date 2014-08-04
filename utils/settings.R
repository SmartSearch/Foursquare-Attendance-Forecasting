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


library(jsonlite)

loadedJSON <- NULL

loadJSON <- function(path) {
  loadedJSON <<- fromJSON(path)
}

getFolder <- function() {
}

loadJSON("/users/staff/romain/workspace/FoursquareAttendanceCrawler/etc/settings.json")
