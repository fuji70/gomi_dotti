//
//  WeekViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "WeekViewController.h"
#import "HandleDb.h"
#import "MyTabBarController.h"

@interface WeekViewController () {
    NSDate * _curDate;
}
@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (strong, nonatomic) IBOutlet UIButton *btnNextWeek;
- (IBAction)pushBtnNextWeek:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSMutableArray *lblWeekdays;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgWeekdays;
- (IBAction)swipe_left:(id)sender;
- (IBAction)swipe_right:(id)sender;
@end

@implementation WeekViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
    _curDate = [NSDate date];
    [self drawWeekdays];
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

+ (int)getDaynum:(NSDate*)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
    return (int)[components weekday]; // 1:Sun 2:Mon .... 7:Sat
}

+ (int)offsetToMonday:(NSDate*)date {
    int daynum = [WeekViewController getDaynum:date];
    int toMon = daynum - 2;
    if (toMon < 0) toMon += 7;
    return toMon;
}

+ (NSDate*)getThisMonday:(NSDate*)date {
    int toMon = [WeekViewController offsetToMonday:date];
    int oneday = 60*60*24;
    return [date initWithTimeInterval:oneday*(-toMon) sinceDate:date];
}

+ (NSString*)date2str:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    dateFormatter.dateFormat = @"MM月dd日(E)";
    return[dateFormatter stringFromDate:date];
}

- (void)drawWeekdays {
    int numLbl = (int)[_lblWeekdays count];
    int oneday = 60*60*24;
    NSDate * date = _curDate;
    int todayIdx = [WeekViewController offsetToMonday:_curDate];
    NSDate * sinceDate = [WeekViewController getThisMonday:_curDate];
    NSTimeInterval dif = [_curDate timeIntervalSinceNow];
    bool isToday = (abs(dif) < 60*60*24);
    for (int i=0; i<numLbl; ++i) {
        date = [date initWithTimeInterval:oneday*i sinceDate:sinceDate];
        ((UILabel*)_lblWeekdays[i]).text = [WeekViewController date2str:date];
        ((UILabel*)_lblWeekdays[i]).highlighted = (i==todayIdx && isToday);
        NSString * strIcons = [HandleDb getIconsStr:date];
        ((UILabel*)_lblWeekdays[i]).backgroundColor = [UIColor colorWithPatternImage:[HandleDb getDateIconImage:strIcons]];
        ((UIImageView*)_imgWeekdays[i]).image = [HandleDb getIconImageFromDate:date];
    }
}

- (IBAction)pushBtnNextWeek:(id)sender {
    _curDate = [_curDate initWithTimeInterval:(7*60*60*24) sinceDate:_curDate];
    [self drawWeekdays];
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
