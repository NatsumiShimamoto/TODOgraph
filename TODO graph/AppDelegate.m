//
//  AppDelegate.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/01.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "GAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    /* --- Parse --- */
    
    [Parse setApplicationId:@"D2zSnWaRftB00rjUsilBqznEgETBOIU7pHAJTAct"
                  clientKey:@"E6Hh9dXYV2jza2qaHhNrGeaf0U7zqpVgokTKt5Uj"];
    
    // OSのバージョンを取得
    CGFloat currentVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (currentVersion >= 8.0) {
        // iOS 8 以降の処理
        
        // User Notificationの種類（バッヂ、アラート、サウンド）
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        
        // User Notificationの設定を登録
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:settings];
        
        // Remote Notificationの設定を登録
        [application registerForRemoteNotifications];
        
        NSLog(@"Push");
        
        
        
        
    } else {
        
        // iOS 7 以前の処理
        
        // Remote Notificationの種類（バッヂ、アラート、サウンド）
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        // Remote Notificationの設定を登録
        [application registerForRemoteNotificationTypes:types];
        
        NSLog(@"Push");
    }
    
    /* --- Google Analytics --- */
   
    // 例外を自動的にGoogle Analyticsに送る
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // トラッキング間隔　20秒
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-59766853-1"];
    
    // トラッカーのインスタンス作成
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    NSLog(@"tracker == %@", tracker);
    
    return YES;
   
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"CheckVersion" object:nil]];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
