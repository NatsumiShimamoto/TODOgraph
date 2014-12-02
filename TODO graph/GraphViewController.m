//
//  GraphViewController.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/10/07.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import "GraphViewController.h"
#import "SetteiViewController.h"

@implementation GraphViewController
//@synthesize mainView;

#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 全画面のサイズを取得する
    height = [[UIScreen mainScreen] bounds].size.height;
    NSLog(@"%d",height);
    
    if([[UIScreen mainScreen] bounds].size.height==480){ //iPhone4,4s,iPod Touch第4世代
        //プラスボタン生成
        plus = [UIImage imageNamed:@"plusView_iPhone.png"];
        plusView = [[UIImageView alloc] initWithImage:plus];
        
        //ゴミ箱生成
        trash = [UIImage imageNamed:@"trashView_iPhone.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];

    }else if([[UIScreen mainScreen] bounds].size.height==568){ //iPhone5,5s,iPod Touch第5世代
        //プラスボタン生成
        plus = [UIImage imageNamed:@"plusView_iPhone.png"];
        plusView = [[UIImageView alloc] initWithImage:plus];
        
        //ゴミ箱生成
        trash = [UIImage imageNamed:@"trashView_iPhone.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];

    }else if([[UIScreen mainScreen] bounds].size.height==1024){ //iPad
        //プラスボタン生成
        plus = [UIImage imageNamed:@"plusView_iPad.png"];
        plusView = [[UIImageView alloc] initWithImage:plus];
        
        //ゴミ箱生成
        trash = [UIImage imageNamed:@"trashView_iPad.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];
        
    }
    
    
    
    if([[UIScreen mainScreen] bounds].size.height==480){ //iPhone4,4s,iPod Touch第4世代
        
        plusView.frame = CGRectMake(0, 420, 320, 60);
        trashView.frame = CGRectMake(0,480,320,60);
        
    }else if([[UIScreen mainScreen] bounds].size.height==568){ //iPhone5,5s,iPod Touch第5世代
        
        plusView.frame = CGRectMake(0, 503, 320, 65);
        trashView.frame = CGRectMake(0,568,320,65);
        
    }else if([[UIScreen mainScreen] bounds].size.height==1024){ //iPad
        
        plusView.frame = CGRectMake(0, 894, 768, 130);
        trashView.frame = CGRectMake(0,1024,768,130);
    }
    
    
    [self.view addSubview:plusView];
    [self.view addSubview:trashView];
    
    plusView.userInteractionEnabled = YES;
    plusView.tag = 1;
    
    upRed = YES;
    upBlue = NO;
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewWillAppear

- (void)viewWillAppear:(BOOL)animated{ //画面が表示される都度呼び出される
    [super viewWillAppear:animated];
    
    ud = [NSUserDefaults standardUserDefaults];  //UserDefaultsのデータ領域の一部をudとおく
    
    isUnder = NO;
    
    NSLog(@"%f",[[UIScreen mainScreen] bounds].size.height);
    
    
    
    /*
     if([[UIScreen mainScreen] bounds].size.height==480){
     //iPhone4,4s,iPod Touch第4世代
     gomi.frame = CGRectMake(60,420,48,48);
     // plusButton.frame = CGRectMake(plusButton.frame.origin.x, 425, 40, 25);
     [self.view addSubview:gomi];
     
     }else if([[UIScreen mainScreen] bounds].size.height==568){
     //iPhone5,5s,iPod Touch第5世代
     NSLog(@"あいふぉん");
     gomi.frame = CGRectMake(55,491,62,62);
     [self.view addSubview:gomi];
     
     }else if([[UIScreen mainScreen] bounds].size.height==1024){
     NSLog(@"iPad");
     //iPad
     gomi.frame = CGRectMake(145,875,120,120);
     [self.view addSubview:gomi];
     }
     */
    
    
    //一回mainViewを全部消す
    [mainView removeFromSuperview];
    mainView = [self createView];//-------------スタンプの描画呼び出し(ゴミがなくなったmainViewを新たに作り直す)
    
    [self.view addSubview:mainView];
    [self.view bringSubviewToFront:plusView];
 
    
    [self.view bringSubviewToFront:stampButton];
    
    
}


#pragma mark - ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    
}



- (UIView *)createView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //画面の宣言
    
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    NSLog(@"わんわんわん%@", array);
    
    /*SetteiViewController *svc = [[self storyboard] instantiateViewControllerWithIdentifier:@"settei"];
    NSUserDefaults *stampUd = [NSUserDefaults standardUserDefaults];
    svc.stampArrNum = [stampUd integerForKey:@"stamp"];
    */
    
    for(i = 0; i < [array count]; i++)
    {
        stampButton = [[UIButton alloc] init];
        
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            stampButton.frame = CGRectMake(0, 0, 42, 42);
        }else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            stampButton.frame = CGRectMake(0, 0, 45, 45);
            
        }else if([[UIScreen mainScreen] bounds].size.height==1024)
            //iPad
        {
            stampButton.frame = CGRectMake(0, 0, 85, 85);
        }
        
        
        stampButton.tag = i;
        
        stampButton.userInteractionEnabled = YES; //タッチの検知をするかしないかの設定
        
        NSDictionary *dic = array[i];
        NSLog(@"dic is %@", dic);
        
        NSString *GVstStampNum = [dic objectForKey:@"stamp"];
        kigenNum = [[dic objectForKey:@"kigen"] intValue]; //０だったら近い
        juyouNum = [[dic objectForKey:@"juyou"] intValue]; //０だったら重要
        
        int xpoint =[[dic objectForKey:@"x"] floatValue];
        int ypoint =[[dic objectForKey:@"y"] floatValue];
        
        /* --- スタンプの条件分け ---*/
        if([GVstStampNum intValue] == 0) [stampButton setImage:[UIImage imageNamed:@"icon1.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 1) [stampButton setImage:[UIImage imageNamed:@"icon2.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 2) [stampButton setImage:[UIImage imageNamed:@"icon3.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 3) [stampButton setImage:[UIImage imageNamed:@"icon4.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 4) [stampButton setImage:[UIImage imageNamed:@"icon5.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 5) [stampButton setImage:[UIImage imageNamed:@"icon6.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 6) [stampButton setImage:[UIImage imageNamed:@"icon7.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 7) [stampButton setImage:[UIImage imageNamed:@"icon8.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 8) [stampButton setImage:[UIImage imageNamed:@"icon9.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 9) [stampButton setImage:[UIImage imageNamed:@"icon10.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 10) [stampButton setImage:[UIImage imageNamed:@"icon11.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 11) [stampButton setImage:[UIImage imageNamed:@"icon12.png"] forState:UIControlStateNormal];
        
        
        
        
        [stampButton addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        //stampButtonが押されたらbuttonPushedが呼び出される
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]; //ドラッグを検知してpanActionを呼び出す
        [stampButton addGestureRecognizer:pan]; //stampViewにpanを設定する
        
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            w = 45;
            h = 60;
            
            
            int ww,hh;
            if (kigenNum<=2) {
                hh=55;
            }else{
                hh=45;
            }
            
            if (juyouNum<=2) {
                ww=18;
            }else{
                ww=31;
            }
            
            if(xpoint==0&&ypoint==0){
                
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,42, 42);
                
            }else{
                stampButton.center = CGPointMake(xpoint, ypoint);
            }
            
            
            [view addSubview:stampButton];
            
            
        }
        
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            
            
            w = 45;
            h = 70;
            
            
            int ww,hh;
            
            if (kigenNum<=2) {
                hh=62;
            }else{
                hh=52;
            }
            if (juyouNum<=2) {
                ww=18;
            }else{
                ww=32;
            }
            
            if(xpoint==0&&ypoint==0){
                
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,45, 45);
                
            }else{
                stampButton.center = CGPointMake(xpoint, ypoint);
            }
            
            [view addSubview:stampButton];
            
            
        }
        
        
        //iPadの場合
        else if([[UIScreen mainScreen] bounds].size.height==1024){
            
            w = 108;
            h = 140;
            
            
            int ww,hh;
            if (kigenNum<=2) {
                hh=42;
            }else{
                hh=70;
            }
            if (juyouNum<=2) {
                ww=54;
            }else{
                ww=86;
            }
            
            
            if(xpoint==0&&ypoint==0){
                
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,85, 85);
                
            }else{
                stampButton.center = CGPointMake(xpoint, ypoint);
            }
            
            
            [view addSubview:stampButton];
            [self.view bringSubviewToFront:stampButton];
            
        }
        
    }
    return view;
}


#pragma mark - タッチ
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //キーボードを閉じる
    [textView resignFirstResponder];
    
    
    UITouch *touch = [touches anyObject];
    SetteiViewController *setteiVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settei"];
    
    NSLog(@"タッチ");
    NSLog(@"%d",(int)plusView.tag);
    NSLog(@"%d",(int)touch.view.tag);
    
    
    switch (touch.view.tag) {
        case 1:
            
            [self presentViewController:setteiVC animated:YES completion:nil];
            
            NSLog(@"画面遷移");
            
            [_noteView removeFromSuperview];
            _noteView = nil;
            
            break;
            
        default:
            NSLog(@"mainView");
            break;
    }
}



