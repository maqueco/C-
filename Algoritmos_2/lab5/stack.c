#include <stdio.h>
#include <stdlib.h>
#include "assert.h"
#include "stack.h"

struct _stack_t {
    stack_elem_t value;
    stack_t next;
};


stack_t stack_empty() {
    stack_t emptystack = NULL;
    return emptystack;
}
// stack_t stack_empty() {
//     stack_t p = NULL;
//     return p;                   otra forma de hacer empty
// }

stack_t stack_push(stack_t pushedstack, stack_elem_t elem) {
    stack_t new_top = calloc (1, sizeof(struct _stack_t));
    //stack_t new_top = malloc (sizeof(stack_t)); funcionan los dos pero se
    //recomienda el calloc que inicializa con 0
    new_top -> value = elem;
    new_top -> next = pushedstack;
    pushedstack = new_top;
    return pushedstack;
}
/* calloc crea un nuevo bloque (por el '1', crearia dos nuevos bloques si fuese
 '2' y asi), "sizeof" (del tamaño) de un struct _stack_t, con su value y next.
 si hago calloc (2, sizeof(int)), crearia 2 bloques en los que pondria 0 (por
 "int") */

stack_t stack_pop(stack_t my_stack) {
    assert (my_stack != NULL);
        stack_t nuevo_stack;
        // nuevo_stack = malloc(sizeof(struct _stack_t));
        nuevo_stack = my_stack;
        my_stack = my_stack-> next;
        free(nuevo_stack);
    return my_stack;
}

// malloc reserva/guarda espacio en la memoria para la pila

unsigned int stack_size(stack_t s) {
    // inicializo una variable cantidad en 0
    unsigned int cantidad = 0u;
    /* creo una variable tipo stack_t "runner" igual a s, la cual uso para
    recorrer la pila */
    stack_t runner = s;
    /* mientras la nueva pila runner no sea nula, voy a recorrer toda la pila s,
    sumando 1 a la variable cantidad.*/
    while (runner != NULL) {
        runner = s->next;
        cantidad++;
    }
    /* devuevlo la cantidad de elementos de la pila*/
    return cantidad;
}

stack_elem_t stack_top(stack_t my_stack){
    assert (my_stack != NULL);
    stack_elem_t topp = my_stack -> value;
                /*while (topp != NULL) {
                        topp = s -> next;
                        topp++;
                }      Esta parte del codigo en vez de devolver el top, lo que
                       hace es recorrer la pila hasta el bottom y devolverlo.*/
    return topp;
}

bool stack_is_empty(stack_t s){
    bool vacio = false;
    if (s == NULL) {
        vacio = true;
    }
    return vacio;
}

/* bool stack_is_empty(stack_t s){
    bool vacio;
    if (s == NULL) {
        vacio = true;               OTRA FORMA MAS "ENTENDIBLE"
    }
    else {
        vacio = false;
    }
    return vacio;
} */

stack_elem_t *stack_to_array(stack_t my_stack){
    stack_elem_t *array_elem;
    unsigned int length = 0u;
    length = stack_size(my_stack);
        if (length == 0){
            array_elem = NULL;
    }
        /* else {
                length = length - 1u;
           } No hace falta porque cuando se accede al while el length ya es mas
             pequeño
        */
        unsigned int i = 0u;
    array_elem = calloc (length,sizeof(stack_elem_t));
    while (my_stack != NULL) {
        array_elem[i] = stack_top(my_stack);
        my_stack = my_stack -> next;
    }
    return array_elem;
}
/*    while (s != NULL){
        mystack2 = s;
        mystack2 = calloc(sizeof(struct _stack_t))
        mystack2 = s -> next;
    }*/

stack_t stack_destroy(stack_t s){
    /* assert (s != NULL);  No hace falta*/
    stack_t runner = s;
    while (runner != NULL) {
        runner = s -> next;
        free (s);
        s = runner;
    }
    return 0;
}
