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

@interface GraphViewController : UIViewController{
    
    IBOutlet UIButton *plusButton;
    NSUserDefaults *ud;
    
    UIImageView *gomi;
    UIImage *gomibako;
    
    NSArray *array;
    UIView *mainView;
    
    int i;
    int kigenNum;
    int juyouNum;
    
    IBOutlet UIButton *stampButton;
    IBOutlet UIImageView *haikeiView;
    
    BOOL loaded;
    
    UIImage *noteImage;
    UIImage *batsu;
    UIImageView *batsuView;
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *todoLabel;
    UIImageView *todoStamp;
    
    int h;
    int w;
    
    BOOL todoFade;
    
}


@property (nonatomic) UIImageView *noteView;


@end

