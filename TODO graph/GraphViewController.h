//
//  GraphViewController.h
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/10/07.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SetteiViewController.h"//設定画面に、選んだスタンプのアイコン画像を送る
#import "ContentsView.h"
#import "GAITrackedViewController.h"

@interface GraphViewController :  GAITrackedViewController<UITextViewDelegate>{
    
    int height;
    
    IBOutlet UIButton *plusButton;
    BOOL isUnder;//あんべ追加
    NSUserDefaults *ud;
    
    NSArray *array;
    UIView *mainView;
    
    int i;
    int kigenNum;
    int juyouNum;
    
    IBOutlet UIButton *stampButton;
    IBOutlet UIImageView *haikeiView;
    IBOutlet UITextView *textView;
    
    BOOL loaded;
    
    UIImage *contentsImage;
    UIImage *close;
    UIImageView *closeView;
    IBOutlet UIButton *closeButton;
    IBOutlet UILabel *todoLabel;
    UIImageView *contentsStamp;
    
    int h;
    int w;

    BOOL upRed;
    BOOL upBlue;
    
    UIImage *plus;
    UIImageView *plusView;
    UIImage *trash;
    UIImageView *trashView;
}

@property (nonatomic) ContentsView *contentsView;
//@property UIView *mainView;


@end

