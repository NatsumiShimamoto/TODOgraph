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
#import "GAI.h"
#import "GAIDictionaryBuilder.h"

@interface GraphViewController :  GAITrackedViewController<UITextViewDelegate>{
    
    int screenHeight;
    NSUserDefaults *ud;
        
    NSArray *array;
    UIView *mainView;
    
    int i;
    int kigenNum;
    int juyouNum;
    int checkNumber;
    
    UIButton *stampButton;
    UITextView *textView;
    
    
    UIButton *closeButton;
    UIButton *contentsStamp;
   
    BOOL upRed;
    BOOL upBlue;
    
    UIButton *plusButton;
    
    UIImage *trash;
    UIImageView *trashView;

    NSString *stampImgNum;
    NSString *imageName;
    NSDictionary *stampDic;
}

@property (nonatomic) ContentsView *contentsView;
@end

