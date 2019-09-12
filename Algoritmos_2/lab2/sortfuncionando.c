#include <stdio.h>

int main (){
void swap(int array[], unsigned int i, unsigned int j) {
    int tmp = array[i];
    array[i] = array[j];
    array[j] = tmp;

}
unsigned int partition (int array[],unsigned int lft,unsigned int rgt) {
	unsigned int ppiv = lft;
	unsigned int i = lft+1;
	unsigned int j = rgt-1;
	while (i <= j) {
		if ( array[i] <= array[ppiv] ) {
			i++;
		}
		else if ( array[j] >= array[ppiv] ) {
			j--;
		}
		else if ( array[i] > array[ppiv] && array[j] < array[ppiv] ) {
			swap(array,i,j);
			i++;j--;
		}
	}
	swap(array,ppiv,j);
	ppiv = j;
	return ppiv;
}

void quick_sort_rec(int array[],unsigned int lft,unsigned int rgt) {
	if ( lft + 1 < rgt ) {
		unsigned int ppiv = partition(array,lft,rgt);
		quick_sort_rec(array,lft,ppiv);
		quick_sort_rec(array,ppiv+1,rgt);
	}
		
}

void quick_sort(int array[], unsigned int length) {0
	quick_sort_rec(array,array[0],(length == 0) ? 0: length - 1);
}
//-------------------------------------------------------------------------------------------
	void bubble_sort (int array[],unsigned int length) {
    for (unsigned int i = 0 ; i < length - 1; i++) {
        for (unsigned int j = 0 ; j < length - i - 1; j++) {
          if (array[j] > array[j+1]) {
            swap(array,j,j+1);
          }
        }
    }
}
	return 0;
}
