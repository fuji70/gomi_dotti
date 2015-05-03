//
//  MonthViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "MonthViewController.h"
#import "HandleDb.h"
#import "MyTabBarController.h"

@interface MonthViewController ()
{
    NSDate * _curDate;
}

@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UIImageView *imgMonth;

- (IBAction)swipe_left:(id)sender;
- (IBAction)swipe_right:(id)sender;
@end

@implementation MonthViewController

- (void)viewWillAppear:(BOOL)animated {
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
    _curDate = [NSDate date];
    [self drawView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canDisplayBannerAds = YES; // auto add iAd banner
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

- (void)drawView {
    _imgMonth.image = [HandleDb getMonthImage:_curDate];
}

- (IBAction)swipe_left:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeLeft];
}

- (IBAction)swipe_right:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeRight];
}
@end
