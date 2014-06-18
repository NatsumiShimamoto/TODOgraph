//
//  ViewControllerTitle.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/15.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//タイトル

#import "TitleViewController.h"

@implementation TitleViewController
-(void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    [todo.layer setShadowOpacity:0.2f];
    [todo.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
}
@end
