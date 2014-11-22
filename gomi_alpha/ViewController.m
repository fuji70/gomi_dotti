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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
