//
//  TodayViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/11/30.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "TodayViewController.h"

@interface TodayViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext1;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext2;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext3;

@end

@implementation TodayViewController

- (int)getBlkNumConfig {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults integerForKey:@"blkNum"];
}

- (void)viewWillAppear:(BOOL)animated {
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [self getBlkNumConfig]];
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

- (UIImage*)getImage:(NSString*)icons {
    
    NSDictionary * dbIcon = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"can.png"        ,@"カン",
                             @"plastic.png"    ,@"プ・油・特",
                             @"petbottole.png" ,@"ペット",
                             @"shigen.png"     ,@"他資源",
                             @"kanen.png"      ,@"可・ビン",
                             @"funen.png"      , @"本・不・商",
                         nil];
    
    NSString * imgName = [dbIcon objectForKey:icons];
    NSLog(@"icons: %@  ->  imgName: %@", icons, imgName);
    return [UIImage imageNamed:imgName];
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
    UIImage * rndImage = [self getImage:rndStr];
    return rndImage;
}

- (IBAction)pushButtonDebug:(id)sender {
    _imgCurrent.image = [self rndIcon];
    _imgNext1.image   = [self rndIcon];
    _imgNext2.image   = [self rndIcon];
    _imgNext3.image   = [self rndIcon];
    //int blkNum = (random() % 8) + 1;
    //_lblBlknum.text = [NSString stringWithFormat:@"%d", blkNum];
}

@end
