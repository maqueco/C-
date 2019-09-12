#include <stdio.h>
#include "sort.h"

int swaps = 0;
int compar = 0;

int main (){
bool array_is_sorted(int array[], unsigned int length) {
	unsigned int i = 1;
	bool ord = true;
	while ( i < length && ord ){
		ord = array[i-1] <= array[i] && ord;
	}
	return ord;
}

void insert (int array[], unsigned int i){
	unsigned int j = i;
	while (j>1 && array[j]<array[j-1]){
		swap(array,j-1,j);
		swaps++;
		j=j-1;
	}
}

void selection_sort(int array[], unsigned int length) {
	 unsigned int minp;
	 unsigned int i;
	 for ( i = 1; i < length; i++ ) {
	 	minp = i;
	 	unsigned int j;
	 	for ( j = i + 1; i < length; i++){
	 		if ( array[j] < array[minp]){
	 			minp = j;
	 			compar++;
	 		}
	 		int tmp = array[i];
	 		array[i] = array[j];
	 		array[j] = tmp;
	 	}
	 }
}
void swap(int array[], unsigned int i, unsigned int j) {
    int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;

}

void partition (int array[],unsigned int lft,unsigned int rgt,unsigned int ppiv) {
	ppiv = lft;
	unsigned int i = lft+1;
	unsigned int j = rgt;
	while ( i <= j ) {
		if ( array[i] <= array[ppiv] ) {
			i++;
			compar++;
		}
		else if ( array[j] >= array[ppiv] ) {
			j--;
			compar++;
		}
		else if ( array[i] > array[ppiv] && array[j] < array[ppiv] ) {
			swap(array,i,j);
			swaps++;
			compar++;
			i++;j--;
		}
	}
	swap(array,ppiv,j);
	swaps++;
	ppiv = j;
}

void quick_sort_rec(int array[],unsigned int lft,unsigned int rgt) {
	unsigned int ppiv = array[0];
	if ( lft < rgt ) {
		partition(array,lft,rgt,ppiv);
		quick_sort_rec(array,lft,ppiv-1);
		quick_sort_rec(array,ppiv+1,rgt);
		compar++;
	}
		
}

void quick_sort(int array[], unsigned int length) {
	quick_sort_rec(array,array[0],array[length-1]);
//  quick_sort_rec(array,array[0],(length == 0) ? 0: length - 1);
}
void bubble_sort(int array[], unsigned int length) {
	unsigned int i;
	unsigned int j;
    for (i = 0 ; i < length - 1; i++) {
        for (j = 0 ; j < length - i - 1; j++) {
          if (array[j] > array[j+1]) {
            swap(array, j, j+1);
            swaps++;
            compar++;
          }
        }
    }
}
	return 0;
}
