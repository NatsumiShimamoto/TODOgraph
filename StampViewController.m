//
//  ViewController4.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/14.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.


#import "StampViewController.h"
#import "GraphViewController.h"

@implementation StampViewController
@synthesize buttonTag;
@synthesize showedContentsView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"ムムムッ%d",self.buttonTag);
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

-(IBAction)stamp:(UIButton *)stamp
{
    
    if(self.showedContentsView == YES){
        NSLog(@"YES");
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
        NSArray *array = [ud objectForKey:@"hoge"];
        
        NSDictionary *resaveDic = array[self.buttonTag];
        NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
        
        [resaveMDic setObject:[NSString stringWithFormat:@"%d",(int)stamp.tag] forKey:@"stamp"];
        
        
        NSLog(@"resaveMDic %@",resaveMDic);
        
        NSMutableArray *resaveMArray = [array mutableCopy];
        resaveMArray[self.buttonTag] = resaveMDic;
        
        [ud setObject:resaveMArray forKey:@"hoge"];
        [ud synchronize];
        
    }else{
        NSLog(@"NO");
        NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
        NSLog(@"button is %d", (int)stamp.tag);
        
        [sta setInteger:stamp.tag forKey:@"stamp"];
        
        [sta synchronize];
    }
    
    NSLog(@"ボタンの種類 == %d",(int)stamp.tag);
    /* -- 戻る --*/
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
