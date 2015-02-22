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
    
    int screenHeight;

    NSUserDefaults *ud;
    
    NSArray *array;
    UIView *mainView;
    
    int i;
    int kigenNum;
    int juyouNum;
    
    UIButton *stampButton;
    UITextView *textView;
    
    UIImage *contentsImage;
    
    UIButton *closeButton;
    UIImageView *contentsStamp;
    
    int h;
    int w;

    BOOL upRed;
    BOOL upBlue;
    
    UIButton *plusButton;
    
    UIImage *trash;
    UIImageView *trashView;
    
    BOOL showedContentsView;
    NSString *GVstStampNum;
}

@property (nonatomic) ContentsView *contentsView;

@end

