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

@end

@implementation WeekViewController

- (void)viewWillAppear:(BOOL)animated {
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
