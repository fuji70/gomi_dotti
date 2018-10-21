//
//  SearchViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "SearchViewController.h"
#import "HandleDb.h"
#import "MyTabBarController.h"

@interface SearchViewController ()
{
    NSDictionary * _tblBtn;
}

@property (weak, nonatomic) IBOutlet UIButton *btnJumpTypeSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UIImageView *imgPet;
@property (weak, nonatomic) IBOutlet UIImageView *imgDiscard;
@property (weak, nonatomic) IBOutlet UIImageView *imgKanen;
@property (weak, nonatomic) IBOutlet UIImageView *imgCan;
@property (weak, nonatomic) IBOutlet UIImageView *imgGlass;
@property (weak, nonatomic) IBOutlet UIImageView *imgFunen;
@property (weak, nonatomic) IBOutlet UIImageView *imgPaperCloth;
@property (weak, nonatomic) IBOutlet UILabel *lblNextDate;
@property (weak, nonatomic) IBOutlet UILabel *lblPit;
@property (weak, nonatomic) IBOutlet UIImageView *imgWordType;
@property (weak, nonatomic) IBOutlet UIButton *btnJumpPhoneCall;

- (IBAction)swipe_left:(id)sender;
- (IBAction)swipe_right:(id)sender;

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTblBtn];
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

- (void)initTblBtn {
    _tblBtn = [NSDictionary dictionaryWithObjectsAndKeys:
               // iconStr,  keyBtnTag 2016
               @"ペット", @1,
               @"粗大", @2,
               @"燃やせる", @3,
               @"かん", @4,
               @"ビン・スプレー", @5,
               @"燃やせない", @6,
               @"紙・布", @7,
               nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    NSNumber *keyBtn = [NSNumber numberWithInt:(int)touch.view.tag];
    NSString *iconsStr = _tblBtn[keyBtn];
    if (!iconsStr) return;
    
    NSLog( @"touch: %@ -> %@", keyBtn, iconsStr );
    NSDate *now = [NSDate date];
    
    NSDate * nextDate = [HandleDb getNextDate:iconsStr startDate:now];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    dateFormatter.dateFormat = @"MM月dd日(E)";
    NSString *strNextDate = [dateFormatter stringFromDate:nextDate];
    _lblNextDate.text = strNextDate;
    _imgWordType.image = [HandleDb getWordIconImage:iconsStr];
    _lblPit.text = [HandleDb getPitStr:iconsStr];
    
}

- (IBAction)mainViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)tapTEL {
    
//    NSURL *url = [[NSURL alloc] initWithString:@"tel:0466-23-5301"];
//    [[UIApplication sharedApplication] openURL:url];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:029-860-2984"]];
    
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
