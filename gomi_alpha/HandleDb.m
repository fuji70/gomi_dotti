//
//  HandleDb.m
//  gomi_alpha
//
//  Created by Naoki on 2014/12/07.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "HandleDb.h"

NSString *FILE_DB = @"db2019.json";

@interface HandleDb ()
{
    NSDate       *_curDate;
    NSDictionary *_dbCalendar;
    NSDictionary *_dbIcon;
    NSDictionary *_dbPitIcon;//181014 捨て場所表示
    NSDictionary *_dbPit;
    NSDictionary *_dbSpeech;
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
               // filename       ,keyStr 2016
               @"kanen.png"      ,@"可・ビ",
               @"can.png"        ,@"カン",
               @"plastic.png"    ,@"プラ",
               @"funen.png"      ,@"不・本",
               @"petbottle.png"  ,@"ペット",
               @"shigen.png"     ,@"その他",
               nil];
}

- (void)initDbPitIcon {//181014 捨て場所表示
    _dbPitIcon = [NSDictionary dictionaryWithObjectsAndKeys:
               // filename       ,keyStr 2016
               @"pit_jitaku.png"     ,@"可・ビ",
               @"pit_jitaku.png"     ,@"カン",
               @"pit_jitaku.png"     ,@"プラ",
               @"pit_jitaku.png"     ,@"不・本",
               @"pit_jitaku.png"     ,@"ペット",
               @"pit_syuusekijp.png" ,@"その他",
               nil];
}

- (void)initDbPit {
    _dbPit = [NSDictionary dictionaryWithObjectsAndKeys:
              // Pit, keyStr 2016
              @"自宅前" ,@"可・ビ",
              @"自宅前" ,@"カン",
              @"自宅前" ,@"プラ",
              @"自宅前" ,@"不・本",
              @"自宅前" ,@"ペット",
              @"集積所" ,@"その他",
              nil];
}

- (void)initDbSpeech {
    _dbSpeech = [NSDictionary dictionaryWithObjectsAndKeys:
              // say, keyStr 2016
              @"カン、なべ類" ,@"カン",
              @"プラ、油、特定品目" ,@"プラ",
              @"ペットボトル" ,@"ペット",
              @"その他資源" ,@"その他",
              @"可燃ゴミ、ビン" ,@"可・ビ",
              @"不燃、本、雑がみ、商品プラ" ,@"不・本",
              nil];
}


- (id)init {
    if (self = [super init]) {
        _curDate = [NSDate date];
        _dbCalendar = [self loadJsonDb:FILE_DB];
        [self initDbIcon];
        [self initDbPitIcon];//181014 捨て場所表示
        [self initDbPit];
        [self initDbSpeech];
    }
    return self;
}

+ (NSString*)getIconsStr:(NSDate*)date {
    return [[HandleDb getInstance] _getIconsStr:date];
}

+ (NSString*)getPitIconsStr:(NSDate*)date {//181014 捨て場所表示
    return [[HandleDb getInstance] _getPitIconsStr:date];
}

- (NSString*)_getIconsStr:(NSDate*)date {
    NSString *keyBlk = [HandleDb getKeyBlk];
    NSString *keyDate = [HandleDb getKeyDate:date];
    NSString *keyPath = [NSString stringWithFormat:@"%@.%@", keyBlk, keyDate];
    NSString *value = [_dbCalendar valueForKeyPath:keyPath];
    NSLog(@"getIconsStr:[%@] %@", keyPath, value);
    return value;
}

- (NSString*)_getPitIconsStr:(NSDate*)date {//181014 捨て場所表示
    NSString *keyBlk = [HandleDb getKeyBlk];
    NSString *keyDate = [HandleDb getKeyDate:date];
    NSString *keyPath = [NSString stringWithFormat:@"%@.%@", keyBlk, keyDate];
    NSString *value = [_dbCalendar valueForKeyPath:keyPath];
    NSLog(@"getPitIconsStr:[%@] %@", keyPath, value);
    return value;
}

+ (NSDate*)getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate {
    return [[HandleDb getInstance] _getNextDate:iconsStr startDate:startDate];
}

