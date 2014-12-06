//
//  ViewController.m
//  gomi_alpha
//
//  Created by 岩崎正則 on 14/10/25.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar
{
    // UISearchBar からフォーカスを外します。
    [searchBar resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest* req1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.jp/"]]; [webView1 loadRequest:req1];
//    NSURLRequest* req1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://fj4.city.fujisawa.kanagawa.jp/fdust/"]]; [webView1 loadRequest:req1];
    NSURLRequest* req2 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.jp/"]]; [webView2 loadRequest:req2];
//    NSURLRequest* req2 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.city.fujisawa.kanagawa.jp/kankyo-j/kurashi/gomi/shushubi/h2603-h2703/jusho-a-ta.html"]]; [webView2 loadRequest:req2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload { }

// web を解放
- (void)dealloc1 { webView1.delegate = nil; }
- (void)dealloc2 { webView2.delegate = nil; }

@end
