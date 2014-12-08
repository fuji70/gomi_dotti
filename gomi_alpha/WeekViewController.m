//
//  WeekViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "WeekViewController.h"
#import "HandleDb.h"

@interface WeekViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UILabel *lblMon;
@property (weak, nonatomic) IBOutlet UILabel *lblTue;
@property (weak, nonatomic) IBOutlet UILabel *lblWed;
@property (weak, nonatomic) IBOutlet UILabel *lblThu;
@property (weak, nonatomic) IBOutlet UILabel *lblFri;
@property (weak, nonatomic) IBOutlet UILabel *lblSat;

@property (weak, nonatomic) IBOutlet UIImageView *imgMon;
@property (weak, nonatomic) IBOutlet UIImageView *imgTue;
@property (weak, nonatomic) IBOutlet UIImageView *imgWed;
@property (weak, nonatomic) IBOutlet UIImageView *imgThu;
@property (weak, nonatomic) IBOutlet UIImageView *imgFri;
@property (weak, nonatomic) IBOutlet UILabel *imgSat;
@end

@implementation WeekViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
