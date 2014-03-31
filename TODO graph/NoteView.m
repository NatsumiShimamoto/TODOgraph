//
//  NoteView.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2014/03/31.
//  Copyright (c) 2014年 嶋本夏海. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView

- (void)commonInit
{
    // 画像の設定
    self.image = [UIImage imageNamed:@"ノート正方形.png"];
    
    // 位置と大きさの設定
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        self.frame = CGRectMake(15,130,280,280);
    }else if(screenSize.width == 320.0 && screenSize.height == 480.0){
        self.frame = CGRectMake(15,130,280,280);
    }
    else{
        self.frame = CGRectMake(84,212,600,600);
        
    }
    
    //影の設定
    self.layer.shadowOpacity = 0.4; // 濃さを指定
    self.layer.shadowOffset = CGSizeMake(10.0, 10.0); // 影までの距離を指定
    
}


// NoteViewには３通りの初期化方法があるが、どの初期化方法でもcommonInitを呼び出すようにする
- (id)init
{
    self = [super init];
    if(self){
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInit];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if(self){
        [self commonInit];
    }
    return self;
}

@end
