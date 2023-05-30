#!/bin/bash

set -e

temp_rss_file="/tmp/liburd_movies.rss"

# Ensure the temporary file is deleted when the script exits
trap 'rm -f "$temp_rss_file"' EXIT

echo "Fetching newest Letterboxd RSS feed"
curl -s "https://letterboxd.com/liburd/rss/" -o "$temp_rss_file"

echo "Converting RSS to JSON"
bundle exec letterboxd_rss_to_json /tmp/liburd_movies.rss > /tmp/movies.json

movies_data_file="_data/movies.json"

# Remove data file
rm -rf "$movies_data_file"

# move json file into data dir
mv /tmp/movies.json _data/

echo "Data file created: $movies_data_file"

echo "Building site"
bundle exec jekyll build
