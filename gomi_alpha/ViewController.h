//
//  ViewController.h
//  gomi_alpha
//
//  Created by 岩崎正則 on 14/10/25.
//  Copyright (c) 2014年 vidacomoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UIPickerViewDelegate,UIPickerViewDataSource> {
    IBOutlet UIPickerView *pickerView;
    IBOutlet UILabel *labelNunber;
    
    IBOutlet UIWebView *webView1;//藤沢市ごみ分別HP用
    IBOutlet UIWebView *webView2;//藤沢市ブロック検索HP用
}
@end

