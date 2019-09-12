#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../stack.h"

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: ./reverse <string-to-reverse>\n");
        exit(EXIT_FAILURE);
    }
    char *str = argv[1];

        stack_t my_stack = stack_empty();
        unsigned int length = strlen(str);
        for (unsigned int i = 0u; i < length ; i++) { //para las pilas de tamaño > 1?
            my_stack = stack_push(my_stack, str[i]);
        }
        for (unsigned int i = 0u; i < length; i++) {
            str[i] = (char)stack_top (my_stack);
            my_stack = stack_pop (my_stack);
            printf("%c", str[i]);
        }


// unsigned int i = 1 == i = 1u?
//printf("%s\n", str);
    stack_destroy(my_stack);
}
