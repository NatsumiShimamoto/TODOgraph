//
//  ViewController2.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/08/12.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.

#import "SetteiViewController.h"
#import "StampViewController.h"

#define SCREEN_HEIGHT_4     460 //iPhone4,4s,iPod Touch第4世代
#define SCREEN_HEIGHT_5     568 //iPhone5,5s,iPhod Touch第5世代
#define SCREEN_HEIGHT_PAD   1024 //iPad

@implementation SetteiViewController

@synthesize editIndex; //スタンプの順番

-(void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    if(screenHeight == SCREEN_HEIGHT_5)
    {
    }else if(screenHeight == SCREEN_HEIGHT_4)
    {
        /* segmentedcontrollのサイズ変更 */
        CGRect kigenSegFrame= kigenSeg.frame;
        kigenSeg.frame = CGRectMake(kigenSegFrame.origin.x, kigenSegFrame.origin.y,
                                    kigenSegFrame.size.width, kigenSegFrame.size.height-3) ;
        CGRect juyouSegFrame= juyouSeg.frame;
        juyouSeg.frame = CGRectMake(juyouSegFrame.origin.x, juyouSegFrame.origin.y,
                                    juyouSegFrame.size.width, juyouSegFrame.size.height-3) ;
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        CGRect kigenSegFrame= kigenSeg.frame;
        kigenSeg.frame = CGRectMake(kigenSegFrame.origin.x, kigenSegFrame.origin.y,
                                    kigenSegFrame.size.width+210, kigenSegFrame.size.height+40) ;
        CGRect juyouSegFrame= juyouSeg.frame;
        juyouSeg.frame = CGRectMake(juyouSegFrame.origin.x, juyouSegFrame.origin.y,
                                    juyouSegFrame.size.width+210, juyouSegFrame.size.height+40) ;
        
        /* textFieldのサイズ変更 */
        CGRect textFieldFrame= textField.frame;
        textField.frame = CGRectMake(textFieldFrame.origin.x, textFieldFrame.origin.y,
                                     textFieldFrame.size.width, textFieldFrame.size.height+40);
    }
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeyDone;
}


- (void)didReceiveMemoryWarningr
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    NSUserDefaults *stampUD = [NSUserDefaults standardUserDefaults];
    
    stampArrString = [stampUD objectForKey:@"stamp"]; //@"stamp"のkeyにはアイコンのタグが入ってる(0から)
    stampArrNum = [stampArrString intValue];
    
    if(!iconArray){
        
        iconArray = [[NSMutableArray alloc] init];
        
        for(int i=0; i<=11; i++){
            
            NSString *iconName = [NSString stringWithFormat:@"icon%d_todo.png",i+1];
            UIImage *iconImage = [UIImage imageNamed:iconName];
            
            [iconArray addObject:iconImage];
        }
    }
    
    UIImage *icon = [[UIImage alloc] init];
    icon = iconArray[stampArrNum];
    iconButton = [[UIButton alloc]init];
    [iconButton setImage:icon forState:UIControlStateNormal];
    [iconButton addTarget:self action:@selector(buttonPushed) forControlEvents:UIControlEventTouchUpInside];
    
    if(screenHeight == SCREEN_HEIGHT_4){
        iconButton.frame = CGRectMake(132, 105, 55, 55);
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        iconButton.frame = CGRectMake(127, 145, 70, 70);
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        iconButton.frame = CGRectMake(318, 218, 120, 120);
    }
    
    [self.view addSubview:iconButton];
    
    self.screenName = @"SettingScreen";
}


#pragma mark - 設定

-(void)buttonPushed{
    StampViewController *stampVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stamp"];
    
    [self presentViewController:stampVC animated:YES completion:nil];
    NSLog(@"画面遷移");
    [iconButton removeFromSuperview];
}


/* --- やるべきことの入力 --- */
- (IBAction)doText{
    
    textField.adjustsFontSizeToFitWidth = NO;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    naiyo = textField.text;
}


- (BOOL)textField:(UITextField *)lenTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    // 入力済みのテキストを取得
    NSMutableString *mText = [lenTextField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [mText replaceCharactersInRange:range withString:string];
    
    
    if(screenHeight == SCREEN_HEIGHT_4){
        int maxInputLength = 52;
        
        if ([mText length] > maxInputLength) {
            
            /*--- 文字数制限アラート ---*/
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"文字数オーバー"
                                                          message:@"52字まで入力できます。"
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil
                                 ];
            [alert show];
            
            return NO;
        }
    }else if(screenHeight == SCREEN_HEIGHT_5){
        int maxInputLength = 35;
        
        if ([mText length] > maxInputLength) {
            
            /*--- 文字数制限アラート ---*/
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"文字数オーバー"
                                                          message:@"35字まで入力できます。"
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil
                                 
                                 ];
            [alert show];
            
            return NO;
        }
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        int maxInputLength = 75;
        
        if ([mText length] > maxInputLength) {
            
            /*--- 文字数制限アラート ---*/
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"文字数オーバー"
                                                          message:@"75字まで入力できます。"
                                                         delegate:nil
                                                cancelButtonTitle:nil
                                                otherButtonTitles:@"OK", nil
                                 ];
            [alert show];
            
            return NO;
        }
    }
    return YES;
}


#pragma mark - タッチ
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //キーボードを閉じる
    [textField resignFirstResponder];
}

#pragma mark - 切り替え
- (IBAction)SegChanged:(UISegmentedControl *)sender
{
    if(sender.tag == 1) kigenNum = (int)sender.selectedSegmentIndex; //tag1のSegmentedControlが選択されたら、選択された値をkigenNumに入れる
    else juyouNum = (int)sender.selectedSegmentIndex;
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
    
    GraphViewController *prevController = [self.navigationController.viewControllers objectAtIndex:0];
    [prevController.contentsView removeFromSuperview];
    prevController.contentsView = nil;
    
    /* -- 戻る -- */
    [self dismissViewControllerAnimated:YES completion:nil];
}


/* -- 戻る -- */
-(IBAction)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
