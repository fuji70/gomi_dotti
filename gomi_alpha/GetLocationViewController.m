//
//  GetLocationViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2015/01/05.
//  Copyright (c) 2015年 vidacomoda. All rights reserved.
//

#import "GetLocationViewController.h"

@interface GetLocationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *lblLocation;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@end

@implementation GetLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myMapView.showsUserLocation = YES;
    [_myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
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
