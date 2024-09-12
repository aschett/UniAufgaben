#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int numOfSolutions = 0;


int is_attack(int queens[], int column)
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

void solve(int n)
{
    int queens[n];
    int column = 1;

    queens[column] = 0;

    while (column != 0)
    {

        queens[column] = queens[column] + 1;
        while ((queens[column] <= n) && (!is_attack(queens, column)))
        {

            queens[column] = queens[column] + 1;
        }
        if (queens[column] <= n)
        {
            if (column == n)
            {
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
    solve(N);
    float end = omp_get_wtime();
    
    printf("Num of Solutions for %d x %d matrix with %d queens is : %d \n", N, N, N, numOfSolutions);
    printf("Work took %f seconds\n", end - start);
    return 0;
}