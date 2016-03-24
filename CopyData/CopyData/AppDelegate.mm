//
//  AppDelegate.m
//  CopyData
//
//  Created by zdy on 15/9/21.
//  Copyright (c) 2015年 xinyunlian. All rights reserved.
//

#import "AppDelegate.h"
#import "DBManager.h"
#import "ReadData.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [self readDataToSQLite];
    readDataToSQLite();
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
