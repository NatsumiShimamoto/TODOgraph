//
//  GraphViewController.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/10/07.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import "GraphViewController.h"
#import "SetteiViewController.h"
#import "StampViewController.h"

#define APP_ID 824743666

#define SCREEN_HEIGHT_4     460 //iPhone4,4s,iPod Touch第4世代
#define SCREEN_HEIGHT_5     568 //iPhone5,5s,iPhod Touch第5世代
#define SCREEN_HEIGHT_PAD   1024 //iPad

#define STAMP_WIDTH_PHONE   50
#define STAMP_HEIGHT_PHONE  50

#define STAMP_WIDTH_PAD     85
#define STAMP_HEIGHT_PAD    85


@implementation GraphViewController


#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkVersionNotification:) name:@"CheckVersion" object:nil];
    
    [self size];
    
    upRed = YES;
    upBlue = NO;
    showedContentsView = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewWillAppear

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    ud = [NSUserDefaults standardUserDefaults];  //UserDefaultsのデータ領域の一部をudとおく
    
    if(showedContentsView == YES){
        
        //array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
        //stampDic = array[stampButton.tag];
        
        //タッチしたボタンのタグがほしい
        //stampButton.tagにはi(最新のボタンのタグ=個数)が入っちゃってる）
        
        
        GVstStampNum = [ud objectForKey:@"stamp"];
        
        int number = [GVstStampNum intValue] + 1;
        
        
        imageName = [NSString stringWithFormat: @"icon%d.png", number];
        UIImage *iconImage = [UIImage imageNamed:imageName];
        
        [stampButton setImage:iconImage forState:UIControlStateNormal];
        [contentsStamp setImage:iconImage forState:UIControlStateNormal];
        
        [contentsStamp addTarget:self action:@selector(contentsStampPushed) forControlEvents:UIControlEventTouchUpInside];
        
        
        NSLog(@"ボタンのタグ！！！%d",(int)stampButton.tag);
        NSLog(@"GVstStampNum = %d",[GVstStampNum intValue]);
        NSLog(@"number = %d",number);
        
    }else{
        
        //一回mainViewを全部消す
        [mainView removeFromSuperview];
        mainView = [self createView];//スタンプの描画呼び出し(ゴミがなくなったmainViewを新たに作り直す)
        
        [self.view addSubview:mainView];
        [self.view bringSubviewToFront:plusButton];
        [self.view bringSubviewToFront:stampButton];
    }
    self.screenName = @"GraphViewController";
}


#pragma mark - ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
}


- (UIView *)createView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //画面の宣言
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    
    for(i = 0; i < [array count]; i++)
    {
        stampButton = [[UIButton alloc] init];
        
        if(screenHeight == SCREEN_HEIGHT_4){
            stampButton.frame = CGRectMake(0, 0, STAMP_WIDTH_PHONE, STAMP_HEIGHT_PHONE);
            
        }else if(screenHeight == SCREEN_HEIGHT_5){
            stampButton.frame = CGRectMake(0, 0, STAMP_WIDTH_PHONE, STAMP_HEIGHT_PHONE);
            
        }else if(screenHeight == SCREEN_HEIGHT_PAD){
            stampButton.frame = CGRectMake(0, 0, STAMP_WIDTH_PAD, STAMP_HEIGHT_PAD);
        }
        
        stampDic = array[i];
        
        GVstStampNum = [stampDic objectForKey:@"stamp"];
        
        kigenNum = [[stampDic objectForKey:@"kigen"] intValue]; //０だったら近い
        juyouNum = [[stampDic objectForKey:@"juyou"] intValue]; //０だったら重要
        
        int xpoint =[[stampDic objectForKey:@"x"] floatValue];
        int ypoint =[[stampDic objectForKey:@"y"] floatValue];
        
        
        /* --- スタンプの条件分け ---*/
        int number = [GVstStampNum intValue] + 1;
        imageName = [NSString stringWithFormat: @"icon%d.png", number];
        [stampButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        //stampButtonが押されたらbuttonPushedが呼び出される
        [stampButton addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]; //ドラッグを検知してpanActionを呼び出す
        [stampButton addGestureRecognizer:pan]; //stampViewにpanを設定する
        
        
        if(screenHeight == SCREEN_HEIGHT_4){
            
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
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,STAMP_WIDTH_PHONE, STAMP_HEIGHT_PHONE);
                
            }else{
                stampButton.center = CGPointMake(xpoint, ypoint);
            }
            
            [view addSubview:stampButton];
            
            
        }else if(screenHeight == SCREEN_HEIGHT_5){
            
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
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,STAMP_WIDTH_PHONE,STAMP_HEIGHT_PHONE);
                
            }else{
                stampButton.center = CGPointMake(xpoint, ypoint);
            }
            
            [view addSubview:stampButton];
            
            
        }else if(screenHeight == SCREEN_HEIGHT_PAD){
            
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
                stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,STAMP_WIDTH_PAD,STAMP_HEIGHT_PAD);
                
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
}

