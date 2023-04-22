// Умножение квадратных матриц с транспонированием только первой матрицы


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


void transpose(double matrix[MAX_SIZE][MAX_SIZE], size_t n)
{
    double trash;

    for (size_t i = 0; i < n - 1; i++)
    {
        for (size_t j = i + 1; j < n; j++)
        {
            trash = matrix[i][j];
            matrix[i][j] = matrix[j][i];
            matrix[j][i] = trash;
        }
    }
}


void multi_matrix(double (*f_matrix)[MAX_SIZE], 
double (*s_matrix)[MAX_SIZE], double (*new_matrix)[MAX_SIZE], size_t n)
{
    transpose(f_matrix, MAX_SIZE);

    double summ;

    for (size_t num = 0; num < n; num++)
    {
        summ = 0.0;
        for (size_t i = 0; i < n; i++)
        {
            for (size_t j = 0; j < n; j++)
            {
                summ += (double)f_matrix[j][i] * s_matrix[j][num];
            }
            new_matrix[i][num] = summ;
        }
    }
    
    transpose(f_matrix, MAX_SIZE);
}


unsigned long long milliseconds_now(void)
{
    struct timeval val;
    if (gettimeofday(&val, NULL))
        return (unsigned long long) - 1;
    return val.tv_sec * 1000ULL + val.tv_usec / 1000ULL;
}


double first_matrix[MAX_SIZE][MAX_SIZE] = {0}, second_matrix[MAX_SIZE][MAX_SIZE] = {0};
double result_matrix[MAX_SIZE][MAX_SIZE] = {0};

int main(void)
{
    init(first_matrix, MAX_SIZE);
    init(second_matrix, MAX_SIZE);

    long long unsigned beg, end;
    beg = milliseconds_now();
    multi_matrix(first_matrix, second_matrix, result_matrix, MAX_SIZE);
    end = milliseconds_now();
    
    first_matrix[0][0] = first_matrix[0][1];
    first_matrix[0][1] = first_matrix[1][1];

    second_matrix[0][0] = second_matrix[0][1];
    second_matrix[0][1] = second_matrix[1][1];

    result_matrix[0][0] = result_matrix[0][1];
    result_matrix[0][1] = result_matrix[1][1];

    printf("%llu\n", end - beg);
    
    return PASS_CODE;
}
