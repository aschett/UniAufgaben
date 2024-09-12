#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int numOfSolutions = 0;

int is_attacked(int queens[], int column)
{
    for (int row = 1; row < column; row++)
    {
        if (queens[row] == queens[column] || row - queens[row] == column - queens[column] || row + queens[row] == column + queens[column])
        {
            return 0;
        }
    }
    return 1;
}

void solve(int n, int queens[])
{
	printf("this is thread %d\n", omp_get_thread_num()); 
        int column = 2;
        queens[column] = 0;

        while (column != 1)
        {

            queens[column] = queens[column] + 1;
            while ((queens[column] <= n) && (!is_attacked(queens, column)))
            {
                queens[column] = queens[column] + 1;
            }
            if (queens[column] <= n)
            {
                if (column == n)
                {
                    #pragma omp atomic
                    numOfSolutions++;
                }
                else
                {
                    column++;
                    queens[column] = 0;
                }
            }
            else
            {
                column--;
            }
        }
    return;
}

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Please enter a valid input for the number of queens.\n");
        return EXIT_FAILURE;
    }
    int N = atoi(argv[1]);
    float start = omp_get_wtime();
    int queens[N+1];
#pragma omp parallel for private(queens)
    for (int i = 1; i <= N; i++)
    {
        queens[1] = i; 
        solve(N, queens);
    }
    float end = omp_get_wtime();

    printf("Num of Solutions for %d x %d matrix with %d queens is : %d \n", N, N, N, numOfSolutions);
    printf("Work took %f seconds\n", end - start);
    return 0;
}