//weather_utils.c: Implementación de las funciones mencionadas a continuación.
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>


#include "array_helpers.h"
#include "weather_utils.h"

void array_years(WeatherTable array, int output[]){
  int max_t;
 
 
   for (unsigned int year = 0; year < YEARS; year++){
   	max_t = array[year][0][0]._max_temp;
        printf("["); 
      for (unsigned int month = 0; month < MONTHS; month++){

      	for (unsigned int day = 0; day < DAYS; month++ ) {
      		if (max_t < array[year][month][day]._max_temp){
      			max_t = array[year][month][day]._max_temp;
      			
      		}
      	}
      }
       output[year+1980] = max_t;
       printf("%d ,",output[year]);  
   }
 printf("] \n");
}










int tempMin (WeatherTable array){

    int tem_temp_m = array[0][0][0]._min_temp;
     
     for (unsigned int k_year = 0u; k_year < YEARS; k_year++){
     	for (unsigned int k_month = 0u; k_month < MONTHS; k_month++){
     		for (unsigned int k_day = 0u; k_day < DAYS; k_day++){
         		
         		if (tem_temp_m > array[k_year][k_month][k_day]._min_temp){
                    tem_temp_m = array[k_year][k_month][k_day]._min_temp;  
         		}
     		}
     	}
     }
    
   printf("\n\tlowest minimum temperature %d \n\n",tem_temp_m);
	return tem_temp_m;
}




