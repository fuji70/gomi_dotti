//
//  HandleDb.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "HandleDb.h"

NSString *FILE_DB = @"db2014.json";

@interface HandleDb ()
{
    NSDate       *_curDate;
    NSDictionary *_dbCalendar;
    NSDictionary *_dbIcon;
    NSDictionary *_dbPit;
}
@end

@implementation HandleDb

#pragma mark Singleton Methods

+ (id)getInstance {
    static HandleDb *sharedDb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDb = [[self alloc] init];
    });
    return sharedDb;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (void)initDbIcon {
    _dbIcon = [NSDictionary dictionaryWithObjectsAndKeys:
               // filename       ,keyStr
               @"can.png"        ,@"カン",
               @"plastic.png"    ,@"プ・油・特",
               @"petbottle.png" ,@"ペット",
               @"shigen.png"     ,@"他資源",
               @"kanen.png"      ,@"可・ビン",
               @"funen.png"      ,@"本・不・商",
               nil];
}

- (void)initDbPit {
    _dbPit = [NSDictionary dictionaryWithObjectsAndKeys:
              // Pit, keyStr
              @"自宅前" ,@"カン",
              @"自宅前" ,@"プ・油・特",
              @"自宅前" ,@"ペット",
              @"集積所" ,@"他資源",
              @"自宅前" ,@"可・ビン",
              @"自宅前" ,@"本・不・商",
              nil];
}

+ (NSString*)getIconsStr:(NSDate*)date {
    return [[HandleDb getInstance] _getIconsStr:date];
}

- (NSString*)_getIconsStr:(NSDate*)date {
    NSString *keyBlk = [HandleDb getKeyBlk];
    NSString *keyDate = [HandleDb getKeyDate:date];
    NSString *keyPath = [NSString stringWithFormat:@"%@.%@", keyBlk, keyDate];
    NSString *value = [_dbCalendar valueForKeyPath:keyPath];
    NSLog(@"getIconsStr: %@", value);
    return value;
}

+ (NSDate*)getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate {
    return [[HandleDb getInstance] _getNextDate:iconsStr startDate:startDate];
}

- (NSDate*)_getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate {
    NSDate *date = [NSDate alloc];
    NSDate *rdate = nil;
    int oneday = 60*60*24;
    for (int i=0; i<14; ++i) {
        date = [date initWithTimeInterval:oneday*i sinceDate:startDate];
        NSString *ticons = [self _getIconsStr:date];
        NSLog(@"searchNext: %d  %@  %@", i, date, ticons);
        if ([ticons isEqualToString:iconsStr]) {
            rdate = date;
            break;
        }
    }
    return rdate;
}

+ (UIImage*)getIconImageFromDate:(NSDate*)date {
    return [[HandleDb getInstance] _getIconImage:[HandleDb getIconsStr:date]];
}

+ (UIImage*)getIconImage:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getIconImage:iconsStr];
}

- (NSString*)_getPitStr:(NSString*)iconsStr {
    return _dbPit[iconsStr];
}

+ (NSString*)getPitStr:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getPitStr:iconsStr];
}

+ (NSString*)getKeyDate: (NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    NSLog(@"keyDate= [%@]", strDate);
    return strDate;
}

+ (NSString*)getKeyBlk {
    int blkNum = [HandleDb getBlkNum];
    return [NSString stringWithFormat:@"blk-%d", blkNum];
}

- (id)init {
    if (self = [super init]) {
        _curDate = [NSDate date];
        _dbCalendar = [self loadJsonDb:FILE_DB];
        [self initDbIcon];
        [self initDbPit];
    }
    return self;
}

- (UIImage*)_getIconImage:(NSString*)iconsStr {
    NSString * imgName = [_dbIcon objectForKey:iconsStr];
    NSLog(@"icons: %@  ->  imgName: %@", iconsStr, imgName);
    return [UIImage imageNamed:imgName];
}

+ (UIImage*)getMonthImage:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM";
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSString *imgName = [NSString stringWithFormat:@"%dblk-%@.png", [HandleDb getBlkNum], strDate];
    return [UIImage imageNamed:imgName];
}

- (NSDictionary *)loadJsonDb:(NSString *)infile {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:infile ofType:nil];
    NSError *error;
    NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"Loadfile: %@", infile);
    NSLog(@" in NSString: %@", text);
    
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingAllowFragments
                                                          error:&error];
    // JSONのパースに失敗した場合は`nil`が入る
    if (dic) {
        NSLog(@"NSDictionary: %@", dic);
    }
    else {
        NSLog(@"Error: %@", error);
    }

    NSString *value = [dic valueForKeyPath:@"blk-8.2014-12-12"];
    NSLog(@"val: %@", value);

    return dic;
}


+ (int)getBlkNumDefault {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults integerForKey:@"blkNum"];
}

+ (int)getBlkNum {
    return [self getBlkNumDefault];
}

+ (void)setBlkNum:(int) blkNum {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:blkNum forKey:@"blkNum"];
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"set to blkNum: %d.", blkNum);
    }
}

+ (void)testJson {
    //read file
    /*
    NSString* fileName  = [NSString stringWithFormat:@"test.json"];
    NSString* path      = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Supporting Files"];
    path = [path stringByAppendingPathComponent:fileName];
    NSData* data = [NSData dataWithContentsOfFile:path];
    if(data == nil) abort();
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
*/
    /*
    NSString* string = @'{"employees":[{"lastName":"Doe","firstName":"John"},{"lastName":"Smith","firstName":"Anna"},{"lastName":"Jones","firstName":"Peter"}]}';
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", obj);
    */
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"db2014.json" ofType:nil];
    NSError *error;
    NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"NSString: %@", text);

    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NSData: %@", data);
     id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"id: %@", obj);

    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    // JSONのパースに失敗した場合は`nil`が入る
    if (json) {
        NSLog(@"NSDictionary: %@", json);
    }
    
}
@end
