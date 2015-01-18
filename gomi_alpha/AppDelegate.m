//
//  AppDelegate.m
//  gomi_alpha
//
//  Created by 岩崎正則 on 14/10/25.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "AppDelegate.h"
#import "HandleDb.h"
#import "SettingViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//タブバー設定 http://iritec.jp/web_service/5866/
//    UIImage *image2 = [UIImage imageNamed:@"タブ背景画像.png"];
//    UIImage *image3= [UIImage imageNamed:@"ボタン選択時の背景画像.png"];
//    [[UITabBar appearance] setBackgroundImage:image2];
//    [[UITabBar appearance] setSelectionIndicatorImage:image3];
    
    // Override point for customization after application launch.
    
    // 起動2回目以降
    if ([HandleDb getBlkNum] != 0) {
        
        // ここに2回目以降の処理を書く
        // 今回は特に記述しなくていい
        //[HandleDb setBlkNum:0]; // for debug
        
    } else { // 初回起動時はこっち
         //if (true) { // for debug

        // Storyboard を呼ぶ
        UIStoryboard *MainSB = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
        UITabBarController *tb = [MainSB instantiateViewControllerWithIdentifier: @"TabBarController"];
        UINavigationController *more = tb.moreNavigationController;
        // 設定画面を表示 @""の中は Storyboard IDを記述。
        SettingViewController *vc = [MainSB instantiateViewControllerWithIdentifier: @"SettingViewController"];

        tb.selectedViewController = more;
        [more pushViewController:vc animated:true];
        [self.window setRootViewController:tb];
    }
    
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
