FoursquareAttendanceForecasting
=================================

This project contains the programs that can forecast the level of attendance of several venues, using the time series outputs of the [Foursquare Attendance Crawler](https://github.com/SmartSearch/Foursquare-Attendance-Crawler). You need to use the settings defined in the `etc/settings.json` of the Foursquare Attendance Crawler. 

## Requirements

Software:
* R >= 3.0.2

R packages:
* tools
* parallel
* forecast

## Setup

First, change the path to the settings file in `utils/settings.R` (line 28) to the appropriate settings file.
An example of such file is available here: https://github.com/SmartSearch/Foursquare-Attendance-Crawler/blob/master/etc/settings-example.json.
The forecasting is executed as follows:

```
 $ Rscript parallel_forecast.R london
```

Note that it can take a lot of time depending on your machine and the number of cores available.
*Currently it uses 8 cores, you might want to change this number (`mc.cores` property) if your machine have less than 8 cores.*
