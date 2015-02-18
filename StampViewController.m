//
//  ViewController4.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/14.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

#import "StampViewController.h"

@implementation StampViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.screenName = @"StampScreen";
}

-(IBAction)stamp:(UIButton *)button
{
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    [sta setInteger:button.tag forKey:@"stamp"];
    [sta synchronize];
    
    /* -- 戻る --*/
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