#pragma mark - スタンプの選択(移動)
- (void)buttonPushed:(UIButton *)button //buttonとstampButtonは同じって考えていい
{
    NSLog(@"%d番目に作られたやつ",(int)button.tag);
    
    /* --- ボタン内の画像を調べる --- */
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"];
    NSDictionary *dic = array[button.tag];
    NSLog(@"%@",dic[@"contents"]);
    
    
    NSDictionary *resaveDic = array[button.tag];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    textView.text = [ud stringForKey:@"contents"];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    resaveMArray = [[NSMutableArray alloc] init];
    
    
    if(_noteView) {
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            //labelの中身を書き換える
        }
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            
            
            //iPadの場合
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:60]];
        }
        
        
        
        if(!resaveMArray){
            textView.text = dic[@"contents"];
        }else{
            textView.text = resaveMDic[@"contents"];
        }
        
        textView.delegate = self;
        [textView setScrollEnabled:NO];
        
        //stamp画像を書き換える
        todoStamp.image = button.currentImage;
        
        cancelButton.tag = button.tag;
        NSLog(@"キャンセルボタンのタグ！！！%d",(int)cancelButton.tag);
        NSLog(@"ボタンのタグ！！！%d",(int)button.tag);
        
    }else {
        
        //NoteViewの初期化
        _noteView = [[NoteView alloc] init];
        [self.view addSubview:_noteView];
        NSLog(@"うわあああああああ");
        
        //キャンセルボタンを表示
        batsu = [UIImage imageNamed:@"batsu.png"];
        batsuView = [[UIImageView alloc] initWithImage:batsu];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            cancelButton.frame = CGRectMake(219, 222, 45, 45);
            
        }else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            cancelButton.frame = CGRectMake(225, 225, 45, 45);
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPadの場合
            cancelButton.frame = CGRectMake(485, 490, 90, 90);
        }
        
        
        cancelButton.tag = button.tag;
        NSLog(@"キャンセルボタンのタグ！！！%d",(int)cancelButton.tag);
        NSLog(@"ボタンのタグ！！！%d",(int)button.tag);
        
        [_noteView addSubview:cancelButton];
        [cancelButton setImage:batsu forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonPushed:)forControlEvents:UIControlEventTouchUpInside];
        _noteView.userInteractionEnabled = YES; //タッチの検知をする
        
        
        //labelを表示する部分
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,120,180,135)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,110,170,145)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPad
            textView = [[UITextView alloc] initWithFrame:CGRectMake(125,255,400,250)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:60]];
        }
        
        if(!resaveMArray){
            textView.text = dic[@"contents"];
        }else{
            textView.text = resaveMDic[@"contents"];
        }
        
        textView.delegate = self;
        [textView setScrollEnabled:NO];
        textView.backgroundColor = [UIColor clearColor];
        
        [_noteView addSubview:textView];
        [self.view bringSubviewToFront:textView];
        
        //とどの上にstampの画像を表示
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        }
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPad
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 140, 140)];
        }
        
        todoStamp.image = button.currentImage;
        [_noteView addSubview:todoStamp];
        
        
        [self noteImageFadeIn];
    }
    
    [self.view bringSubviewToFront:stampButton];
    
}