- (NSDate*)_getNextDate:(NSString*)iconsStr startDate:(NSDate*)startDate {
    NSDate *date = [NSDate alloc];
    NSDate *rdate = nil;
    int oneday = 60*60*24;
    int searchDays = 42;
    for (int i=0; i<searchDays; ++i) {
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
+ (UIImage*)getPitIconImageFromDate:(NSDate*)date {//181014 捨て場所表示
    return [[HandleDb getInstance] _getPitIconImage:[HandleDb getPitIconsStr:date]];
}

+ (UIImage*)getIconImage:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getIconImage:iconsStr];
}
+ (UIImage*)getPitIconImage:(NSString*)PiticonsStr {//181014 捨て場所表示
    return [[HandleDb getInstance] _getPitIconImage:PiticonsStr];
}

+ (UIImage*)getWordIconImage:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getWordIconImage:iconsStr];
}

+ (UIImage*)getDateIconImage:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getDateIconImage:iconsStr];
}

+ (UIImage*)getDatePitIconImage:(NSString*)PiticonsStr {//181014 捨て場所表示
    return [[HandleDb getInstance] _getDatePitIconImage:PiticonsStr];
}

- (NSString*)_getPitStr:(NSString*)iconsStr {
    return _dbPit[iconsStr];
}

+ (NSString*)getPitStr:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getPitStr:iconsStr];
}

- (NSString*)_getSpeechStr:(NSString*)iconsStr {
    NSString *ret = _dbSpeech[iconsStr];
    
    return (ret ? ret : @"回収無し");
}

+ (NSString*)getSpeechStr:(NSString*)iconsStr {
    return [[HandleDb getInstance] _getSpeechStr:iconsStr];
}

+ (NSString*)getKeyDate: (NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    NSLog(@"keyDate= [%@]", strDate);
    return strDate;
}

+ (NSString*)getKeyBlk {
    int blkNum = [HandleDb getBlkNum];
    return [NSString stringWithFormat:@"blk-%d", blkNum];
}

- (UIImage*)_getIconImage:(NSString*)iconsStr {
    NSString * imgName = [_dbIcon objectForKey:iconsStr];
    NSLog(@"icons: %@  ->  imgName: %@", iconsStr, imgName);
    return [UIImage imageNamed:imgName];
}

- (UIImage*)_getPitIconImage:(NSString*)PiticonsStr {//181014 捨て場所表示
    NSString * imgName = [_dbPitIcon objectForKey:PiticonsStr];
    NSLog(@"icons: %@  ->  imgName: %@", PiticonsStr, imgName);
    return [UIImage imageNamed:imgName];
}

- (UIImage*)_getWordIconImage:(NSString*)iconsStr {
    NSString * imgName = [NSString stringWithFormat:@"word_%@", [_dbIcon objectForKey:iconsStr]];
    NSLog(@"wordicons: %@  ->  imgName: %@", iconsStr, imgName);
    return [UIImage imageNamed:imgName];
}

- (UIImage*)_getDateIconImage:(NSString*)iconsStr {
    NSString * baseName = [_dbIcon objectForKey:iconsStr];
    if (!baseName) { baseName = @"non.png"; }
    NSString * imgName = [NSString stringWithFormat:@"date_%@", baseName];
    NSLog(@"dateicons: %@  ->  imgName: %@", iconsStr, imgName);
    return [UIImage imageNamed:imgName];
}

- (UIImage*)_getDatePitIconImage:(NSString*)PiticonsStr {//181014 捨て場所表示
    NSString * baseName = [_dbPitIcon objectForKey:PiticonsStr];
    if (!baseName) { baseName = @"non.png"; }
    NSString * imgName = [NSString stringWithFormat:@"date_%@", baseName];
    NSLog(@"dateicons: %@  ->  imgName: %@", PiticonsStr, imgName);
    return [UIImage imageNamed:imgName];
}

+ (UIImage*)getMonthImage:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSString *imgName = [NSString stringWithFormat:@"%dblk-%@.png", [HandleDb getBlkNum], strDate];
    NSLog(@"month: %@", imgName);
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
    if (error != nil) {
        NSLog(@"failed to parse Json %ld", (long)error.code);
    }
    
    // JSONのパースに失敗した場合は`nil`が入る
    if (dic) {
        NSLog(@"NSDictionary: %@", dic);
    }
    else {
        NSLog(@"Error: %@", error);
    }

    NSString *value = [dic valueForKeyPath:@"blk-1.2016-04-01"];
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

+ (BOOL)getSpeechStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults boolForKey:@"doesSpeech"];
}

+ (void)setSpeechStatus:(BOOL) sw
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sw forKey:@"doesSpeech"];
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"set to doesSpeech: %d.", sw);
    }
}

@end
