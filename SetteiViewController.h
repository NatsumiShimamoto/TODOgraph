//
//  ViewController2.h
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/12.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//設定画面

#import <UIKit/UIKit.h>
#import "GraphViewController.h"//スタンプの画像情報を受け取る用

@interface SetteiViewController : UIViewController<UITextFieldDelegate>

{
    IBOutlet UISegmentedControl *kigenSeg;
    IBOutlet UISegmentedControl *juyouSeg;

    IBOutlet UITextField *textField;
    
    NSString *contents; //key
    NSString *naiyo; //要素
    
    int kigenNum; //SegmentedControl
    
    int juyouNum; //SegmentedControl
    
    IBOutlet UILabel *kigenLabel;
    IBOutlet UILabel *juyouLabel;
    IBOutlet UILabel *settingLabel;
    IBOutlet UILabel *kinLabel;
    IBOutlet UILabel *enLabel;
    IBOutlet UILabel *kouLabel;
    IBOutlet UILabel *teiLabel;
    IBOutlet UILabel *lineLabel;

    
    IBOutlet UIButton *button; //動きの命令じゃないからIBActionではない
    
    IBOutlet UIButton *checkButton;
    IBOutlet UIButton *backButton;
}

@property int editIndex; //スタンプを作った順番
@property int stampNum;//スタンプの番号


- (IBAction)doText; //TextFieldに入力する

-(IBAction)hozon; //設定完了ボタンを押す


@end
