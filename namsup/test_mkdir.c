#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <sys/syscall.h>
    
static inline void rdtsc(unsigned int* upper, unsigned int* lower){
    asm volatile("rdtsc"
            :"=a"(*lower), "=d"(*upper));
}

int main(){
    struct timespec starts, ends, temps;
    long elapsed;
    int i=0;

    clock_gettime(CLOCK_MONOTONIC, &starts);
    syscall(SYS_mkdir);
    clock_gettime(CLOCK_MONOTONIC, &ends);
    if ((ends.tv_nsec - starts.tv_nsec)<0){
        temps.tv_sec = ends.tv_sec - starts.tv_sec - 1;
        temps.tv_nsec = 1000000000 + ends.tv_nsec - starts.tv_nsec;
    }
    else{
        temps.tv_sec = ends.tv_sec - starts.tv_sec;
        temps.tv_nsec = ends.tv_nsec - starts.tv_nsec;
    }
    elapsed = 1000000000*temps.tv_sec + temps.tv_nsec;
    printf("%ld\n", elapsed);

    return 0;
}

