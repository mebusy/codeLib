//
//  plugin.c
//  Brogue
//
//  Created by qibinyi on 11/28/16.
//
//

#include "Rogue.h"
#include "IncludeGlobals.h"
//#include <math.h>
//#include <time.h>
//#include <limits.h>




/*
int test2() {
    printf("test2") ;
    DebugLog( "ddd" );
    return 782 ;
}
//*/
// =====================================================
 



typedef char* (*FuncPtrSTR_FUNC_V)( );
FuncPtrSTR_FUNC_V _GetSaveLocationFunc = NULL ;

void SetGetSaveLocationFunction ( FuncPtrSTR_FUNC_V fp ) {
    _GetSaveLocationFunc = fp ;
}



void initializeBrogueSaveLocation() {
    //DebugLog("initializeBrogueSaveLocation TODO !") ;
    
    if( _GetSaveLocationFunc ) {
        const char* path = _GetSaveLocationFunc();
        strcpy( path_prefix, path ) ;
    }
}


extern void sleep_ms(int milliseconds) ;

rogueEvent unity_input_returnEvent ;

boolean controlKeyIsDown() {
    return  unity_input_returnEvent.controlKey ;
}



boolean setParamOfEvent( int eventType,
                     int param1,
                     int param2,
                     boolean controlKey,
                     boolean shiftKey  )
{
    if (
        // existing event doest not consumed yet
        unity_input_returnEvent.eventType != EVENT_ERROR
        // new event is event error
        || (enum eventTypes) eventType == EVENT_ERROR
        ) {
        return false ;
    }

    unity_input_returnEvent.eventType = (enum eventTypes)eventType;
    unity_input_returnEvent.param1 = param1 ;
    unity_input_returnEvent.param2 = param2 ;
    unity_input_returnEvent.controlKey = controlKey;
    unity_input_returnEvent.shiftKey = shiftKey;
    
    //DebugLog( "::setParamOfEvent: %d,%d,%ld,%ld" , (int)eventType, (int)unity_input_returnEvent.eventType,  unity_input_returnEvent.param1 , unity_input_returnEvent.param2   );
    
    return true ;
}

typedef boolean (*FuncPtrB_FUNC_V)( );
FuncPtrB_FUNC_V _FetchParamOfEventFunc = NULL ;

void SetFetchParamOfEventFunction(FuncPtrB_FUNC_V fp )
{
    _FetchParamOfEventFunc = fp;
}


void nextKeyOrMouseEvent(rogueEvent *returnEvent, __unused boolean textInput, boolean colorsDance) {
    //
    for(;;) {
        if (colorsDance) {
            shuffleTerrainColors(3, true);
            commitDraws();
        }
        
        if(_FetchParamOfEventFunc != NULL ) {
            
            boolean result = _FetchParamOfEventFunc();
            
        }
        
        // DebugLog("nextKeyOrMouseEvent loop ! - %d" ,  (int)returnEvent->eventType  ) ;
        
        if ( unity_input_returnEvent.eventType == EVENT_ERROR ) {
            sleep_ms( 50 ) ;
            continue ;
        }
        
        
        
        returnEvent->eventType = unity_input_returnEvent.eventType;
        returnEvent->param1 = unity_input_returnEvent.param1;
        returnEvent->param2 = unity_input_returnEvent.param2;
        returnEvent->controlKey = unity_input_returnEvent.controlKey;
        returnEvent->shiftKey = unity_input_returnEvent.shiftKey;
        
        // consumed
        unity_input_returnEvent.eventType = EVENT_ERROR ;
        
        
        break ;
        
        /* qibinyi, maybe __unused
        //			if (theEventType != NSMouseMoved || x != mouseX || y != mouseY) { // Don't send mouse_entered_cell events if the cell hasn't changed
        mouseX = x;
        mouseY = y;
        //*/
        
        
    }
}



typedef boolean (*FuncPtrB_FUNC_S)( short s);
FuncPtrB_FUNC_S _PauseForMillisecondsFunc = NULL ;

void SetPauseForMillisecondsFunction(FuncPtrB_FUNC_S fp )
{
    _PauseForMillisecondsFunc = fp;
}

boolean pauseForMilliseconds(short milliseconds) {
    //DebugLog("pauseForMilliseconds %d ,TODO !" , milliseconds ) ;
    
    if(_PauseForMillisecondsFunc!=NULL) {
        boolean result = _PauseForMillisecondsFunc( milliseconds ) ;
        
        // DebugLog("pauseForMilliseconds result: %d" , (int)result ) ;
    
        return  result ;
    }
    else {
        sleep_ms(  milliseconds) ;
        return false ;
    }
}



// same as original code
void initializeLaunchArguments(enum NGCommands *command, char *path, unsigned long *seed) {
    *command = NG_NOTHING;
    //*command = NG_SCUM;
    path[0] = '\0';
    *seed = 0;
}

#include <sys/time.h>

// double , in secs .  timeIntervalSince1970
// eg. 1480320197.206797
double current_DateNow() {
    struct timeval te;
    gettimeofday(&te, NULL); // get current time
    double milliseconds = (te.tv_sec*1000LL + te.tv_usec/1000.0) / 1000.0; // caculate milliseconds
    //DebugLog("milliseconds: %f , %f \n", milliseconds , [[NSDate date] timeIntervalSince1970] );
    return milliseconds;
}

// milliseconds: in secs.xxxxxx
const char* FormatDateBySecs( int _seconds )
{
    time_t seconds = _seconds;
    struct tm *t = localtime(&seconds);
    
    static char date[20];
    memset( date , 0 , sizeof(date) ) ;
    
    strftime(date, 11, "%d/%m/%y", t );
    return date ;
}

long long _pauseStartDate = -1 ;

void pausingTimerStartsNow() {
    //DebugLog("pausingTimerStartsNow TODO !") ;
    _pauseStartDate = current_DateNow();
    //DebugLog("\nPause timer started!");
}


//====================================================================================

typedef void (*FuncPtrPlotChar)( uchar inputChar,
short xLoc, short yLoc,
short foreRed, short foreGreen, short foreBlue,
short backRed, short backGreen, short backBlue
#ifdef USE_GLYPH
,int monsterID
#endif
);
FuncPtrPlotChar _PlotCharFunc = NULL ;

void SetPlotCharFunction(FuncPtrPlotChar fp )
{
    _PlotCharFunc = fp;
}

//  plotChar: plots inputChar at (xLoc, yLoc) with specified background and foreground colors.
//  Color components are given in ints from 0 to 100.

void plotChar(uchar inputChar,
              short xLoc, short yLoc,
              short foreRed, short foreGreen, short foreBlue,
              short backRed, short backGreen, short backBlue
#ifdef USE_GLYPH
              ,int monsterID
#endif
              ) {
    //	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //DebugLog("plotChar TODO !") ;
    if( _PlotCharFunc) {
        
        //if(xLoc == 68 && yLoc == 12)
        //    DebugLog( "%d-%d-%d, %d-%d-%d\n" , foreRed, foreGreen, foreBlue, backRed, backGreen, backBlue );
        
        _PlotCharFunc(  inputChar,
                      xLoc,  yLoc,
                      foreRed,  foreGreen,  foreBlue,
                      backRed,  backGreen,  backBlue
                      
#ifdef USE_GLYPH
                      ,monsterID
#endif
                      
                      ) ;
    }
}

//====================================================================================




