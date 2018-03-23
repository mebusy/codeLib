//
//  AppDelegate.m
//  iosLuaTest
//
//  Created by qibinyi on 2/7/18.
//  Copyright © 2018 qibinyi. All rights reserved.
//

#import "AppDelegate.h"
#include "LuaState.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void) timerFunc {
    //NSLog(@"aaa") ;
    LuaState::getInstance().executeString( "require 'asyncCurl' ; asyncCurl.step()" );
}

-(void) startSomething {
    LuaState::getInstance().executeString( "require 'asyncCurl' ; asyncCurl.test_task()" );
    LuaState::getInstance().executeString( "require 'asyncCurl' ; asyncCurl.test_task2()" );
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //printf( "res path %s\n" , [[[NSBundle mainBundle] resourcePath] UTF8String]  );
    //printf( "bundle path %s\n" , [[[NSBundle mainBundle] bundlePath] UTF8String]  );
    LuaState::getInstance().executeString( "print ( 'executeString lua' )" )  ;
    

    
    LuaState::getInstance().executeString( "require 'entry' " )  ;
    // should do nothing when 2nd called
    LuaState::getInstance().executeString( "require 'entry' " )  ;
    int ret  = LuaState::getInstance().executeString( "return globalFuncTest()" );
    NSLog( @" executeGlobalFunction ret: %d \n" , ret  ) ;
    ret = LuaState::getInstance().executeString( "return globalTestValue" )  ;
    NSLog( @" get globalTestValue ret: %d \n" , ret  ) ;
    
    //LuaState::getInstance().executeString( "require 'testModule' " )  ;
    ret = LuaState::getInstance().executeString( "require 'testModule' ; return testModule.moduleTestValue" )  ;
    NSLog( @" get module TestValue ret: %d \n" , ret  ) ;
    
    ret  = LuaState::getInstance().executeString( "require 'testModule' ; return testModule.moduleFuncTest()" );
    NSLog( @" execute module lFunction ret: %d \n" , ret  ) ;
    
    [NSTimer scheduledTimerWithTimeInterval: 1.0/60
                                                      target:self selector:@selector(timerFunc)
                                                    userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval: 1
                                                      target:self selector:@selector(startSomething)
                                                    userInfo:nil repeats:NO];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
