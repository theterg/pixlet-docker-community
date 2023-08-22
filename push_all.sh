#!/bin/sh

device="dismally-deserving-fortified-chub-f32"

cd community/
pixlet render apps/nycairquality/nyc_air_quality.star 
pixlet push --installation-id nycairquality ${device} apps/nycairquality/nyc_air_quality.webp
# pixlet render apps/weatherplots/weather_plots.star location="{\"lat\":40.68,\"lng\":-73.97,\"timezone\":\"America/New_York\"}" window=9 
# pixlet push --installation-id weatherplots ${device} apps/weatherplots/weather_plots.webp
