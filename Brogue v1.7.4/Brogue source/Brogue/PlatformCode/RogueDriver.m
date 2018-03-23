//
//  RogueDriver.m
//  Brogue
//
//  Created by Brian and Kevin Walker on 12/26/08.
//  Copyright 2012. All rights reserved.
//
//  This file is part of Brogue.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Affero General Public License as
//  published by the Free Software Foundation, either version 3 of the
//  License, or (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Affero General Public License for more details.
//
//  You should have received a copy of the GNU Affero General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#include <limits.h>
#include <unistd.h>
#include "CoreFoundation/CoreFoundation.h"
#import "RogueDriver.h"
#import <QuartzCore/QuartzCore.h>

#define BROGUE_VERSION	4	// A special version number that's incremented only when
// something about the OS X high scores file structure changes.

static Viewport *theMainDisplay;
NSDate *pauseStartDate;
short mouseX, mouseY;
static CGColorSpaceRef _colorSpace;

@implementation RogueDriver

- (void)awakeFromNib
{
	//extern Viewport *theMainDisplay;
	NSSize theSize;
	short versionNumber;
    
	versionNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"Brogue version"];
	if (versionNumber == 0 || versionNumber < BROGUE_VERSION) {
		// This is so we know when to purge the relevant preferences and save them anew.
		[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NSWindow Frame Brogue main window"];
        
		if (versionNumber != 0) {
			[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Brogue version"];
		}
		[[NSUserDefaults standardUserDefaults] setInteger:BROGUE_VERSION forKey:@"Brogue version"];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
    
	theMainDisplay = theDisplay;
	[theWindow setFrameAutosaveName:@"Brogue main window"];
	[theWindow useOptimizedDrawing:YES];
	[theWindow setAcceptsMouseMovedEvents:YES];
    
    // Comment out this line if you're trying to compile on a system earlier than OS X 10.7:
    [theWindow setCollectionBehavior:NSWindowCollectionBehaviorFullScreenPrimary];
    
	theSize.height = 7 * VERT_PX * kROWS / FONT_SIZE;
	theSize.width = 7 * HORIZ_PX * kCOLS / FONT_SIZE;
	[theWindow setContentMinSize:theSize];
    
	mouseX = mouseY = 0;
}

/*
#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXTHREAD 4

extern void *cogo(jmp_buf here, void (*fun)(void*), void *arg)  ;

static jmp_buf thread[MAXTHREAD];
int corount_count = 0;
//*/

- (void)playBrogue:(id)__unused sender
{
    _colorSpace = CGColorSpaceCreateDeviceRGB();
    //UNUSED(sender);
    //	[fileMenu setAutoenablesItems:NO];
    
    // qibinyi
    
    //*
    rogueMain();
    /*/
    cogo(thread[0], rogueMain, &corount_count);
    //*/
    //	[fileMenu setAutoenablesItems:YES];
	//exit(0);
}

- (void)applicationDidFinishLaunching:(NSNotification *)__unused aNotification
{
    //UNUSED(aNotification);
	[theWindow makeMainWindow];
	[theWindow makeKeyWindow];
	[self windowDidResize:nil];
	//NSLog(@"\nAspect ratio is %@", [theWindow aspectRatio]);
	[self playBrogue:nil];
	[NSApp terminate:nil];
}

- (void)windowDidResize:(NSNotification *)__unused aNotification
{
    //UNUSED(aNotification);
    NSRect theRect;
    NSSize testSizeBox;
    NSMutableDictionary *theAttributes = [[NSMutableDictionary alloc] init];
    short theWidth, theHeight, theSize;
    
    theRect = [theWindow contentRectForFrameRect:[theWindow frame]];
    theWidth = theRect.size.width;
    theHeight = theRect.size.height;
    theSize = min(FONT_SIZE * theWidth / (HORIZ_PX * kCOLS), FONT_SIZE * theHeight / (VERT_PX * kROWS));
    //NSLog(@"Start theSize=%d (w=%d, h=%d)", theSize, theWidth, theHeight);
    do {
        [theAttributes setObject:[NSFont fontWithName:[theMainDisplay basicFontName] size:theSize] forKey:NSFontAttributeName];
        testSizeBox = [@"a" sizeWithAttributes:theAttributes];
        //NSLog(@"theSize=%d testSizeBox w=%f, h=%f", theSize, testSizeBox.width, testSizeBox.height);
        theSize++;
    } while (testSizeBox.width < theWidth / kCOLS && testSizeBox.height < theHeight / kROWS);
    // Now theSize is one more than what was passed in to fontWithName:size:.  Also need to subtract 1 to get to the
    // last box that fit.
    //    [theMainDisplay setHorizPixels:(theWidth / kCOLS) vertPixels:(theHeight / kROWS) fontSize:max(theSize - 2, 9)];
    [theMainDisplay setHorizWindow:theWidth vertWindow:theHeight fontSize:max(theSize - 2, 9)];
    //NSLog(@"End theSize=%d (w=%d, h=%d)  (tW/kC=%f, tH/kR=%f)", theSize, theWidth, theHeight, (theWidth / (float)kCOLS), (theHeight / (float)kROWS));
    [theAttributes release];
}

//- (NSRect)windowWillUseStandardFrame:(NSWindow *)window
//					  defaultFrame:(NSRect)defaultFrame
//{
//	NSRect theRect;
//	if (defaultFrame.size.width > HORIZ_PX * kCOLS) {
//		theRect.size.width = HORIZ_PX * kCOLS;
//		theRect.size.height = VERT_PX * kROWS;
//	} else {
//		theRect.size.width = (HORIZ_PX - 1) * kCOLS;
//		theRect.size.height = (VERT_PX - 2) * kROWS;
//	}
//
//	theRect.origin = [window contentRectForFrameRect:[window frame]].origin;
//	theRect.origin.y += ([window contentRectForFrameRect:[window frame]].size.height - theRect.size.height);
//
//	if (th

@end

//  plotChar: plots inputChar at (xLoc, yLoc) with specified background and foreground colors.
//  Color components are given in ints from 0 to 100.

void plotChar(uchar inputChar,
			  short xLoc, short yLoc,
			  short foreRed, short foreGreen, short foreBlue,
			  short backRed, short backGreen, short backBlue
#ifdef USE_GLYPH
              , int monsterID
#endif
              ) {
    //	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //if(xLoc == 68 && yLoc == 12)
    //    printf( "%d-%d-%d, %d-%d-%d\n" , foreRed, foreGreen, foreBlue, backRed, backGreen, backBlue );
    
    CGFloat backComponents[] = {(CGFloat)(backRed/100.), (CGFloat)(backGreen/100.), (CGFloat)(backBlue/100.), 1.};
    CGColorRef backColor = CGColorCreate(_colorSpace, backComponents);
    
    CGFloat foreComponents[] = {(CGFloat)(foreRed/100.), (CGFloat)(foreGreen/100.), (CGFloat)(foreBlue/100.), 1.};
    CGColorRef foreColor = CGColorCreate(_colorSpace, foreComponents);
    
    NSString *unicodeString = nil;
    if (inputChar > 127 && inputChar != 183) {
        unicodeString = [NSString stringWithCharacters:&inputChar length:1];
    }

#ifdef USE_GLYPH
    if( monsterID >= 0 && monsterID < NUMBER_MONSTER_KINDS ) {
        inputChar = inputChar +1 ;
    }
#endif
                  
    [theMainDisplay setString:unicodeString
               withBackground:backColor
              withLetterColor:foreColor
                  atLocationX:xLoc locationY:yLoc
                withFancyFont:(inputChar == FOLIAGE_CHAR) withChar:inputChar];
	//[pool drain];
}

//*
// qibinyi
#include <sys/time.h>

// double , in secs .  timeIntervalSince1970
// eg. 1480320197.206797
double current_DateNow() {
    struct timeval te;
    gettimeofday(&te, NULL); // get current time
    double milliseconds = (te.tv_sec*1000LL + te.tv_usec/1000.0) / 1000.0; // caculate milliseconds
    //printf("milliseconds: %f , %f \n", milliseconds , [[NSDate date] timeIntervalSince1970] );
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
    _pauseStartDate = current_DateNow();
    //printf("\nPause timer started!");
}

// Returns true if the player interrupted the wait with a keystroke; otherwise false.
boolean pauseForMilliseconds(short milliseconds) {
    
    //int *p = arg, i = *p;
    //        printf("coroutine %d at %p arg %p\n", i, (void*)&i, arg);
    //        int n = arc4random() % count;
    //        printf("jumping to %d\n", n);
    //        arg = coto(thread[i], thread[n], (char*)arg + 1);
    // qibinyi
    //coto(thread[1], thread[0], (char*)arg + 1);
    
    NSEvent *theEvent;
    NSDate *targetDate;//, *currentDate;
    //    NSComparisonResult theCompare;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //currentDate = [NSDate date];
    if ( _pauseStartDate > -1 ) {
        //            NSLog(@"\nStarting a pause: previous date was %@.", pauseStartDate);
        
        targetDate = [NSDate dateWithTimeInterval:((double) milliseconds) / 1000 sinceDate: [NSDate dateWithTimeIntervalSince1970: ((double) _pauseStartDate) ]];
        _pauseStartDate = -1;
    } else {
        targetDate = [NSDate dateWithTimeIntervalSinceNow: ((double) milliseconds) / 1000];
    }
    //        theCompare = [targetDate compare:currentDate];
    
    //        if (theCompare != NSOrderedAscending) {
    do {
        theEvent = [NSApp nextEventMatchingMask:NSAnyEventMask untilDate:targetDate
                                         inMode:NSDefaultRunLoopMode dequeue:YES];
        
        if (([theEvent type] == NSKeyDown && !([theEvent modifierFlags] & NSCommandKeyMask))
            || [theEvent type] == NSLeftMouseUp
            || [theEvent type] == NSLeftMouseDown
            || [theEvent type] == NSRightMouseUp
            || [theEvent type] == NSRightMouseDown

#if !NO_MOUSE_MOVE
            || [theEvent type] == NSMouseMoved
            || [theEvent type] == NSLeftMouseDragged
            || [theEvent type] == NSRightMouseDragged
#endif
            ) {
            [NSApp postEvent:theEvent atStart:TRUE]; // put the event back on the queue
            return true;
        } else if (theEvent != nil) {
            [NSApp sendEvent:theEvent];
        }
    } while (theEvent != nil);
    //        } else {
    //            [NSApp updateWindows];
    //            NSLog(@"\nSkipped a pause: target date was %@; current date was %@; comparison was %i.", targetDate, currentDate, theCompare);
    //        }
    
    [pool drain];
    return false;
}
/*/
void pausingTimerStartsNow() {
    [pauseStartDate release];
	pauseStartDate = [NSDate date];
	[pauseStartDate retain];
	//printf("\nPause timer started!");
}

// Returns true if the player interrupted the wait with a keystroke; otherwise false.
boolean pauseForMilliseconds(short milliseconds) {
	NSEvent *theEvent;
	NSDate *targetDate;//, *currentDate;
    //    NSComparisonResult theCompare;
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //currentDate = [NSDate date];
    if (pauseStartDate) {
        //            NSLog(@"\nStarting a pause: previous date was %@.", pauseStartDate);
        targetDate = [NSDate dateWithTimeInterval:((double) milliseconds) / 1000 sinceDate:pauseStartDate];
        [pauseStartDate release];
        pauseStartDate = NULL;
    } else {
        targetDate = [NSDate dateWithTimeIntervalSinceNow: ((double) milliseconds) / 1000];
    }
    //        theCompare = [targetDate compare:currentDate];
    
    //        if (theCompare != NSOrderedAscending) {
    do {
        theEvent = [NSApp nextEventMatchingMask:NSAnyEventMask untilDate:targetDate
                                         inMode:NSDefaultRunLoopMode dequeue:YES];
        
        if (([theEvent type] == NSKeyDown && !([theEvent modifierFlags] & NSCommandKeyMask))
            || [theEvent type] == NSLeftMouseUp
            || [theEvent type] == NSLeftMouseDown
            || [theEvent type] == NSRightMouseUp
            || [theEvent type] == NSRightMouseDown
            || [theEvent type] == NSMouseMoved
            || [theEvent type] == NSLeftMouseDragged
            || [theEvent type] == NSRightMouseDragged) {
            [NSApp postEvent:theEvent atStart:TRUE]; // put the event back on the queue
            return true;
        } else if (theEvent != nil) {
            [NSApp sendEvent:theEvent];
        }
    } while (theEvent != nil);
    //        } else {
    //            [NSApp updateWindows];
    //            NSLog(@"\nSkipped a pause: target date was %@; current date was %@; comparison was %i.", targetDate, currentDate, theCompare);
    //        }
    
	[pool drain];
	return false;
}
//*/
void nextKeyOrMouseEvent(rogueEvent *returnEvent, __unused boolean textInput, boolean colorsDance) {
	//UNUSED(textInput);
    NSEvent *theEvent;
	NSEventType theEventType;
	NSPoint event_location;
	NSPoint local_point;
	short x, y;
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    for(;;) {
        if (colorsDance) {
            shuffleTerrainColors(3, true);
            commitDraws();
        }
        
        theEvent = [NSApp nextEventMatchingMask:NSAnyEventMask
                                      untilDate:[NSDate dateWithTimeIntervalSinceNow: ((NSTimeInterval) ((double) 50) / ((double) 1000))]
                                         inMode:NSDefaultRunLoopMode
                                        dequeue:YES];
        theEventType = [theEvent type];
        

        if (theEventType == NSKeyDown && !([theEvent modifierFlags] & NSCommandKeyMask)) {
            returnEvent->eventType = KEYSTROKE;
            returnEvent->param1 = [[theEvent charactersIgnoringModifiers] characterAtIndex:0];
            //printf("\nKey pressed: %i", returnEvent->param1);
            returnEvent->param2 = 0;
            returnEvent->controlKey = ([theEvent modifierFlags] & NSControlKeyMask ? 1 : 0);
            returnEvent->shiftKey = ([theEvent modifierFlags] & NSShiftKeyMask ? 1 : 0);
            break;
        }
        else if (theEventType == NSLeftMouseDown
                   || theEventType == NSLeftMouseUp
                   || theEventType == NSRightMouseDown
                   || theEventType == NSRightMouseUp
#if !NO_MOUSE_MOVE

                   || theEventType == NSMouseMoved
                   || theEventType == NSLeftMouseDragged
                   || theEventType == NSRightMouseDragged
#endif
                   ) {
            [NSApp sendEvent:theEvent];
            switch (theEventType) {
                case NSLeftMouseDown:
                    returnEvent->eventType = MOUSE_DOWN;
                    break;
                case NSLeftMouseUp:
                    returnEvent->eventType = MOUSE_UP;
                    break;
                case NSRightMouseDown:
                    returnEvent->eventType = RIGHT_MOUSE_DOWN;
                    break;
                case NSRightMouseUp:
                    returnEvent->eventType = RIGHT_MOUSE_UP;
                    break;
                case NSMouseMoved:
                case NSLeftMouseDragged:
                case NSRightMouseDragged:
                    returnEvent->eventType = MOUSE_ENTERED_CELL;
                    break;
                default:
                    break;
            }
            event_location = [theEvent locationInWindow];
            local_point = [theMainDisplay convertPoint:event_location fromView:nil];
            x = COLS * local_point.x / [theMainDisplay horizWindow];
            y = ROWS - (ROWS * local_point.y / [theMainDisplay vertWindow]);
            // Correct for the fact that truncation occurs in a positive direction when we're below zero:
            if (local_point.x < 0) {
                x--;
            }
            if ([theMainDisplay vertWindow] < local_point.y) {
                y--;
            }
            returnEvent->param1 = x;
            returnEvent->param2 = y;
            returnEvent->controlKey = ([theEvent modifierFlags] & NSControlKeyMask ? 1 : 0);
            returnEvent->shiftKey = ([theEvent modifierFlags] & NSShiftKeyMask ? 1 : 0);
            //			if (theEventType != NSMouseMoved || x != mouseX || y != mouseY) { // Don't send mouse_entered_cell events if the cell hasn't changed
            mouseX = x;
            mouseY = y;
            break;
            //			}
        }
        if (theEvent != nil) {
            [NSApp sendEvent:theEvent]; // pass along any other events so, e.g., the menus work
        }
    }
    // printf("\nRogueEvent: eventType: %i, param1: %i, param2: %i, controlKey: %s, shiftKey: %s", returnEvent->eventType, returnEvent->param1,
    //			 returnEvent->param2, returnEvent->controlKey ? "true" : "false", returnEvent->shiftKey ? "true" : "false");
    
	[pool drain];
}

boolean controlKeyIsDown() {
	return (([[NSApp currentEvent] modifierFlags] & NSControlKeyMask) ? true : false);
}

boolean shiftKeyIsDown() {
	return (([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask) ? true : false);
}







void initializeLaunchArguments(enum NGCommands *command, char *path, unsigned long *seed) {
    *command = NG_NOTHING;
    //*command = NG_SCUM;
	path[0] = '\0';
	*seed = 0;
}

extern char path_prefix[];

void initializeBrogueSaveLocation() {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err;
    
    // Look up the full path to the user's Application Support folder (usually ~/Library/Application Support/).
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
    
    // Use a folder under Application Support named after the application.
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleName"];
    NSString *supportPath = [basePath stringByAppendingPathComponent: appName];
    
    // Create our folder the first time it is needed.
    if (![manager fileExistsAtPath: supportPath]) {
        [manager createDirectoryAtPath:supportPath withIntermediateDirectories:YES attributes:nil error:&err];
    }
    
    // Set the working directory to this path, so that savegames and recordings will be stored here.
#ifdef WORKING_FOLDER_SETTED
    [manager changeCurrentDirectoryPath: supportPath];
    //chdir( [supportPath UTF8String] );
#else
    strcpy( path_prefix, [supportPath UTF8String] ) ;
#endif
}