-(void)contentsStampPushed{
    StampViewController *stampVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stamp"];
    
    [self presentViewController:stampVC animated:YES completion:nil];
    showedContentsView = YES;
    
    NSLog(@"GVstStampNum nil = %@",GVstStampNum);
    
    NSLog(@"スタンプ画面遷移");
    
}

-(void)changeStamp:(UIButton *)button{
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"];
    
    NSDictionary *resaveDic = array[button.tag];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    resaveMArray = [[NSMutableArray alloc] init];
    
    
    //labelの中身を書き換える
    if(screenHeight == SCREEN_HEIGHT_4){
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:23]];
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:50]];
    }
    
    
    if(!resaveMArray){
        textView.text = resaveDic[@"contents"];
    }else{
        textView.text = resaveMDic[@"contents"];
    }
    
    textView.delegate = self;
    [textView setScrollEnabled:NO];
    
    //stamp画像を書き換える
    [contentsStamp setImage:button.currentImage forState:UIControlStateNormal];
    [contentsStamp addTarget:self action:@selector(contentsStampPushed) forControlEvents:UIControlEventTouchUpInside];
    //closeButton.tag = button.tag;
}


#pragma mark - スタンプの選択
- (void)buttonPushed:(UIButton *)button //buttonとstampButtonは同じって考えていい
{
    if(_contentsView) {
        [self changeStamp:(UIButton *)button];
        
    }else{
        [self makeContentsView:(UIButton *)button];
    }
    
    [self.view bringSubviewToFront:stampButton];
}


#pragma mark - ContentsView作成
-(void)makeContentsView:(UIButton *)button{
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"];
    NSDictionary *dic = array[button.tag];
    
    NSLog(@"%@",dic[@"contents"]);
    
    NSDictionary *resaveDic = array[button.tag];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    textView.text = [ud stringForKey:@"contents"];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    resaveMArray = [[NSMutableArray alloc] init];
    
    //contentsViewの初期化
    _contentsView = [[ContentsView alloc] init];
    [self.view addSubview:_contentsView];
    
    
    //closeボタンを表示
    UIImage *close = [UIImage imageNamed:@"closeView.png"];
    closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:close forState:UIControlStateNormal];
    
    if(screenHeight == SCREEN_HEIGHT_4){
        closeButton.frame = CGRectMake(211, 0, 60, 60);
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        closeButton.frame = CGRectMake(211, 0, 70, 70);
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        closeButton.frame = CGRectMake(481, 0, 120, 120);
    }
    closeButton.tag = button.tag;
    
    NSLog(@"ボタンのタグ！！！%d",(int)button.tag);
    
    
    [_contentsView addSubview:closeButton];
    
    [closeButton addTarget:self action:@selector(closeButtonPushed:)forControlEvents:UIControlEventTouchUpInside];
    _contentsView.userInteractionEnabled = YES; //タッチの検知をする
    
    
    //labelを表示する部分
    if(screenHeight == SCREEN_HEIGHT_4){
        textView = [[UITextView alloc] initWithFrame:CGRectMake(45,115,180,135)];
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        textView = [[UITextView alloc] initWithFrame:CGRectMake(60,117,170,145)];
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:22]];
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        textView = [[UITextView alloc] initWithFrame:CGRectMake(100,250,400,550)];
        [textView setFont:[UIFont fontWithName:@"azuki_font" size:50]];
    }
    
    if(!resaveMArray){
        textView.text = dic[@"contents"];
    }else{
        textView.text = resaveMDic[@"contents"];
    }
    
    textView.delegate = self;
    [textView setScrollEnabled:NO];
    textView.backgroundColor = [UIColor clearColor];
    
    [_contentsView addSubview:textView];
    [self.view bringSubviewToFront:textView];
    
    
    //contentsViewの上にstampの画像を表示
    contentsStamp = [[UIButton alloc] init];
    if(screenHeight == SCREEN_HEIGHT_4){
        contentsStamp.frame = CGRectMake(110, 30, 50, 50);
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        contentsStamp.frame = CGRectMake(115, 33, 50, 50);
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        contentsStamp.frame = CGRectMake(245, 70, 110, 110);
    }
    
    [contentsStamp setImage:button.currentImage forState:UIControlStateNormal];
    [contentsStamp addTarget:self action:@selector(contentsStampPushed) forControlEvents:UIControlEventTouchUpInside];
    [_contentsView addSubview:contentsStamp];
    
    [self closeImageFadeIn];
}


