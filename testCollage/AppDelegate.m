//
//  AppDelegate.m
//  testCollage
//
//  Created by Serhii Kostiuk on 02.09.16.
//  Copyright © 2016 Serhii Kostiuk. All rights reserved.
//

#import "AppDelegate.h"
#import "RootCoordinator.h"


@interface AppDelegate ()
@property (nonatomic, strong) RootCoordinator *rootCoordinator;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[UITextAttributeTextColor] = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.6];
    attr[UITextAttributeTextShadowColor] = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    attr[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetMake(0, -1)];
    attr[UITextAttributeFont] = [UIFont systemFontOfSize:18.0];
    [[UINavigationBar appearance] setTitleTextAttributes:attr];
    
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window = window;
    
//    RootCoordinator *coordinator = [RootCoordinator new];
//    self.rootCoordinator = coordinator;
    
//    window.rootViewController = coordinator.rootViewController;
    
//    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
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
