//
//  AppDelegate.m
//  CarTrawlerSDKIntegrated
//
//  Created by Rafael Ortiz on 17/09/2019.
//  Copyright © 2019 CarTrawler. All rights reserved.
//

#import "AppDelegate.h"
#import "CarTrawlerSDK/CarTrawlerSDK.h"

@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [MSAppCenter start:@"14d8a8f7-549d-45be-a64e-33efb10252fd" withServices:@[
                                                                              [MSAnalytics class],
                                                                              [MSCrashes class]
                                                                              ]];
    
    CTStyle *style = [CTStyle styleWithTheme:CTAppThemeDark primaryColor:[UIColor blueColor]];
    
    [[CarTrawlerSDK sharedInstance] initialiseSDKWithStyle:style
                                          customParameters:nil
                                                production:NO];
    return YES;
}


@end
