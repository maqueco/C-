/* Leandro Ramos 2011*/
/* Ejemplo para uso de GDB: test de primalidad con errores sin corregir e impresión de variables*/
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

int main(void){
	int i=1;
	int n;
	bool primo;

	printf("Ingrese un numero: ");
	scanf("%d",&n);
	printf("La variable n antes de ingresar al ciclo vale: %d\n",n);
	printf("El valor booleano de primo(0 = false, 1 = true) es %d\n",primo);
	if(n < 2){
		primo = false;
	}
	while ( i < n && primo){  
		printf("N modulo i = %d\n",n%i);
		if((n%i)==0){
			primo = false;
			printf("primo se hizo falso!\n");
		}
		i++;
		printf("%d\n",i);	
	}
	if(primo){
		printf("El numero %d que usted ingreso es primo!!!\n",n);
	}else{
		printf("El numero %d no es primo :( ya que es divisible por: %d\n",n,i);
	}
	return EXIT_SUCCESS;
	
}
