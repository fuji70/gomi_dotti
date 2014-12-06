//
//  SettingViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/06.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

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

- (void)setBlkNum:(int) blkNum {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:blkNum forKey:@"blkNum"];
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"set to blkNum: %d.", blkNum);
    }
    
}

- (IBAction)btnBlk1:(id)sender {
    int blkNum=1;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk2:(id)sender {
    int blkNum=2;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk3:(id)sender {
    int blkNum=3;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk4:(id)sender {
    int blkNum=4;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk5:(id)sender {
    int blkNum=5;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk6:(id)sender {
    int blkNum=6;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk7:(id)sender {
    int blkNum=7;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk8:(id)sender {
    int blkNum=8;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk9:(id)sender {
    int blkNum=9;
    [self setBlkNum:blkNum];
}

- (IBAction)btnBlk10:(id)sender {
    int blkNum=10;
    [self setBlkNum:blkNum];
}

@end
