#include <stdio.h>
#include <stdlib.h>
#include <time.h>

    #define size_of_array 10
extern void countArrayB(int length);
    int A[size_of_array];
    double B[size_of_array];
int main(int argc, char *argv[]) {
    int length;
    int i;
    clock_t begin;
    clock_t end;
    double time_spent;
    FILE *input, *output;
    //if there is not second argument or second argument equels 0 we will have entering from console
    if (argc < 2 || atoi(argv[1]) == 0) {
        do {
            printf("Input length of array A (0 < length <= %d): \n ", size_of_array);
            scanf("%d", &length);
            if (length < 1 || length > size_of_array) {
                printf("Incorrect length = %d\n", length);
            }
        } while (length < 1 || length > size_of_array);
        for (i = 0; i < length; ++i) {
            printf("enter %d : \n", i);
            scanf("%d", A + i);
        }
        //if second argument equels 1 we will have entering from file.
    } else if (atoi(argv[1]) == 1) {
        input = fopen("input.txt", "r");
        fscanf(input, "%d", &length);
        if (length < 1 || length > size_of_array) {
            printf("Incorrect length = %d\n", length);
            return 1;
        }
        for (i = 0; i < length; ++i) {
            fscanf(input, "%d", A + i);
        }
        //if second argument equels 2 we will have random generation, and we can put third argument for seed.
    } else if (atoi(argv[1]) == 2) {
        srand(time(NULL));
        length = rand();
        length = length%10 + 1;
        for (i = 0; i < length; ++i) {
            A[i] = rand();
        }
    }
    // call function that fill array B
    begin = clock();
    for (i=0;i<200000000;++i){
        countArrayB(length);
    }
    end = clock();
    time_spent = (double)(end-begin)/ CLOCKS_PER_SEC;
    // if we put data from file we will have output to file
    if (argc > 1 && atoi(argv[1]) == 1) {
        output = fopen("output.txt", "w");
        fprintf(output, "time spent: %f sec\n", time_spent);
        for (i = 0; i < length; ++i) {
            fprintf(output, "%f \n", B[i]);
        }
        return 0;
    }
    // if we have random input of input from console we will have output to console
    printf("time spent: %f sec\n", time_spent);
    for (i = 0; i < length; ++i) {
        printf("%f \n", B[i]);
    }
    return 0;
}
