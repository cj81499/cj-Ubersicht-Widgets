# 'weatherbang' - originally an openbox conky script
# add all of this as a shell script for GeekTool and configure as needed.
# A TON of this was stolen directly from Frederic Cambus, thanks!
#
# jq required for use:  http://stedolan.github.io/jq/
# Optionally just use brew:  'brew install jq'

# User configurables below:
# Uncomment this line for fahrenheit:
# metric='imperial' && unit='F'
# Otherwise comment above line, uncomment here for celcius:
metric='imperial' && unit='F' && location="Pittsford,US"

# First, geolocate our IP:
ipinfo=$(curl -s ipinfo.io)
latlong=$(echo $ipinfo | /usr/local/bin/jq -r '.loc')
# Parse the latitude and longitude into their own values
lat=${latlong%,*}
long=${latlong#*,}

# Top is default auto locating. Bottom is for Pittsford, US
weather=$(curl -s http://api.openweathermap.org/data/2.5/weather\?lat\=${lat}\&lon\=${long}\&units\=${metric})
# weather=$(curl -s http://api.openweathermap.org/data/2.5/weather\?q\=${location}\&units\=${metric})
city=$(echo $weather | /usr/local/bin/jq -r '.name')
temperature=$(printf '%.0f' $(echo $weather | /usr/local/bin/jq '.main.temp'))
condition=$(echo $weather | /usr/local/bin/jq -r '.weather[0].main')

echo "$city"
echo "$condition"
echo "$temperature°"