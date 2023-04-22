// Сортировка матрицы с кешированием

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#ifndef MAX_SIZE
#error MAX_SIZE not defined
#endif

#define PASS_CODE 0
#define DIVIDER 13142


void init(double matrix[MAX_SIZE][MAX_SIZE], size_t n)
{
    srand(time(NULL));
    for (size_t i = 0; i < n; ++i)
    {
        for (size_t j = 0; j < n; j++)
        {
            matrix[i][j] = (double) (rand() % DIVIDER);
        }
    }
}


void sort_matrix(double (*matrix)[MAX_SIZE], const size_t n)
{
    double summs[MAX_SIZE] = {0.0};
    double trash;
    double summ;
    
    for (size_t i = 0; i < n; i++)
    {
        summ = 0.0;
        for (size_t j = 0; j < n; j++)
            summ += matrix[i][j];

        summs[i] = summ;
    }

    size_t cur_index;

    for (size_t i = 0; i < n - 1; i++)
    {
        cur_index = i;

        for (size_t j = i + 1; j < n; j++)
        {
            if (summs[j] < summs[cur_index])
                cur_index = j;
        }

        trash = summs[i];
        summs[i] = summs[cur_index];
        summs[cur_index] = trash;

        for (size_t j = 0; j < n; j++)
        {
            trash = matrix[cur_index][j];
            matrix[cur_index][j] = matrix[i][j];
            matrix[i][j] = trash;
        }
    }
}


unsigned long long milliseconds_now(void)
{
    struct timeval val;
    if (gettimeofday(&val, NULL))
        return (unsigned long long) - 1;
    return val.tv_sec * 1000ULL + val.tv_usec / 1000ULL;
}


double matrix[MAX_SIZE][MAX_SIZE] = {0};

int main(void)
{
    init(matrix, MAX_SIZE);

    long long unsigned beg, end;
    beg = milliseconds_now();
    sort_matrix(matrix, MAX_SIZE);
    end = milliseconds_now();
    
    matrix[0][0] = matrix[0][1];
    matrix[0][1] = matrix[1][1];

    printf("%llu\n", end - beg);
    
    return PASS_CODE;
}
