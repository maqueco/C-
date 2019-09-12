/*
  @file weather.c
  @brief Implements weather mesuarement structure and methods
*/
#include <stdlib.h>
#include "weather.h"

//static const int AMOUNT_OF_WEATHER_VARS = 6 ;

Weather weather_from_file(FILE* file) //le doy lo que quiero que abra con el puntero ya poicionado en la parte de climas de i fila
{
    Weather weather; //leer los datos del clima

 fscanf(file,EXPECTED_WEATHER_FILE_FORMAT, &weather._average_temp, &weather._max_temp, &weather._min_temp, &weather._pressure, &weather._moisture, &weather._rainfall); //usa la declaracion void, podria hacerlo con %u 6 veces y accedo a ellas con . (punto de weather, dijomos tuplas)

    return weather;	
}

void weather_to_file(FILE* file, Weather weather)
{
    fprintf(file, EXPECTED_WEATHER_FILE_FORMAT, weather._average_temp, 
            weather._max_temp, weather._min_temp, weather._pressure, weather._moisture, weather._rainfall);
}
