//
//  TypeSearchViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/10.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "WebTypeSearchViewController.h"

@interface WebTypeSearchViewController ()
@property (strong, nonatomic) IBOutlet UIWebView *webTypeSearch;

@end


@implementation WebTypeSearchViewController

- (void)loadWeb {
    NSString* strUrl = @"http://www.city.chigasaki.kanagawa.jp/kankyo/gomi/1003246/index.html";
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: [NSURL URLWithString:strUrl]];
    [_webTypeSearch loadRequest:myRequest];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    [self loadWeb];
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

@end
