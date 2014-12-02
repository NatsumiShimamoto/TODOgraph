//
//  ViewController2.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/12.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

//設定画面

#import "SetteiViewController.h"
#import "StampViewController.h"

@implementation SetteiViewController

@synthesize editIndex; //スタンプの順番
//@synthesize stampArrNum; //スタンプの番号


-(void)viewDidLoad{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    /* -- フォントの設定 */
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
    }
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        /* segmentedcontrollのサイズ変更 */
        CGRect kigenSegFrame= kigenSeg.frame;
        kigenSeg.frame = CGRectMake(kigenSegFrame.origin.x, kigenSegFrame.origin.y,
                                    kigenSegFrame.size.width, kigenSegFrame.size.height-3) ;
        CGRect juyouSegFrame= juyouSeg.frame;
        juyouSeg.frame = CGRectMake(juyouSegFrame.origin.x, juyouSegFrame.origin.y,
                                    juyouSegFrame.size.width, juyouSegFrame.size.height-3) ;
    }
    else{
        
        CGRect kigenSegFrame= kigenSeg.frame;
        kigenSeg.frame = CGRectMake(kigenSegFrame.origin.x, kigenSegFrame.origin.y,
                                  kigenSegFrame.size.width+210, kigenSegFrame.size.height+40) ;
        CGRect juyouSegFrame= juyouSeg.frame;
        juyouSeg.frame = CGRectMake(juyouSegFrame.origin.x, juyouSegFrame.origin.y,
                                juyouSegFrame.size.width+210, juyouSegFrame.size.height+40) ;
        
        /* textFieldのサイズ変更 */
        CGRect textFieldFrame= textField.frame;
        textField.frame = CGRectMake(textFieldFrame.origin.x, textFieldFrame.origin.y,
                                    textFieldFrame.size.width, textFieldFrame.size.height+40) ;
        
    }
    
    
    /* -- 各種情報の呼び出し -- */
    if(self.editIndex)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSArray *array = [ud objectForKey:@"hoge"]; //hogeというキーでudという格納場所にarrayに入れる
        NSDictionary *dic = array[self.editIndex];
        
        
        textField.text = [dic objectForKey:@"contents"];
        
        kigenNum = [[dic objectForKey:@"kigen"] intValue];
        
        NSLog(@"ーーーーーーーーーーーー%d",kigenNum);
        [kigenSeg setSelectedSegmentIndex:kigenNum];
        
        juyouNum = [[dic objectForKey:@"juyou"] intValue];
        
        juyouSeg.selectedSegmentIndex = juyouNum;
        
        
    }
    
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
}


- (void)didReceiveMemoryWarningr
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    NSUserDefaults *sta = [NSUserDefaults standardUserDefaults]; //UserDefaultsのデータ領域の一部をudとおく
    
    stampArrNum = [sta integerForKey:@"stamp"]; //@"stamp"のkeyにはアイコンのタグが入ってる(0から)

    
    UIImage *icon1 = [UIImage imageNamed:@"icon1_todo.png"];
    UIImage *icon2 = [UIImage imageNamed:@"icon2_todo.png"];
    UIImage *icon3 = [UIImage imageNamed:@"icon3_todo.png"];
    UIImage *icon4 = [UIImage imageNamed:@"icon4_todo.png"];
    UIImage *icon5 = [UIImage imageNamed:@"icon5_todo.png"];
    UIImage *icon6 = [UIImage imageNamed:@"icon6_todo.png"];
    UIImage *icon7 = [UIImage imageNamed:@"icon7_todo.png"];
    UIImage *icon8 = [UIImage imageNamed:@"icon8_todo.png"];
    UIImage *icon9 = [UIImage imageNamed:@"icon9_todo.png"];
    UIImage *icon10 = [UIImage imageNamed:@"icon10_todo.png"];
    UIImage *icon11 = [UIImage imageNamed:@"icon11_todo.png"];
    UIImage *icon12 = [UIImage imageNamed:@"icon12_todo.png"];


    NSArray *iconArray =  [[NSArray alloc] initWithObjects:icon1,icon2,icon3,icon4,icon5,icon6,icon7,icon8,icon9,icon10,icon11,icon12,nil];
        
    UIImage *icon = [[UIImage alloc] init];
    icon = iconArray[stampArrNum];
    
    NSLog(@"stampArrNum == %d",stampArrNum);
    
    iconView = [[UIImageView alloc] initWithImage:icon];
    
    
    if([[UIScreen mainScreen] bounds].size.height==480){ //iPhone4,4s,iPod Touch第4世代
        
       iconView.frame = CGRectMake(132, 105, 55, 55);
        
    }else if([[UIScreen mainScreen] bounds].size.height==568){ //iPhone5,5s,iPod Touch第5世代
        
        iconView.frame = CGRectMake(127, 130, 70, 70);
        
    }else if([[UIScreen mainScreen] bounds].size.height==1024){
      
        iconView.frame = CGRectMake(318, 218, 120, 120);
    }

   
    
    [self.view addSubview:iconView];
    
    
     iconView.userInteractionEnabled = YES;
    iconView.tag = 1;
    
}


/* --- やるべきことの入力 --- */
- (IBAction)doText{
    
    textField.adjustsFontSizeToFitWidth = NO;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    naiyo = textField.text;
}


- (BOOL)textField:(UITextField *)lenTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 31;
    
    // 入力済みのテキストを取得
    NSMutableString *mTextField = [lenTextField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [mTextField replaceCharactersInRange:range withString:string];
    
    if ([mTextField length] > maxInputLength) {
       
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"文字数オーバー"
                                                  message:@"30字まで入力できます。"
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:@"OK", nil
                         
                         ];
    [alert show];

        return NO;
    }
    
    return YES;
}


#pragma mark - タッチ
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //キーボードを閉じる
    [textField resignFirstResponder];
    
    
    UITouch *touch = [touches anyObject];
    StampViewController *stampVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stamp"];
    
    
    switch (touch.view.tag) {
        case 1:
            [self presentViewController:stampVC animated:YES completion:nil];
            NSLog(@"画面遷移");
            [iconView removeFromSuperview];
            break;
            
            
        default:
            break;
    }
}


    

    
#pragma mark - 切り替え
- (IBAction)SegChanged:(UISegmentedControl *)sender
{
    if(sender.tag == 1) kigenNum = (int)sender.selectedSegmentIndex; //tag1のSegmentedControlが選択されたら、選択された値をkigenNumに入れる
    else juyouNum = (int)sender.selectedSegmentIndex;
    NSLog(@"sender.tagは-------%d",(int)sender.selectedSegmentIndex);
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
        [mDic setObject:[NSString stringWithFormat:@"%d",stampArrNum] forKey:@"stamp"];
        [mDic setObject:[NSString stringWithFormat:@"%d",kigenNum] forKey:@"kigen"];
        [mDic setObject:[NSString stringWithFormat:@"%d",juyouNum] forKey:@"juyou"];
        
        
        NSMutableArray *mArray = [array mutableCopy];
        mArray[self.editIndex] = mDic;//mDicをmArrayに入れます。
        
        [ud setObject:mArray forKey:@"hoge"];
        [ud synchronize];
        NSLog(@"編集");
        
    }else{
        NSDictionary *todo = [NSDictionary dictionaryWithObjectsAndKeys:
                              textField.text,@"contents",
                              [NSString stringWithFormat:@"%d",stampArrNum],@"stamp",
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
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"もどったよ");
}


/* -- 戻る -- */
-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}



@end
