//
//  AppDelegate.m
//  3D Carousel
//
//  Created by Wael Youssef on 8/23/16.
//  Copyright © 2016 Wael. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	[self.window setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
	[self.window makeKeyAndVisible];
	[self.window setBackgroundColor:[UIColor whiteColor]];
	
	self.viewController=[[ViewController alloc] init];
	self.window.rootViewController=self.viewController;
	
	return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

@end
