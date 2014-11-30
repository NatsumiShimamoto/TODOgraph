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
   
   /*
    UIImage *icon1 = [UIImage imageNamed:@"icon01.png"];
    UIImage *icon2 = [UIImage imageNamed:@"icon02.png"];
    UIImage *icon3 = [UIImage imageNamed:@"icon03.png"];
    UIImage *icon4 = [UIImage imageNamed:@"icon04.png"];
    UIImage *icon5 = [UIImage imageNamed:@"icon05.png"];
    UIImage *icon6 = [UIImage imageNamed:@"icon06.png"];
    
    NSArray *iconArray =  [[NSArray alloc] initWithObjects:icon1,icon2,icon3,icon4,icon5,icon6,nil];

    UIImage *icon = [[UIImage alloc] init];
    int stampArrNum = 0;
    
    icon = iconArray[stampArrNum];
    
    UIButton *button = [[UIButton alloc]init];
    [button setImage:iconArray[stampArrNum] forState:UIControlStateNormal];
    
    //UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
*/
    
    stmArray[0] = [UIImage imageNamed:@"icon1"];
    stmArray[1] = [UIImage imageNamed:@"icon2"];
    stmArray[2] = [UIImage imageNamed:@"icon3"];
    stmArray[3] = [UIImage imageNamed:@"icon4"];
    stmArray[4] = [UIImage imageNamed:@"icon5"];
    stmArray[5] = [UIImage imageNamed:@"icon6"];
    stmArray[6] = [UIImage imageNamed:@"icon7"];
    stmArray[7] = [UIImage imageNamed:@"icon8"];
    stmArray[8] = [UIImage imageNamed:@"icon9"];
    stmArray[9] = [UIImage imageNamed:@"icon10"];
    stmArray[10] = [UIImage imageNamed:@"icon11"];
    stmArray[11] = [UIImage imageNamed:@"icon12"];



    //i = 0;
    
    
    [label setFont:[UIFont fontWithName:@"azuki_font" size:20]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(IBAction)stamp:(UIButton *)button
{
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    NSLog(@"button is %d", (int)button.tag);
    
    [sta setInteger:button.tag forKey:@"stamp"];

    [sta synchronize];
    
    /* -- 戻る --*/
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

        
    NSLog(@"戻る");
}



@end