-(void)cancelButtonPushed:(UIButton *)sender
{
    [self saveEdit:(int)sender.tag];
    [self noteImageFadeOut];
    [_noteView removeFromSuperview];
    _noteView = nil;
    textView = nil;
    
}


- (BOOL)textView:(UITextView *)lenTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    int maxInputLength = 30;
    
    // 入力済みのテキストを取得
    NSMutableString *mText = [lenTextView.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [mText replaceCharactersInRange:range withString:text];
    
    if ([mText length] > maxInputLength) {
        
        /*--- 文字数制限アラート ---*/
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



/*
 *  saveEditメソッド
 *  = editIndexを受け取って、スタンプの配列のeditIndex番目のcontentsを更新するメソッド
 *
 */

#pragma mark - 編集保存
- (void)saveEdit:(int)editIndex
{
    ud = [NSUserDefaults standardUserDefaults];
    
    array = [ud objectForKey:@"hoge"];
    NSDictionary *resaveDic = array[editIndex];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    
    if(textView.text) [resaveMDic setObject:textView.text forKey:@"contents"];
    
    resaveMArray[editIndex] = resaveMDic;
    
    [ud setObject:resaveMArray forKey:@"hoge"];
    [ud synchronize];
    
    
    NSLog(@"saveEditIndex------%d",editIndex);
}

-(void)startAnimation{
    
    if(!upBlue){
        
        [UIView animateWithDuration:0.4f
                              delay:0.1f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // アニメーションをする処理
                             
                             if([[UIScreen mainScreen] bounds].size.height==480){
                                 //iPhone4,4s,iPod Touch第4世代
                                 trashView.transform = CGAffineTransformMakeTranslation(0, -60);
                             }else if([[UIScreen mainScreen] bounds].size.height==568){
                                 //iPhone5,5s,iPod Touch第5世代
                                 trashView.transform = CGAffineTransformMakeTranslation(0, -65);
                                 
                             }else if([[UIScreen mainScreen] bounds].size.height==1024){
                                 trashView.transform = CGAffineTransformMakeTranslation(0, -130);
                                 
                             }
                             
                             
                         }
                         completion:^(BOOL finished){
                             // アニメーションが終わった後実行する処理
                             upBlue = YES;
                         }];
        
        
        NSLog(@"青でてくる");
        
        
        
    }
    
    if(upRed){
        [UIView animateWithDuration:0.4f
                              delay:0.1f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // アニメーションをする処理
                             
                             if([[UIScreen mainScreen] bounds].size.height==480){
                                 //iPhone4,4s,iPod Touch第4世代
                                 plusView.transform = CGAffineTransformMakeTranslation(0, 60);
                             }else if([[UIScreen mainScreen] bounds].size.height==568){
                                 //iPhone5,5s,iPod Touch第5世代
                                 plusView.transform = CGAffineTransformMakeTranslation(0, 65);
                                 
                             }else if([[UIScreen mainScreen] bounds].size.height==1024){
                                 plusView.transform = CGAffineTransformMakeTranslation(0, 130);
                                 
                             }
                             
                             
                         }
                         completion:^(BOOL finished){
                             // アニメーションが終わった後実行する処理
                             upRed = NO;
                         }];
        
        NSLog(@"赤消える");
    }
    
}


