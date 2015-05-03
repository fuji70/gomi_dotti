//
//  GetLocationViewController.m
//  gomi_alpha
//
//  Created by Naoki on 2015/01/05.
//  Copyright (c) 2015年 vidacomoda. All rights reserved.
//

#import "GetLocationViewController.h"

@interface GetLocationViewController ()
{
    CLLocationManager* locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *lblLocation;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@end

@implementation GetLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startLocationServices];
    _myMapView.showsUserLocation = YES;
    [_myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
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

- (void) startLocationServices
{
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
        // iOS8の場合は、以下の何れかの処理を追加しないと位置の取得ができない
        // アプリがアクティブな場合だけ位置取得する場合
        [locationManager requestWhenInUseAuthorization];
        // アプリが非アクティブな場合でも位置取得する場合
        //[locationManager requestAlwaysAuthorization];
    }
    
    if([CLLocationManager locationServicesEnabled]){
        // 位置情報取得開始
        [locationManager startUpdatingLocation];
    }else{
        // 位置取得が許可されていない場合
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    // 位置情報取得
    CLLocationDegrees latitude = newLocation.coordinate.latitude;
    CLLocationDegrees longitude = newLocation.coordinate.longitude;
    NSLog(@"Currect Location %f, %f", latitude, longitude);
    [self setAddressText:newLocation.coordinate];
    // ロケーションマネージャ停止
    //[locationManager stopUpdatingLocation];
}

// 位置情報が取得失敗した場合にコールされる。
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error) {
        switch ([error code]) {
                // アプリでの位置情報サービスが許可されていない場合
            case kCLErrorDenied:
                NSLog(@"%@", @"このアプリは位置情報サービスが許可されていません");
                break;
            default:
                NSLog(@"%@", @"位置情報の取得に失敗しました");
                break;
        }
    }
    // 位置情報取得停止
    [locationManager stopUpdatingLocation];
}

- (void)setAddressText:(CLLocationCoordinate2D)coordinate
{
    // 緯度・経度
    //double latitude = 35.658704;
    //double longitude = 139.745408;
    CLLocationDegrees latitude  = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    // 逆ジオコーディング
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray* placemarks, NSError* error) {
                       if(error){
                           // エラーが発生している
                           NSLog(@"エラー %@", error);
                       } else {
                           if ([placemarks count] > 0) {
                               // 住所取得成功
                               CLPlacemark *placemark = (CLPlacemark *)[placemarks lastObject];
                               NSLog(@"%@,%@", placemark.locality, placemark.country);
                               NSDictionary *dict = placemark.addressDictionary;
                               NSArray *lines = [dict valueForKey:@"FormattedAddressLines"];
                               NSString *line = @"";
                               for (int i = 0; i < lines.count; i++) {
                                   line = [line stringByAppendingFormat:@"%@ ", [lines objectAtIndex:i]];
                               }
                               _lblLocation.text = [NSString stringWithFormat:@"%@",line];
                           }
                       }
                   }];
}

@end
