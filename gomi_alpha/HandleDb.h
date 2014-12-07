//
//  HandleDb.h
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleDb : NSObject

+ (UIImage*)getIconImage:(NSString*)icons;

+ (id)getInstance;
+ (int)getBlkNum;
+ (void)setBlkNum:(int) blkNum;
+ (void)testJson;



@end
