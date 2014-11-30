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
#import "NoteView.h"

@interface GraphViewController : UIViewController<UITextViewDelegate>{
    
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
    
    UIImage *noteImage;
    UIImage *batsu;
    UIImageView *batsuView;
    IBOutlet UIButton *cancelButton;
    IBOutlet UILabel *todoLabel;
    UIImageView *todoStamp;
    
    int h;
    int w;

    BOOL upRed;
    BOOL upBlue;
    
    UIImage *plus;
    UIImageView *plusView;
    UIImage *trash;
    UIImageView *trashView;
}

@property (nonatomic) NoteView *noteView;
//@property UIView *mainView;


@end

