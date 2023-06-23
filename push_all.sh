#!/bin/sh

device="dismally-deserving-fortified-chub-f32"

cd community/
pixlet render apps/nycairquality/nyc_air_quality.star 
pixlet push --installation-id nycairquality ${device} apps/nycairquality/nyc_air_quality.webp
