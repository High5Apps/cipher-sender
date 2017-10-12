//
//  AppDelegate.m
//  cipher-sender
//
//  Created by Julian Tigler on 10/4/17.
//  Copyright © 2017 High5! Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <GAI.h>

@interface AppDelegate ()
@property (strong, nonatomic) MainViewController *viewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithWhite:51.0/255 alpha:1.0]];
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:15], NSForegroundColorAttributeName:[UIColor greenColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSDictionary *buttonTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"CourierNewPS-BoldMT" size:15], NSForegroundColorAttributeName: [UIColor greenColor]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:buttonTextAttributes forState:UIControlStateNormal];
    
    self.viewController = (MainViewController *)self.window.rootViewController;
    
    GAI *gai = [GAI sharedInstance];
    [gai trackerWithTrackingId:@"UA-33509143-1"];

    // Optional: automatically report uncaught exceptions.
    gai.trackUncaughtExceptions = YES;

    // Optional: set Logger to VERBOSE for debug information.
    // Remove before app release.
//    gai.logger.logLevel = kGAILogLevelVerbose;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.viewController saveUserData];
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
