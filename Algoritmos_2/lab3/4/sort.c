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

bool goes_before(player_t x, player_t y){ //practicamente es la comparacion

 int value;
   if (x->rank <= y->rank) { //menor o igual fijate el por que
     value = true;
   } else {
     value = false;
   }

    return value;
}

bool array_is_sorted(player_t atp[], unsigned int length) {
    unsigned int i = 1u;
    while (i < length && goes_before(atp[i - 1u], atp[i])) {
        i++;
    }
    return (i == length);
}





void swap(player_t a[],int i,int min){

      player_t temp;
      player_t *px = &a[i];
      player_t *py = &a[min];       //el puntero tendra el valor de la direccion de memoria de tal cosa
                                    // en el otro esta con otro problema preguntar
      temp = a[i];
        *px = *py;
        *py = temp;



}

void insert(player_t a[],unsigned int i){
	unsigned int j = i;
	 while(j > 0 && goes_before(a[j],a[j-1])){
	 	swap(a,j,j-1);
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
