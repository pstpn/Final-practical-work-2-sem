// Сложение квадратных матриц без использования слова restrict

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#ifndef MAX_SIZE
#error MAX_SIZE not defined
#endif

#define PASS_CODE 0
#define DIVIDER 13142


void init(double matrix[][MAX_SIZE], size_t n)
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


void addit_matrix(double f_matrix[][MAX_SIZE], 
double s_matrix[][MAX_SIZE], 
double new_matrix[][MAX_SIZE],
size_t n, int alpha)
{
    for (size_t i = 0; i < n; i++)
    {
        for (size_t j = 0; j < n; j++)
        {
            new_matrix[i][j] = alpha * f_matrix[i][j] + s_matrix[i][j];
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


double first_matrix[MAX_SIZE][MAX_SIZE] = {0}, second_matrix[MAX_SIZE][MAX_SIZE] = {0};
double result_matrix[MAX_SIZE][MAX_SIZE] = {0};

int main(void)
{
    init(first_matrix, MAX_SIZE);
    init(second_matrix, MAX_SIZE);

    int alpha = (int)(rand() / (DIVIDER));

    long long unsigned beg, end;
    beg = milliseconds_now();
    addit_matrix(first_matrix, second_matrix, result_matrix, MAX_SIZE, alpha);
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
