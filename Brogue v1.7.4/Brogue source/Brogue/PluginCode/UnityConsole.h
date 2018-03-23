
#include <string.h>
#include <stdio.h>


typedef void (*FuncPtr)( const char * );
extern FuncPtr _DebugFunc;
extern void print_trace (void);

#define DebugLog(  fmt, ... )    \
do { \
static char log_buf[1024] ; \
memset( log_buf , 0 , sizeof(log_buf)); \
sprintf(log_buf,  fmt, ##__VA_ARGS__); \
if (_DebugFunc) \
_DebugFunc( log_buf ); \
else \
printf( "%s\n" , log_buf ) ; \
} while (0)
