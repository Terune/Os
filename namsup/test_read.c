#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <time.h>

#define BUFSIZE 1000000000
char buf[BUFSIZE];

int main(int argc, char* argv[]){
    int fd;
    int len;
    //struct timeval start, end;
    struct timespec starts, ends, temps;
    long elapsed;

    memset(buf, 0x00, BUFSIZE);

    //gettimeofday(&start, NULL);
    clock_gettime(CLOCK_MONOTONIC, &starts);
    fd = open("data.txt", O_RDONLY);
    // gettimeofday(&end, NULL);
    clock_gettime(CLOCK_MONOTONIC, &ends);
    //gettimeofday(&end, NULL);
    //elapsed = (end.tv_sec-start.tv_sec)*100000 + end.tv_usec-start.tv_usec;
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

    if(fd == -1)
        puts("open() Error!");

    len = atoi(argv[1]);

    //measure read elapsed time
    //gettimeofday(&start, NULL);
    //read(fd, buf, len);
    //gettimeofday(&end, NULL);
    clock_gettime(CLOCK_MONOTONIC, &starts);
    read(fd, buf, len);
    // gettimeofday(&end, NULL);
    clock_gettime(CLOCK_MONOTONIC, &ends);
    //gettimeofday(&end, NULL);
    //elapsed = (end.tv_sec-start.tv_sec)*100000 + end.tv_usec-start.tv_usec;
    if ((ends.tv_nsec - starts.tv_nsec)<0){
        temps.tv_sec = ends.tv_sec - starts.tv_sec - 1;
        temps.tv_nsec = 1000000000 + ends.tv_nsec - starts.tv_nsec;
    }
    else{
        temps.tv_sec = ends.tv_sec - starts.tv_sec;
        temps.tv_nsec = ends.tv_nsec - starts.tv_nsec;
    }
    elapsed = 1000000000*temps.tv_sec + temps.tv_nsec;
    
    //elapsed = (end.tv_sec-start.tv_sec)*100000 + end.tv_usec-start.tv_usec;
    printf("elapsed time: %ld\n", elapsed);
    close(fd);

    return 0;
}
