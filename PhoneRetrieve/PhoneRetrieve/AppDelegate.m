//
//  AppDelegate.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Byte test = 200;

    [self setUINavigatinoBarProperities];
    
    [self configLogColors];
    
    DDLogInfo(@"------------------------------%d",test);

    DDLogError(@"错误信息"); // 红色

    DDLogWarn(@"警告"); // 橙色

    DDLogInfo(@"提示信息"); // 默认是黑色

    DDLogVerbose(@"详细信息"); // 默认是黑色
    
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

/**
 *  初始化导航条
 */
- (void)setUINavigatinoBarProperities {
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:UIColor.whiteColor];
    //
    [[UINavigationBar appearance] setBackIndicatorImage:[[UIImage imageNamed:@"left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[[UIImage imageNamed:@"left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, 0) forBarMetrics:UIBarMetricsDefault];
    
    //    [[UINavigationBar appearance] setClipsToBounds:YES];
//        [[UINavigationBar appearance] setTranslucent:NO];
    
    //
    //    [[UINavigationBar appearance] setTranslucent:NO];//设置为不透明
    //
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:C33,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];

    
    //    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
}

- (void)configLogColors {
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    [[DDTTYLogger sharedInstance] setForegroundColor:UIColor.whiteColor backgroundColor:UIColor.redColor forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:UIColor.greenColor backgroundColor:nil forFlag:DDLogFlagInfo];
}

@end
