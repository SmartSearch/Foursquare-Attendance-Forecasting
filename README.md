FoursquareAttendanceForecasting
=================================

If you use this code for a research purpose, please use the following citation:

Romain Deveaud, M-Dyaa Albakour, Craig Macdonald, and Iadh Ounis. *Experiments with a Venue-Centric Model for Personalised and Time-Aware Venue Suggestion.* In CIKM 2015, Shanghai, China. http://dl.acm.org/citation.cfm?id=2806484

Bibtex:
```
@inproceedings{Deveaud:2015:EVM:2806416.2806484,
 author = {Deveaud, Romain and Albakour, M-Dyaa and Macdonald, Craig and Ounis, Iadh},
 title = {Experiments with a Venue-Centric Model for Personalisedand Time-Aware Venue Suggestion},
 booktitle = {Proceedings of the 24th ACM International on Conference on Information and Knowledge Management},
 series = {CIKM '15},
 year = {2015},
 isbn = {978-1-4503-3794-6},
 location = {Melbourne, Australia},
 pages = {53--62},
 numpages = {10},
 url = {http://doi.acm.org/10.1145/2806416.2806484},
 doi = {10.1145/2806416.2806484},
 acmid = {2806484},
 publisher = {ACM},
 address = {New York, NY, USA},
 keywords = {location-based social networks, personalisation, time series forecasting, venue recommendation},
} 
```



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
**Currently it uses 8 cores, you might want to change this number (`mc.cores` property) if your machine have less than 8 cores.**
