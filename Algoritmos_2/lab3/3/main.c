/*
  @file main.c
  @brief Main program function implementation
*/
#include <stdio.h>
#include <stdlib.h>
/** @brief structure which represent a person */
typedef struct _person {
    int age;
    char name_initial;
} person_t;

/**
 * @brief Main program function
 *
 * @return EXIT_SUCCESS when programs executes correctly, EXIT_FAILURE otherwise
 */
int main(void) {

  int *p = NULL;
  char *q = NULL;

  int x = 1;
  person_t m = {90, 'M'};
  int a[] = {0, 1, 2, 3};

     p = &x; //digo que x tendra esa direccion de memoria
    *p = 5;
    printf("x = %d\n", x);
     p = &m.age;
     q = &m.name_initial;
    *p = 100;
    *q = 'F';
    printf("m = (%d, %c)\n", m.age, m.name_initial);
     p = &a[1];
    *p = 42;
    printf("a[1] = %d\n", a[1]);



     /* Completar aquí:
        Al finalizar la ejecución las variables deben tener los siguientes valores
        x = 9
        m = (100, F)
        a[1] = 42

        Las restricciones son:
        - No usar las variables 'x', 'm' y 'a' en la parte izquierda de alguna asignación.
        - Se pueden agregar líneas de código, pero no modificar las que ya existen.
        - Se pueden declarar hasta 2 punteros.
        AYUDA: podes usar GDB para consultares valores de variables y la dirección de memoria donde estan alojadas.
     */


     //p = &x;
     //printf("la direccion de memoria del puntero es %p \n", p);
     //printf("el valor del puntero es %d \n", *p );
     //*p = 5;
      //printf("el nuevo valor de p es %d",*p);


}