#pragma mark - スタンプの移動
- (void)panAction:(UIPanGestureRecognizer *)sender {
    
    [self startAnimation];
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    NSLog(@"%d番目のスタンプが動かされたよ",(int)sender.view.tag);
    NSDictionary *dic = array[(int)sender.view.tag];
    NSMutableDictionary *mDic = [dic mutableCopy];
    CGPoint p = [sender translationInView:sender.view];
    
    
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
    
    
    
    /* ---　はじっこから脱出　--- */
    
    if([[UIScreen mainScreen] bounds].size.height==480)
        //iPhone4,4s,iPod Touch第4世代
    {
        NSLog(@"iPhone4");
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x <= 13)
        {
            sender.view.center = CGPointMake(movedPoint.x+30, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x >= 300)
        {
            sender.view.center = CGPointMake(movedPoint.x-30, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y <= 45)
        {
            sender.view.center = CGPointMake(movedPoint.x, movedPoint.y+40);
        }
       
        movedPoint = sender.view.center;
    }
    
    //iPhone5
    else if([[UIScreen mainScreen] bounds].size.height==568){
        //iPhone5,5s,iPhod Touch第5世代
        
        NSLog(@"iPhone5");
        if(movedPoint.x <= 0){
            movedPoint.x = 0;
        }
        
        if(movedPoint.y <= 0){
            movedPoint.y = 0;
        }
        
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x <= 13)
        {
            sender.view.center = CGPointMake(movedPoint.x+25, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x >= 300)
        {
            sender.view.center = CGPointMake(movedPoint.x-30, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y <= 22)
        {
            sender.view.center = CGPointMake(movedPoint.x, movedPoint.y+25);
        }
        
        movedPoint = sender.view.center;
    }
    
    
    
    
    else if([[UIScreen mainScreen] bounds].size.height==1024){
        //iPad
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x <= 20)
        {
            sender.view.center = CGPointMake(movedPoint.x+85, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x >= 750)
        {
            sender.view.center = CGPointMake(movedPoint.x-100, movedPoint.y);
        }
        if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y <= 45)
        {
            sender.view.center = CGPointMake(movedPoint.x, movedPoint.y+80);
        }
        
        movedPoint = sender.view.center;
    }
    
    //指を離した時
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.x] forKey:@"x"];
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.y] forKey:@"y"];
        
        NSMutableArray *mArray = [array mutableCopy];
        mArray[sender.view.tag] = mDic;
        
        
        
        [ud setObject:mArray forKey:@"hoge"];
        [ud synchronize];
        
        
        if(upBlue){
            
            
            height = [[UIScreen mainScreen] bounds].size.height;
            
            /* --- ゴミ箱 --- */
            if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y >= height -
               trashView.frame.size.height)
            {
                NSLog(@"消えろ");
                //ゴミ箱と重なっていたら削除！　消えろ！　うら！
                NSMutableArray *mArray = [array mutableCopy];
                NSLog(@"%d %d",(int)sender.view.tag,(int)[mArray count]);
                [mArray removeObjectAtIndex:sender.view.tag];
                
                [ud setObject:mArray forKey:@"hoge"];
                [ud synchronize];
                
                [mainView removeFromSuperview];
                mainView = [self createView];
                [self.view addSubview:mainView];
                [self.view bringSubviewToFront:plusView];
                
                if(_noteView){
                    [self.view bringSubviewToFront:_noteView];
                }
                
                
                
                
                [UIView animateWithDuration:0.4f
                                      delay:0.1f
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     // アニメーションをする処理
                                     plusView.transform = CGAffineTransformMakeTranslation(0, 0);
                                 }
                                 completion:^(BOOL finished){
                                     // アニメーションが終わった後実行する処理
                                     upRed = YES;
                                 }];
                
                NSLog(@"赤でてくる");
                
            }
            
            
            [UIView animateWithDuration:0.4f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 // アニメーションをする処理
                                 if([[UIScreen mainScreen] bounds].size.height==480){
                                     //iPhone4,4s,iPod Touch第4世代
                                     trashView.transform = CGAffineTransformMakeTranslation(0, 60);
                                 }else if([[UIScreen mainScreen] bounds].size.height==568){
                                     //iPhone5,5s,iPod Touch第5世代
                                     trashView.transform = CGAffineTransformMakeTranslation(0, 65);
                                     
                                 }else if([[UIScreen mainScreen] bounds].size.height==1024){
                                     trashView.transform = CGAffineTransformMakeTranslation(0, 130);
                                     
                                 }
                             }
                             completion:^(BOOL finished){
                                 // アニメーションが終わった後実行する処理
                                 upBlue = NO;
                             }];
            NSLog(@"青消える");
            
        }
        
        if(!upRed){
            
            
            [UIView animateWithDuration:0.4f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 // アニメーションをする処理
                                 plusView.transform = CGAffineTransformMakeTranslation(0, 0);
                             }
                             completion:^(BOOL finished){
                                 // アニメーションが終わった後実行する処理
                                 upRed = YES;
                             }];
            
            NSLog(@"赤でてくる");
            
        }
        
    }
    
    // ドラッグで移動した距離を初期化する
    [sender setTranslation:CGPointZero inView:self.view];
    [self.view bringSubviewToFront:stampButton];
    
}

//もぐったかどうかを判定する
-(BOOL) isUnderPlusButton:(float)x Y:(float)y {
    if((x < plusButton.center.x+50 && x > plusButton.center.x-50 )&& (y > plusButton.center.y-30 && y < plusButton.center.y+30)){
        return true;
    }else{
        return false;
    }
}



//フェードイン
- (void)noteImageFadeIn{
    
    _noteView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil]; //アニメーションのタイプを指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //イージング指定
    [UIView setAnimationDuration:0.15]; //アニメーション秒数を指定
    _noteView.alpha = 1; //目標のアルファ値を指定
    [UIView commitAnimations]; //アニメーション実行
}

//フェードアウト
- (void)noteImageFadeOut
{
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; //イージング指定
    [UIView setAnimationDuration:0.3];  //アニメーション秒数を指定
    _noteView.alpha = 0; //目標のアルファ値を指定
    [UIView commitAnimations]; //アニメーション実行
}

@end
