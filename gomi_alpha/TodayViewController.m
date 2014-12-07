//
//  TodayViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/11/30.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "TodayViewController.h"
#import "HandleDb.h"

@interface TodayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext1;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext2;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext3;

@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
    [self viewTodayIcons];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self doRefreshCurrent];

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

- (void)refreshCurrent:(NSDate*) date {
    NSDate* curDate = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月dd日(E)";
    NSString *strCurDate = [dateFormatter stringFromDate:curDate];
    
    NSLog(@"Refresh to date= [%@]", strCurDate);
    _lblCurrent.text = strCurDate;
    
}

- (void)doRefreshCurrent {
    NSDate* now = [NSDate date];
    [self refreshCurrent:now];
}

- (void)viewTodayIcons {
    NSDate *now = [NSDate date];
    int oneday = 60*60*24;
    _imgCurrent.image = [HandleDb getIconImageFromDate:now];
    _imgNext1.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeIntervalSinceNow:oneday*1]];
    _imgNext2.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeIntervalSinceNow:oneday*2]];
    _imgNext3.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeIntervalSinceNow:oneday*3]];
}

- (UIImage *)rndIcon {
    NSArray* strIcons = [NSArray arrayWithObjects:
                     @"カン",
                     @"プ・油・特",
                     @"ペット",
                     @"他資源",
                     @"可・ビン",
                     @"本・不・商",
                     nil];
    int iconTypes = (int)[strIcons count];
    
    int rnd = random() % iconTypes;
    NSString* rndStr = [strIcons objectAtIndex:rnd];
    NSLog(@"rndStr: %@", rndStr);
    //UIImage * rndImage = [self getImage:rndStr];
    UIImage * rndImage = [HandleDb getIconImage:rndStr];
    return rndImage;
}

- (IBAction)pushButtonDebug:(id)sender {
    _imgCurrent.image = [self rndIcon];
    _imgNext1.image   = [self rndIcon];
    _imgNext2.image   = [self rndIcon];
    _imgNext3.image   = [self rndIcon];
}

@end
