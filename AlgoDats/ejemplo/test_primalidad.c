/* Leandro Ramos 2011*/
/* Ejemplo para uso de GDB: test de primalidad con errores ya corregidos*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

int main(void){
	int i=2;
	int n;
	bool primo=true;

	printf("Ingrese un numero: ");
	scanf("%d",&n);
	if(n < 2){
		primo = false;
	}
	while ( i < n && primo){  
		if((n%i)==0){
			primo = false;
		}
		i++;
	}
	if(primo){
		printf("El numero %d que usted ingreso es primo!!!\n",n);
	}else{
		printf("El numero %d no es primo :(\n",n);
	}
	return EXIT_SUCCESS;
	
}

