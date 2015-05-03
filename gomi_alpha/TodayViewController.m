//
//  TodayViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2014/11/30.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import "TodayViewController.h"
#import "HandleDb.h"
#import "MyTabBarController.h"

@interface TodayViewController ()
{
    NSDate *_curDate;
    AVSpeechSynthesizer *_speaker;
}

@property (weak, nonatomic) IBOutlet UILabel *lblBlknum;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgCurrent;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext1;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext2;
@property (weak, nonatomic) IBOutlet UIImageView *imgNext3;

@property (strong, nonatomic) IBOutlet UISwitch *swSpeech;
- (IBAction)touchSwSpeech:(id)sender;

- (IBAction)swipe_left:(id)sender;
- (IBAction)swipe_right:(id)sender;
@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _lblBlknum.text = [NSString stringWithFormat:@"%d", [HandleDb getBlkNum]];
    [self initCurrent];
    _swSpeech.on = [HandleDb getSpeechStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canDisplayBannerAds = YES; // auto add iAd banner
    //[self initCurrent];

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

- (void)refreshCurrent {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    dateFormatter.dateFormat = @"MM月dd日(E)";
    NSString *strCurDate = [dateFormatter stringFromDate:_curDate];
    
    NSLog(@"Refresh to date= [%@]", strCurDate);
    _lblCurrent.text = strCurDate;
    
    [self viewCurrentIcons];
    [self say_today];
}

- (void)initCurrent {
    _curDate = [NSDate date];
    [self refreshCurrent];
}

- (void)viewCurrentIcons {
    NSDate *now = _curDate;
    int oneday = 60*60*24;
    _imgCurrent.image = [HandleDb getIconImageFromDate:now];
    _imgNext1.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeInterval:oneday*1 sinceDate:now]];
    _imgNext2.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeInterval:oneday*2 sinceDate:now]];
    _imgNext3.image = [HandleDb getIconImageFromDate:
                       [now initWithTimeInterval:oneday*3 sinceDate:now]];
}

- (UIImage *)rndIcon {
    NSArray* strIcons = [NSArray arrayWithObjects:
                     @"燃やせるごみ",
                     @"燃やせないごみ",
                     @"プラスチック製容器包装類",
                     @"びん・かん・ペットボトル",
                     @"衣類・布類",
                     @"古紙類",
                     @"廃食用油・金属類",
                     nil];
    int iconTypes = (int)[strIcons count];
    
    int rnd = random() % iconTypes;
    NSString* rndStr = [strIcons objectAtIndex:rnd];
    NSLog(@"rndStr: %@", rndStr);
    //UIImage * rndImage = [self getImage:rndStr];
    UIImage * rndImage = [HandleDb getIconImage:rndStr];
    return rndImage;
}

- (IBAction)pushButtonDebug:(id)sender {
    _curDate = [_curDate initWithTimeInterval:(60*60*24) sinceDate:_curDate];
    [self refreshCurrent];
}

- (void)test_speech
{
    AVSpeechSynthesizer* speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    NSString* speakingText = @"こんにちは。";
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:speakingText];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;        //読み上げる速さ
    utterance.pitchMultiplier = 0.5f;                           //声の高さ
    utterance.volume = 0.5f;                                    //声の大きさ
    NSTimeInterval interval = 1;
    utterance.preUtteranceDelay = interval;                     //しゃべりだす前のインターバル
    utterance.postUtteranceDelay = interval;                    //しゃべり終わった後の次のメッセージをしゃべるまでのインターバル
    [speechSynthesizer speakUtterance:utterance];
    
    NSString* speakingText2 = @"ワンダープラネットです。";
    AVSpeechUtterance *utterance2 = [AVSpeechUtterance speechUtteranceWithString:speakingText2];
    utterance2.rate = AVSpeechUtteranceMinimumSpeechRate;        //読み上げる速さ
    utterance2.pitchMultiplier = 0.5f;                           //声の高さ
    utterance2.volume = 0.5f;                                    //声の大きさ
    [speechSynthesizer speakUtterance:utterance2];
}

- (void)speech_str:(NSString*)str {
    _speaker = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance * sentence = [AVSpeechUtterance speechUtteranceWithString:str];
    //sentence.rate = AVSpeechUtteranceDefaultSpeechRate;
    sentence.rate = 0.3;
    
    [_speaker speakUtterance:sentence];
    NSLog(@"speech: '%@'", str);
}

- (BOOL)say_today {
    if (![HandleDb getSpeechStatus]) return false;
    
    //[self test_speech];
    NSString *iconStr = [HandleDb getIconsStr:_curDate];
    NSString *typeStr = [HandleDb getSpeechStr:iconStr];
    NSString *speech = [NSString stringWithFormat:@"きょうのごみは、%@ です", typeStr];
    [self speech_str:speech];
    return true;
}

- (IBAction)touchSwSpeech:(id)sender {
    [HandleDb setSpeechStatus:_swSpeech.on];
    [self say_today];
}

- (IBAction)swipe_left:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeLeft];
}

- (IBAction)swipe_right:(id)sender {
    MyTabBarController *tb = (MyTabBarController*)self.tabBarController;
    [tb handleSwipeRight];
}
@end
