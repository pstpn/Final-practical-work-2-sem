// Сортировка матрицы без кеширования

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


double get_summ(double *string_m, const size_t n)
{
    double summ = 0;

    for (size_t i = 0; i < n; i++)
        summ += string_m[i];

    return summ;
}


void replace_str(double (*matrix)[MAX_SIZE], const size_t ind_1, 
const size_t ind_2, size_t n)
{
    double trash;

    for (size_t j = 0; j < n; j++)
    {
        trash = matrix[ind_1][j];
        matrix[ind_1][j] = matrix[ind_2][j];
        matrix[ind_2][j] = trash;
    }
}


void sort_matrix(double (*matrix)[MAX_SIZE], const size_t n)
{
    double summ_index, summ_i;
    double trash;

    size_t cur_index;

    for (size_t i = 0; i < n - 1; i++)
    {
        cur_index = i, summ_i = 0.0;

        for (size_t k = 0; k < n; k++)
            summ_i += matrix[i][k];

        for (size_t j = i + 1; j < n; j++)
        {
            summ_index = 0.0;

            for (size_t k = 0; k < n; k++)
                summ_index += matrix[j][k];

            if (summ_i > summ_index)
            {
                summ_i = summ_index;
                cur_index = j;
            }
        }

        for (size_t j = 0; j < n; j++)
        {
            trash = matrix[i][j];
            matrix[i][j] = matrix[cur_index][j];
            matrix[cur_index][j] = trash;
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
