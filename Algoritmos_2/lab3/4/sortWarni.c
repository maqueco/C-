/*
  @file sort.c
  @brief sort functions implementation
*/

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "helpers.h"
#include "sort.h"
#include "player.h"

bool goes_before(player_t x, player_t y){
    // completar aquí
    return true;
}

bool array_is_sorted(player_t atp[], unsigned int length) {
    unsigned int i = 1u;
    while (i < length && goes_before(atp[i - 1u], atp[i])) {
        i++;
    }
    return (i == length);
}





void swap(player_t a[], player_t *px,player_t *py){ // erorr por que ya no me hace falta el arreglo ya le doy los valores en los punteros 

      player_t temp;
    //  player_t *px = a[i];
    //  player_t *py = a[min];

     temp = *px;
     *px = *py;
     *py = temp;



}







void insert(player_t a[],unsigned int i){
   player_t *px = NULL;
   player_t *py = NULL;
	unsigned int j = i;
	 while(j > 0 && a[j]->rank < a[j-1]->rank){
        px = &a[j] ;
        py = &a[j-1];
	 	swap(a,px,py);
	 	j = j-1;
	 }
}

void insertion_sort(player_t a[], unsigned int length){
    for(unsigned int i = 1; i < length; i++){
        insert(a,i);
    }
}



void sort(player_t a[], unsigned int length) {
    insertion_sort (a,length);
}
