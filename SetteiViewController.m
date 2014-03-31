//
//  ViewController2.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/12.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//設定画面

#import "SetteiViewController.h"

@implementation SetteiViewController

@synthesize editIndex; //スタンプの順番
@synthesize stampNum; //スタンプの番号


-(void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /* -- フォントの設定 */
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;

    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [kigenLabel setFont:[UIFont fontWithName:@"azuki_font" size:20]];
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        [kigenLabel setFont:[UIFont fontWithName:@"azuki_font" size:20]];
    }
    else{
        [kigenLabel setFont:[UIFont fontWithName:@"azuki_font" size:50]];
    }
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [juyouLabel setFont:[UIFont fontWithName:@"azuki_font" size:20]];
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
    [juyouLabel setFont:[UIFont fontWithName:@"azuki_font" size:20]];
    }
    else{
    [juyouLabel setFont:[UIFont fontWithName:@"azuki_font" size:50]];
    }
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [settingLabel setFont:[UIFont fontWithName:@"azuki_font" size:35]];

    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        [settingLabel setFont:[UIFont fontWithName:@"azuki_font" size:35]];
    }
    else{
        [settingLabel setFont:[UIFont fontWithName:@"azuki_font" size:70]];
}
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [kinLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        [kinLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
}
    else{
        [kinLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
}
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
         [enLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        [enLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
}
    else{
        [enLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
}
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [kouLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
    [kouLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
    }
    else{
    [kouLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
    }
    
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        [teiLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];

    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
    [teiLabel setFont:[UIFont fontWithName:@"azuki_font" size:13]];
    }
    else{
        [teiLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
    }

    
    [button setImage:[UIImage imageNamed:@"icon4.png"] forState:UIControlStateNormal];

    
    /* -- 各種情報の呼び出し -- */
    if(self.editIndex)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *array = [ud objectForKey:@"hoge"]; //hogeというキーでudという格納場所にarrayに入れる
        NSDictionary *dic = array[self.editIndex];
        
//        strtime = [dic objectForKey:@"date"];
//        [dateButton setTitle:strtime forState:UIControlStateNormal];
        
        textField.text = [dic objectForKey:@"contents"];
        
        kigenNum = [[dic objectForKey:@"kigen"] intValue];
        
        NSLog(@"ーーーーーーーーーーーー%d",kigenNum);
        [kigenSeg setSelectedSegmentIndex:kigenNum];
        
        juyouNum = [[dic objectForKey:@"juyou"] intValue];
        
        juyouSeg.selectedSegmentIndex = juyouNum;
        
        
    }
    
}


- (void)didReceiveMemoryWarningr
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated
{
    /* -- まっすー改造！！！！ --- */
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    
    stampNum = [sta integerForKey:@"stamp"];
    
    if(!stampNum) stampNum = 0;
    
    switch(stampNum){
        case 0:
            [button setImage:[UIImage imageNamed:@"icon01.png"] forState:UIControlStateNormal];
            break;
        case 1:
            [button setImage:[UIImage imageNamed:@"icon02.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [button setImage:[UIImage imageNamed:@"icon03.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [button setImage:[UIImage imageNamed:@"icon04.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [button setImage:[UIImage imageNamed:@"icon05.png"] forState:UIControlStateNormal];
            break;
        case 5:
            [button setImage:[UIImage imageNamed:@"icon06.png"] forState:UIControlStateNormal];
            break;
    }
}

/* --- やるべきことの入力 --- */
- (IBAction)doText{
    
    textField.adjustsFontSizeToFitWidth = NO;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    naiyo = textField.text;
    
}


#pragma mark - 切り替え
- (IBAction)SegChanged:(UISegmentedControl *)sender
{
    if(sender.tag == 1) kigenNum = sender.selectedSegmentIndex; //tag1のSegmentedControlが選択されたら、選択された値をkigenNumに入れる
    else juyouNum = sender.selectedSegmentIndex;
    NSLog(@"sender.tagは-------%d",sender.selectedSegmentIndex);
}



#pragma mark - スタンプ内容(データ)の保存
-(IBAction)hozon
{
    /* 保存用 */
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    NSArray *array = [ud objectForKey:@"hoge"];//hogeキーで取り出した予定をarrayに保存
    NSMutableArray *marray = [array mutableCopy];//arrayを編集可能なmutable型に
    if(marray == NULL){
        marray = [[NSMutableArray alloc] init];
    }
    
    
    /* アラート用 */
    int same = 0;
    
    for(int i = 0; i < [array count]; i++)
    {
        NSDictionary *dic = [array objectAtIndex:i];
        if([[dic objectForKey:@"kigen"] intValue] == kigenNum && [[dic objectForKey:@"juyou"] intValue] == juyouNum)
        {
            same = same + 1;
        }
        
        if(same > 14)
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                           message:@"これ以上保存できません"
                                                          delegate:nil
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"OK", nil
                                 ];
            
            [alert show];
            return;
        }
    }
    

    
    /* -- 予定の作成 -- */
    if(self.editIndex)
    {
        
        NSDictionary *dic = array[self.editIndex];
        NSMutableDictionary * mDic = [dic mutableCopy];
        
        //[mDic setObject:strtime forKey:@"date"];
        [mDic setObject:textField.text forKey:@"contents"];
        [mDic setObject:[NSString stringWithFormat:@"%d",stampNum] forKey:@"stamp"];
        [mDic setObject:[NSString stringWithFormat:@"%d",kigenNum] forKey:@"kigen"];
        [mDic setObject:[NSString stringWithFormat:@"%d",juyouNum] forKey:@"juyou"];
        
        
        NSMutableArray *mArray = [array mutableCopy];
        mArray[self.editIndex] = mDic;//mDicをmArrayに入れます。
        
        [ud setObject:mArray forKey:@"hoge"];
        [ud synchronize];
        NSLog(@"編集");
        //return;
    }else{
        NSDictionary *todo = [NSDictionary dictionaryWithObjectsAndKeys:
                              //strtime,@"date",
                              textField.text,@"contents",
                              [NSString stringWithFormat:@"%d",stampNum],@"stamp",
                              [NSString stringWithFormat:@"%d",kigenNum],@"kigen",
                              [NSString stringWithFormat:@"%d",juyouNum],@"juyou",
                              nil];
        
        
        [marray addObject:todo];
        [ud setObject:marray forKey:@"hoge"]; //udにhogeでmarrayをセットして保存
        [ud synchronize]; //UserDefaultsに即時反映
        
        NSLog(@"新規作成");
    }
    
    
    GraphViewController *prevController = [self.navigationController.viewControllers objectAtIndex:0];
    [prevController.noteView removeFromSuperview];
    prevController.noteView = nil;
    
    /* -- 戻る -- */
    [self.navigationController popViewControllerAnimated:YES];
}


/* -- 戻る -- */
-(IBAction)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    //GraphViewController *gvc = [[self storyboard] instantiateViewControllerWithIdentifier:@"graph"];
    //[self.view bringSubviewToFront:gvc.mainView];

}



@end
