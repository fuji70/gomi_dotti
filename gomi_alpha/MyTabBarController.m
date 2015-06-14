//
//  MyTabBarController.m
//  gomi_alpha
//
//  Created by Naoki on 2015/01/05.
//  Copyright (c) 2015年 vidacomoda. All rights reserved.
//

#import "MyTabBarController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // test
    //UITabBarItem *item = self.tabBar.items[2];
    //item.badgeValue = @"不燃";
    //self.selectedIndex = 1;
    self.customizableViewControllers=nil;//TabBarの編集ボタン表示を消す
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)handleSwipeLeft
{
    NSInteger idx = [self selectedIndex];
    NSInteger oidx = idx;
    if (0<=idx && idx <=3) {
        idx = (idx +1) % 4; // [0,3]
    }
    self.selectedIndex = idx;
    NSLog(@"swipe %@ idx %ld -> %ld", @"L", (long)oidx, (long)idx);
}

- (void)handleSwipeRight
{
    NSInteger idx = self.selectedIndex;
    NSInteger oidx = idx;
    if (0<=idx && idx <=3) {
        idx = (idx -1 + 4) % 4; // [0,3]
    }
    self.selectedIndex = idx;
    NSLog(@"swipe %@ idx %ld -> %ld", @"R", (long)oidx, (long)idx);
}

@end
