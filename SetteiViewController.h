//
//  ViewController2.h
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/12.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//設定画面

#import <UIKit/UIKit.h>
#import "GraphViewController.h"//スタンプの画像情報を受け取る用
#import "GAITrackedViewController.h"

@interface SetteiViewController : GAITrackedViewController<UITextFieldDelegate>
{
    int screenHeight;
    
    IBOutlet UISegmentedControl *kigenSeg;
    IBOutlet UISegmentedControl *juyouSeg;

    IBOutlet UITextField *textField;
    
    NSString *contents; //key
    NSString *naiyo; //要素
    
    int kigenNum; //SegmentedControl
    int juyouNum; //SegmentedControl
    

    UIImageView *iconView;
    
    IBOutlet UIButton *checkButton;
    IBOutlet UIButton *backButton;
    
    NSString *stStampArrNum;
    int stampArrNum;
}

- (IBAction)doText; //TextFieldに入力する
-(IBAction)hozon; //設定完了ボタンを押す

@property int editIndex; //スタンプを作った順番
//@property int stampArrNum;//スタンプの番号


@end
