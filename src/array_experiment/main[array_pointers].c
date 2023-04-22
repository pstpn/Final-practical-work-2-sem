// Найти и вывести на экран количество уникальных чисел в массиве


#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#ifndef MAX_SIZE
#error MAX_SIZE not defined
#endif

#define PASS_CODE 0
#define ERROR_INPUT 1
#define ERROR_COUNT 2
#define N 10


int arr[MAX_SIZE];

void init(int arr[MAX_SIZE], size_t size)
{
    srand(time(NULL));
    for (size_t i = 0; i < size; ++i)
    {
        arr[i] = rand();
    }
}


size_t unic_dig(const int *p_beg, const int *p_end)
{
    size_t count = 1, flag = 1, len = p_end - p_beg;
    const int *cur;

    for (size_t i = 1; i < len; i++)
    {
        cur = ++p_beg;
        for (long long j = i - 1; j > 0; j--)
        {
            if (*(--cur) == *p_beg)
            {
                flag = 0;
                break;
            }
        }
        if (flag)
        {
            count++;
        }

        flag = 1;
    }

    return count;
}


unsigned long long milliseconds_now(void)
{
    struct timeval val;
    if (gettimeofday(&val, NULL))
        return (unsigned long long) - 1;
    return val.tv_sec * 1000ULL + val.tv_usec / 1000ULL;
}


int main(void)
{
    init(arr, MAX_SIZE);
    int *p_end = arr + MAX_SIZE;

    size_t count;
    long long unsigned beg, end;
    beg = milliseconds_now();
    count = unic_dig(arr, p_end);
    end = milliseconds_now();
    arr[0] = count;

    printf("%llu\n", end - beg);

    arr[0] = 12345;
    arr[1] = arr[0];

    return 0;
}
