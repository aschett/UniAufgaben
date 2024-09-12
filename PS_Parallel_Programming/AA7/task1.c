#include<stdio.h>
#include<stdlib.h>
#include<omp.h>

#define SIZE 2048
#define REPETITIONS 1000000

void fill_array(float* array) {
    srand(245);

    for(int i = 0; i < SIZE; ++i) {
        array[i] = (float) rand() / RAND_MAX; 
    }
}

void print_array(float* array) {
    for(int i = 0; i < SIZE; ++i) {
        printf("%f ", array[i]);
    }

    printf("\n");
}


int main(void) {
    float* a = malloc(sizeof(float) * SIZE);
    float* b = malloc(sizeof(float) * SIZE);
    float* c = malloc(sizeof(float) * SIZE);

    fill_array(a);
    fill_array(b);
    fill_array(c);

    double start = omp_get_wtime();

    for(int run = 0; run < REPETITIONS; ++run) {
        for(int i = 0; i < SIZE; ++i) {
            a[i] += b[i] * c[i];
        }
    }

    double end = omp_get_wtime();
    print_array(c);
    printf("Time (Not-Vectorized): %lf\n", end - start);

    return EXIT_SUCCESS;
}
