// C code that takes params from Ruby, then manages threads and timers
// and shit.
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

char * m;

void alarm_handler(int sig)
{
  signal(SIGALRM, SIG_IGN);          /* ignore this signal       */
  printf("Message:%s\n", m);
  signal(SIGALRM, alarm_handler);     /* reinstall the handler    */
}

void timed_message(int t, char * message)
{
  signal(SIGALRM, alarm_handler);
  m = message;
  alarm(t);
}
