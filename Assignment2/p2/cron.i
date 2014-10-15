%module cron
%{
  #include <stdio.h>
  #include <signal.h>
  #include <unistd.h>
  void timed_message(int t, char * message);
%}

void timed_message(int t, char * message);