-(void)closeButtonPushed:(UIButton *)sender
{
    [self saveEdit:(int)sender.tag];
    [self closeImageFadeOut];
    [_contentsView removeFromSuperview];
    _contentsView = nil;
    textView = nil;
}


- (BOOL)textView:(UITextView *)lenTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    // 入力済みのテキストを取得
    NSMutableString *mText = [lenTextView.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [mText replaceCharactersInRange:range withString:text];
    
    int maxInputLength;
    
    if(screenHeight == SCREEN_HEIGHT_4){
        
        maxInputLength = 52;
        
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
        
        maxInputLength = 35;
        
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
        
        maxInputLength = 75;
        
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
    
}


#pragma mark - スタンプの移動
- (void)panAction:(UIPanGestureRecognizer *)sender {
    
    [self functionViewAnimation];
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    NSLog(@"%d番目のスタンプが動かされたよ",(int)sender.view.tag);
    
    [self escape:(UIPanGestureRecognizer *)sender];
    
    
    //指を離した時
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self dragEnded:(UIPanGestureRecognizer *)sender];
    }
    // ドラッグで移動した距離を初期化する
    [sender setTranslation:CGPointZero inView:self.view];
    [self.view bringSubviewToFront:stampButton];
}


//指を離した時
-(void)dragEnded:(UIPanGestureRecognizer *)sender{
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    NSLog(@"%d番目のスタンプが動かされたよ",(int)sender.view.tag);
    NSDictionary *dic = array[(int)sender.view.tag];
    NSMutableDictionary *mDic = [dic mutableCopy];
    CGPoint p = [sender translationInView:sender.view];
    
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
    
    [mDic setObject:[NSNumber numberWithFloat:movedPoint.x] forKey:@"x"];
    [mDic setObject:[NSNumber numberWithFloat:movedPoint.y] forKey:@"y"];
    
    NSMutableArray *mArray = [array mutableCopy];
    mArray[sender.view.tag] = mDic;
    
    [ud setObject:mArray forKey:@"hoge"];
    [ud synchronize];
    
    
    
    if(upBlue){
        
        /* --- 削除 --- */
        if(movedPoint.y >= screenHeight - trashView.frame.size.height)
        {
            //ゴミ箱と重なっていたら削除！消えろ！うら！
            NSMutableArray *mArray = [array mutableCopy];
            [mArray removeObjectAtIndex:sender.view.tag];
            
            [ud setObject:mArray forKey:@"hoge"];
            [ud synchronize];
            
            [mainView removeFromSuperview];
            mainView = [self createView];
            [self.view addSubview:mainView];
            [self.view bringSubviewToFront:plusButton];
            
            if(_contentsView){
                [self.view bringSubviewToFront:_contentsView];
            }
            
            [UIView animateWithDuration:0.4f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 // アニメーションをする処理
                                 plusButton.transform = CGAffineTransformMakeTranslation(0, 0);
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
                             if(screenHeight == SCREEN_HEIGHT_4){
                                 trashView.transform = CGAffineTransformMakeTranslation(0, 60);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_5){
                                 trashView.transform = CGAffineTransformMakeTranslation(0, 65);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_PAD){
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
                             plusButton.transform = CGAffineTransformMakeTranslation(0, 0);
                         }
                         completion:^(BOOL finished){
                             // アニメーションが終わった後実行する処理
                             upRed = YES;
                         }];
        
        NSLog(@"赤でてくる");
    }
}


/* ---　はじっこから脱出　--- */
-(void)escape:(UIPanGestureRecognizer *)sender {
    
    CGPoint p = [sender translationInView:sender.view];
    
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
    
    
    if(screenHeight == SCREEN_HEIGHT_4){
        
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
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        
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
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        
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
    
    
}


//プラスボタン、ゴミ箱のアニメーション
-(void)functionViewAnimation{
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if(!upBlue){
        
        [UIView animateWithDuration:0.4f
                              delay:0.1f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             // アニメーションをする処理
                             
                             if(screenHeight == SCREEN_HEIGHT_4){
                                 trashView.transform = CGAffineTransformMakeTranslation(0, -60);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_5){
                                 trashView.transform = CGAffineTransformMakeTranslation(0, -65);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_PAD){
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
                             
                             if(screenHeight == SCREEN_HEIGHT_4){
                                 plusButton.transform = CGAffineTransformMakeTranslation(0, 60);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_5){
                                 plusButton.transform = CGAffineTransformMakeTranslation(0, 65);
                                 
                             }else if(screenHeight == SCREEN_HEIGHT_PAD){
                                 plusButton.transform = CGAffineTransformMakeTranslation(0, 130);
                             }
                         }
                         completion:^(BOOL finished){
                             // アニメーションが終わった後実行する処理
                             upRed = NO;
                         }];
        
        NSLog(@"赤消える");
    }
}


#pragma mark - 追加
-(void)plus{
    showedContentsView = NO;
    SetteiViewController *setteiVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settei"];
    [self presentViewController:setteiVC animated:YES completion:nil];
    
    NSLog(@"設定画面遷移");
    
    [_contentsView removeFromSuperview];
    _contentsView = nil;
}


#pragma mark - ボタンのサイズ
-(void)size{
    
    screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if(screenHeight == SCREEN_HEIGHT_4){
        
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        plusButton.frame = CGRectMake(0, 420, 320, 60);
        [plusButton setImage:[UIImage imageNamed:@"plusView_iPhone.png"] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plus)forControlEvents:UIControlEventTouchUpInside];
        
        
        trash = [UIImage imageNamed:@"trashView_iPhone.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];
        trashView.frame = CGRectMake(0,480,320,60);
        
    }else if(screenHeight == SCREEN_HEIGHT_5){
        
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        plusButton.frame = CGRectMake(0, 503, 320, 65);
        [plusButton setImage:[UIImage imageNamed:@"plusView_iPhone.png"] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plus)forControlEvents:UIControlEventTouchUpInside];
        
        
        trash = [UIImage imageNamed:@"trashView_iPhone.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];
        trashView.frame = CGRectMake(0,568,320,65);
        
    }else if(screenHeight == SCREEN_HEIGHT_PAD){
        
        plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        plusButton.frame = CGRectMake(0, 894, 768, 130);
        [plusButton setImage:[UIImage imageNamed:@"plusView_iPhone.png"] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plus)forControlEvents:UIControlEventTouchUpInside];
        
        
        trash = [UIImage imageNamed:@"trashView_iPad.png"];
        trashView = [[UIImageView alloc] initWithImage:trash];
        trashView.frame = CGRectMake(0,1024,768,130);
    }
    
    [self.view addSubview:plusButton];
    [self.view addSubview:trashView];
}


#pragma mark - ContentsViewのアニメーション
//フェードイン
- (void)closeImageFadeIn{
    
    _contentsView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil]; //アニメーションのタイプを指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //イージング指定
    [UIView setAnimationDuration:0.15]; //アニメーション秒数を指定
    _contentsView.alpha = 1; //目標のアルファ値を指定
    [UIView commitAnimations]; //アニメーション実行
}


