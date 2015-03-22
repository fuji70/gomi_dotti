//
//  main.m
//  gomi_alpha
//
//  Created by 岩崎正則 on 14/10/25.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        @catch (NSException * exception) {
            NSLog(@"%@", exception);
        }
    }
}
