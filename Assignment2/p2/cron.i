%module cron
%{
  #include <stdio.h>
  #include <windows.h>
  void timed_message(int t, char * message);
%}

void timed_message(int t, char * message);
