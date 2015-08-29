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
- (IBAction)swipe_up:(id)sender;
- (IBAction)swipe_down:(id)sender;

- (IBAction)reset2today:(id)sender;
@end

@implementation MonthViewController

- (void)viewWillAppear:(BOOL)animated {
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
    [self initDate];
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

- (void)drawMonth {
    _imgMonth.image = [HandleDb getMonthImage:_curDate];
}

- (void)initDate {
    _curDate = [NSDate date];
    [self drawMonth];
}

- (void)changeMonth:(int)months {
    _curDate = [_curDate initWithTimeInterval:(60*60*24*30*months) sinceDate:_curDate];
    [self drawMonth];
}

- (IBAction)swipe_left:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeLeft];
}

- (IBAction)swipe_right:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeRight];
}

- (IBAction)swipe_up:(id)sender {
    [self changeMonth:+1];
}

- (IBAction)swipe_down:(id)sender {
    [self changeMonth:-1];
}

- (IBAction)reset2today:(id)sender {
    [self initDate];
}
@end
