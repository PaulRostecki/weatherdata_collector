# weatherdata_collector
This script was made to gather certain values regarding the weather and save it into .csv file automatically for further use or analysis.
It gathers info about temperature, perceptible temperature, current weather, humidity and wind speed, though it may also gather other values included in [OpenWeatherMap](https://openweathermap.org/) API responses.

You need your own [API key](https://openweathermap.org/api) in order to use the script.

Before initialazing the script, you need to set parameters in `config.json` file:
- API key
- City of interest (data is gathered for a specific city)
- Number of data samples
- Sampling frequency (in hours)
