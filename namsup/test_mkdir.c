#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <time.h>

int main(int argc, char** argv){
    struct timespec starts, ends, temps;
    long elapsed;

    clock_gettime(CLOCK_MONOTONIC, &starts);
    mkdir(argv[1], 0755);
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
    printf("elapsed time: %ld\n", elapsed);
    return 0;
}