//フェードアウト
- (void)closeImageFadeOut
{
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut]; //イージング指定
    [UIView setAnimationDuration:0.3];  //アニメーション秒数を指定
    _contentsView.alpha = 0; //目標のアルファ値を指定
    [UIView commitAnimations]; //アニメーション実行
}



#pragma mark - 強制アップデート
/* --- バージョン判定(ユーザのバージョンが前のバージョンの場合はアラートを表示) --- */
- (void)checkVersionNotification:(NSNotification *)notification{
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d",APP_ID
                     ];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    NSDictionary *dataDic  = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&error];
    
    
    NSDictionary *results = [[dataDic objectForKey:@"results"] objectAtIndex:0];
    NSString *latestVersion = [results objectForKey:@"version"];
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
    if (![currentVersion isEqualToString:latestVersion]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:@"最新バージョンが入手可能です。アップデートしますか？"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"アップデート", nil];
        [alert show];
    }
}



/* --- AlertViewで"アップデート"を選択した際の処理(AppStoreに遷移) --- */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        NSString* urlString;
        
        //iOSのバージョンでAppStoreに遷移するURLスキームの変更
        if( [self isIOS7]){
            //iOS7以上
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",APP_ID
                         ];
        }else{
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%d&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",APP_ID
                         ];
        }
        NSURL* url= [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


/* --- 実行中の環境がiOS7以上かどうかを判定する --- */
- (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    return (iOsVersionMajor <= 7);
}


@end
