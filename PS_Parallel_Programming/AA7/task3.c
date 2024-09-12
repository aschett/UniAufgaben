#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include "xmmintrin.h"

#define SIZE 2048
#define REPETITIONS 1000000
void fill_array(float *array)
{

    srand(245);

    for (int i = 0; i < SIZE; ++i)
    {
        array[i] = (float)rand() / RAND_MAX;
    }
}

void print_array(float *array)
{
    for (int i = 0; i < SIZE; ++i)
    {
        printf("%f ", array[i]);
    }

    printf("\n");
}

int main(void)
{
    float *a = malloc(sizeof(float) * SIZE);
    float *b = malloc(sizeof(float) * SIZE);
    float *c = malloc(sizeof(float) * SIZE);

    fill_array(b);
    fill_array(c);
    fill_array(a);

    __m128 t0, t1, t2, t3;

    double start = omp_get_wtime();

    for (int run = 0; run < REPETITIONS; ++run)
    {
        t0 = _mm_load_ps(c);
        t1 = _mm_load_ps(b);
        t2 = _mm_load_ps(a);
        t3 = _mm_mul_ps(t0, t1);
        t2 = _mm_add_ps(t2, t3);
        _mm_store_ps(a, t2);
    }

    print_array(a);
    double end = omp_get_wtime();
    printf("Time : %lf\n", end - start);
    
    return EXIT_SUCCESS;
}
