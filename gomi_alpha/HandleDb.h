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
+ (NSString*)getPitIconsStr:(NSDate*)date;//181014 捨て場所表示
+ (NSDate*)getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate;
+ (UIImage*)getIconImage:(NSString*)iconsStr;
+ (UIImage*)getPitIconImage:(NSString*)PiticonsStr;//181014 捨て場所表示
+ (UIImage*)getWordIconImage:(NSString*)iconsStr;
+ (UIImage*)getDateIconImage:(NSString*)iconsStr;
+ (UIImage*)getDatePitIconImage:(NSString*)PiticonsStr;//181014 捨て場所表示
+ (UIImage*)getIconImageFromDate:(NSDate*)date;
+ (UIImage*)getPitIconImageFromDate:(NSDate*)date;//181014 捨て場所表示
+ (NSString*)getPitStr:(NSString*)iconsStr;
+ (NSString*)getSpeechStr:(NSString*)iconsStr;
+ (UIImage*)getMonthImage:(NSDate*)date;

+ (id)getInstance;

+ (int)getBlkNum;
+ (void)setBlkNum:(int) blkNum;
+ (BOOL)getSpeechStatus;
+ (void)setSpeechStatus:(BOOL) sw;

+ (void)testJson;



@end
