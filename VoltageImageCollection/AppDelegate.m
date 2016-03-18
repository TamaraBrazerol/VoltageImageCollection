//
//  AppDelegate.m
//  VoltageImageCollection
//
//  Created by Tamara Brazerol on 13/01/16.
//  Copyright © 2016 Tamara Brazerol. All rights reserved.
//

#import "AppDelegate.h"
#import "DataHandler.h"
#import "AppListViewController.h"
#import "ImageListViewController.h"

@interface AppDelegate ()
@property UITabBarController *tabBarController;
@end

@implementation AppDelegate


- (NSArray *)initializeTabBarItems
{
    /* Initialize view controllers */
    AppListViewController * viewController1 = [[AppListViewController alloc] init];
    ImageListViewController * viewController2 = [[ImageListViewController alloc] init];
    
    
    /* Initialize navigation controllers */
    UINavigationController * navigationController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    UINavigationController * navigationController2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
  
    return @[navigationController1, navigationController2];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /* Initialize window view */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /* Initialize tab bar controller, add tabs controllers */
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [self initializeTabBarItems];
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
    [[DataHandler sharedInstance]startCloudSync];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
