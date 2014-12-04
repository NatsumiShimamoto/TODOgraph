//
//  ContentsView.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2014/12/04.
//  Copyright (c) 2014年 嶋本夏海. All rights reserved.
//

#import "ContentsView.h"

@implementation ContentsView


- (void)commonInit
{
    // 画像の設定
    self.image = [UIImage imageNamed:@"contentsView.png"];
    
    // 位置と大きさの設定

    if([[UIScreen mainScreen] bounds].size.height==480){ //iPhone4,4s,iPod Touch第4世代
        self.frame = CGRectMake(26,80,270,270);
    }else if([[UIScreen mainScreen] bounds].size.height==568){ //iPhone5,5s,iPod Touch第5世代
        self.frame = CGRectMake(20,130,280,280);
        
    }else if([[UIScreen mainScreen] bounds].size.height==1024){ //iPad
        self.frame = CGRectMake(84,170,600,600);
        
    }

    
    //影の設定
    self.layer.shadowOpacity = 0.4; // 濃さを指定
    self.layer.shadowOffset = CGSizeMake(7.0, 7.0); // 影までの距離を指定
    
}


// contentsViewには３通りの初期化方法があるが、どの初期化方法でもcommonInitを呼び出すようにする

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
