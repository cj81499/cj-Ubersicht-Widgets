# from time import sleep
from pyowm import OWM
import json
import requests

apikey = '???'  # get at http://openweathermap.org
units = 'F'  # 'F', 'C', or 'K'
decimals = 0  # 0, 1, 2
showunits = False  # True, False


def checkNet():
    try:
        response = requests.get("https://google.com")
        return True
    except(requests.ConnectionError):
        return False


def checkAPI():
    try:
        return owm.is_API_online()
    except(Exception):
        return False


online = checkNet()
if online is True:
    owm = OWM(apikey)
    api_connect = checkAPI()
    if api_connect is True:
        payload = {'fields': 'countryCode,regionName,city'}
        response = requests.get('http://ip-api.com/json/', params=payload)
        data = response.content
        # print(response.text, response.content)
        output = json.loads(data)
        city = output['city']
        region_name = output['regionName']
        country_code = output['countryCode']

        search = ', '.join([city, region_name, country_code])
        # print(search)

        forecast = owm.daily_forecast(search)
        observation = owm.weather_at_place(search)
        weather = observation.get_weather()
        status = str(weather.get_status().title())
        detailed_status = str(weather.get_detailed_status().title())
        unit_transfer = {"C": 'celsius', "F": 'fahrenheit', 'K': 'kelvin'}
        search_units = unit_transfer[units]
        temp = round(weather.get_temperature(search_units)['temp'], decimals)
        if decimals == 0:
            temp = int(float(temp))
        temp = str(temp)
        # print(temp)

        outputs = [api_connect, temp, status, city, units, showunits, decimals]

        for n in range(len(outputs)):
            outputs[n] = str(outputs[n])

        print(' : '.join(outputs))
    else:
        print('False : API')
else:
    print('False : Internet')
