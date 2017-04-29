from subprocess import Popen, PIPE
from time import sleep
from pyowm import OWM
from sys import argv

def subprocessCmd(command):
    # Run command in terminal
    process = Popen(command, stdout=PIPE, shell=True)
    proc_stdout = process.communicate()[0].strip()
    return(proc_stdout)

def isOnline():
    ping = subprocessCmd('if ping -c 1 google.com >> /dev/null 2>&1; then echo online; else echo offline; fi;').decode('utf-8')
    if ping == 'offline':
        return False
    else:
        return True

def checkOnline(trials, wait):
    for x in range(trials):
        if isOnline():
            return True
        sleep(wait)
    return False

def unitFormat(units):
    if units == 'f' or units == 'F':
        return('fahrenheit')
    if units == 'c' or units == 'C':
        return('celsius')
    if units == 'k' or units == 'K':
        return('kelvin')

def getCode(large_str, small_str, end_char):
    # Get text within large_str that comes after small_str, but before end_char
    small_str_length = len(small_str)
    index_start = large_str.find(small_str) + small_str_length
    index_end = large_str[index_start :].find(end_char)
    code = large_str[index_start : index_start + index_end]
    return(code)

def getWeather():
    # Get information about current location from ipinfo.io
    output = str(subprocessCmd('curl -s ipinfo.io'))
    city_name = getCode(output, '"city": "', '"')
    region_name = getCode(output, '"region": "', '"')
    country_code = getCode(output, '"country": "', '"')
    search = city_name + ', ' + region_name + ', ' + country_code
    # Use pyowm to get weather info
    owm = OWM(API_key)
    observation = owm.weather_at_place(search)
    weather = observation.get_weather()
    temperature = str(weather.get_temperature(units))
    temperature = getCode(temperature, "'temp': ", ',')
    if decimals == 0:
        temperature = str(int(round(float(temperature), decimals)))
    else:
        temperature = str(round(float(temperature), decimals))
    conditions = weather.get_detailed_status().title()
    return(temperature + ' : ' + conditions + ' : ' + city_name)

def tryGetWeather(trials):
    for x in range(trials):
        try:
            return(getWeather())
        except:
            pass
    return('Error : Failed to get weather')

def main():
    global API_key, units, decimals
    if checkOnline(10, 2): # If online, get weather, otherwise, print an error.
        try: # Try to use settings from index.coffee, otherwise, use fallback options
            API_key = argv[1]
            units = argv[2]
            units = unitFormat(units)
            decimals = int(argv[3])
            if API_key != '???':
                try:
                    print(tryGetWeather(2))
                except:
                    print("Error : Couldn't get weather.")
            else:
                print("Error : Couldn't get inputs. (No API Key Set)")
        except:
            print("Error : Couldn't get inputs.")
    else:
        print('offline')
main()
