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
    int fd,open_fd,size;
    int status;
    struct timespec starts, ends, temps;
    long elapsed;
    char buffer[128];
    pid_t pid;

    if (argc == 1||argc == 2){
        fputs("Error:1+input", stderr);
        exit(1);
    }
    if(argc==4)
    {
        if(strcmp(argv[3],"write")==0)
        {
            pid=fork();

            if(pid!=0)
            {
                fd=open(argv[1],O_WRONLY|O_CREAT,0644);
                while( waitpid( pid, &status, WNOHANG) == 0)
                {
                    write(fd,"writing",strlen("writing"));
                }
                close(fd);
                return 0;
            }
        }
    }

    if(strcmp(argv[2],"open")==0)
    {
        syscall(322);
        clock_gettime(CLOCK_MONOTONIC, &starts);
        open_fd=open(argv[1],O_WRONLY|O_CREAT,0644);
        clock_gettime(CLOCK_MONOTONIC, &ends);
        syscall(322);
    }
    else
    {
        open_fd=open(argv[1],O_WRONLY|O_CREAT,0644);
        syscall(323);
        clock_gettime(CLOCK_MONOTONIC, &starts);
        size=read(open_fd,buffer,sizeof(buffer));
        clock_gettime(CLOCK_MONOTONIC, &ends);
        syscall(323);
    }
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
        close(open_fd);
}
