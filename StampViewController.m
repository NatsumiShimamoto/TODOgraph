//
//  ViewController4.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/14.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//スタンプ

#import "StampViewController.h"

@implementation StampViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    stmArray[0] = [UIImage imageNamed:@"icon01"];
    stmArray[1] = [UIImage imageNamed:@"icon02"];
    stmArray[2] = [UIImage imageNamed:@"icon03"];
    stmArray[3] = [UIImage imageNamed:@"icon04"];
    stmArray[4] = [UIImage imageNamed:@"icon05"];
    stmArray[5] = [UIImage imageNamed:@"icon06"];

    
    i = 0;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(IBAction)stamp:(UIButton *)sender
{
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    NSLog(@"sender is %d", sender.tag);
    
    [sta setInteger:sender.tag forKey:@"stamp"];

    [sta synchronize];
    
    /* -- 戻る --*/
    [self.navigationController popViewControllerAnimated:YES];
}



@end
