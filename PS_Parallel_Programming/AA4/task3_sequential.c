#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <omp.h>

int min(int x, int y)
{
    return (x < y) ? x : y;
}

void printArray(int32_t array[], int size)
{
    for (int i = 0; i < size; i++)
    {
        printf("%d ", array[i]);
    }
    printf("\n");
}

void merge(int32_t array[], int32_t tempArray[], int from, int mid, int to, int size)
{
    int k = from;
    int i = from;
    int j = mid + 1;

    while (i <= mid && j <= to)
    {
        if (array[i] < array[j])
        {
            tempArray[k++] = array[i++];
        }
        else
        {
            tempArray[k++] = array[j++];
        }
    }

    while (i < size && i <= mid)
    {
        tempArray[k++] = array[i++];
    }

    for (int i = from; i <= to; i++)
    {
        array[i] = tempArray[i];
    }
}

void mergeSort(int32_t array[], int32_t tempArray[], int low, int high, int size)
{
    if(low >= high){
        return;
    } 

    int mid = low + ((high - low) / 2);
    mergeSort(array, tempArray, low, mid, size);
    mergeSort(array, tempArray, mid+1, high, size);
    merge(array, tempArray, low, mid, high, size);
}

int checkSort(int32_t array[], int size)
{
    for (int i = 0; i < size - 1; i++)
    {
        if (array[i] > array[i + 1])
        {
            printf("The array is not properly sorted\n");
            return EXIT_FAILURE;
        }
    }
    printf("The array is properly sorted");
    return EXIT_SUCCESS;
}

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("Please give a valid input. One number n which should be the size of the array");
        {
            return EXIT_FAILURE;
        }
    }

    int size = atoi(argv[1]);
    int32_t *array = (int *)malloc(size * sizeof(int32_t));
    int32_t *temp = (int *)malloc(size * sizeof(int32_t));
    srand(time(NULL));

    for (int i = 0; i < size; i++)
    {
        temp[i] = array[i] = rand();
    }

    double start;
    double end;
    start = omp_get_wtime();
    mergeSort(array, temp, 0, size - 1, size);
    end = omp_get_wtime();
    printf("Work took %f seconds\n", end - start);
    checkSort(array, size);
    free(array);
    free(temp);
    printf("\n");
    return EXIT_SUCCESS;
}