#include <stdio.h>
#include <string.h>  // strlen()
#include <fcntl.h>   // open()

#include <unistd.h>  // sync()
// #include <sys/time.h>
#include <time.h>
#include <math.h>

int main()
{
   int  fd, hell;
   char *str = "forum.falinux.comn";
   char buf[100];
   // struct timeval start, end;
   struct timespec starts, ends, temps;    // spec
   int i;
   long sum = 0, dsum = 0;
   long elapsed;

//   for(i = 0; i < 20; i++){
      fd = open( "test.txt", O_WRONLY|O_CREAT, 0644);
      write( fd, str, strlen( str));

      // gettimeofday(&start, NULL);
      clock_gettime(CLOCK_MONOTONIC, &starts);
      // hell = fsync(fd);
      read(fd, buf, 10);
      // gettimeofday(&end, NULL);
      clock_gettime(CLOCK_MONOTONIC, &ends);

      // elapsed = (end.tv_sec-start.tv_sec)*1000000 + end.tv_usec-start.tv_usec;

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
  //    sum += elapsed;
      // dsum += pow(elapsed,2);
      printf("elapsed time: %ld\n", elapsed);

      /*
      if(elapsed > 70000){
	 printf("  %ld", elapsed);
         return 1;
      }
      */

      if ( -1 == hell)            // 버퍼의 내용을 모두 쓰기를 합니다.
         printf( "fsync() 실패");

      close( fd);
//   }
  // printf("\taverage: %ld\ndeviation: ", sum/20);
}
