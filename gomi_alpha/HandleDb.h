//
//  HandleDb.h
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleDb : NSObject

+ (NSString*)getIconsStr:(NSDate*)date;
+ (NSDate*)getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate;
+ (UIImage*)getIconImage:(NSString*)iconsStr;
+ (UIImage*)getIconImageFromDate:(NSDate*)date;
+ (NSString*)getPitStr:(NSString*)iconsStr;
+ (UIImage*)getMonthImage:(NSDate*)date;

+ (id)getInstance;
+ (int)getBlkNum;
+ (void)setBlkNum:(int) blkNum;
+ (void)testJson;



@end
