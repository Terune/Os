#include <stdio.h>
#include <stdlib.h>     // exit()
#include <string.h>     // strlen()
#include <fcntl.h>      // open()

#include <unistd.h>     // sync()
// #include <sys/time.h>
#include <time.h>
#include <math.h>

int main(int argc, char* argv[])
{
    int  fd, hell;
    struct timespec starts, ends, temps;
    long elapsed;
    int i, j;
    char str[1024] = "";

    if (argc == 1){
        fputs("Error:1+input", stderr);
        exit(1);
    }

    fd = open("tmp.txt", O_WRONLY|O_CREAT, 0644);

    for(i = 1; i <= 100; i++){
        
        for(j = 0; j < i; j++){
            strcat(str, argv[1]);
            printf("%s\n", str);
        }

        clock_gettime(CLOCK_MONOTONIC, &starts);
        // hell = fsync(fd);
        write( fd, str, strlen(str));
        clock_gettime(CLOCK_MONOTONIC, &ends);

        if ((ends.tv_nsec - starts.tv_nsec)<0){
          temps.tv_sec = ends.tv_sec - starts.tv_sec - 1;
          temps.tv_nsec = 1000000000 + ends.tv_nsec - starts.tv_nsec;
        }
        else{
          temps.tv_sec = ends.tv_sec - starts.tv_sec;
          temps.tv_nsec = ends.tv_nsec - starts.tv_nsec;
        }
        // http://stackoverflow.com/questions/17705786/getting-negative-values-using-clock-gettime
        elapsed = 1000000000*temps.tv_sec + temps.tv_nsec;
        printf("%ld\n", elapsed);
        
        // str = "";
    }

    

    if (-1 == hell)
        printf( "fsync() 실패");

    close(fd);
}
