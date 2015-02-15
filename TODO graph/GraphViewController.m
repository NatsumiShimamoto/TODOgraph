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


@implementation GraphViewController
//@synthesize mainView;

#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkVersionNotification:) name:@"CheckVersion" object:nil];

    
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
    
        //一回mainViewを全部消す
    [mainView removeFromSuperview];
    mainView = [self createView];//-------------スタンプの描画呼び出し(ゴミがなくなったmainViewを新たに作り直す)
    
    [self.view addSubview:mainView];
    [self.view bringSubviewToFront:plusView];
 
    
    [self.view bringSubviewToFront:stampButton];
    
     self.screenName = @"SettingScreen";
}


#pragma mark - ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    
}



- (UIView *)createView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //画面の宣言
    
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    NSLog(@"わんわんわん%@", array);
    
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
        int number = [GVstStampNum intValue] + 1;
        NSString* imageName = [NSString stringWithFormat: @"icon%d.png", number];
        [stampButton setImage:[UIImage imageNamed: imageName] forState:UIControlStateNormal];
        
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

}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    SetteiViewController *setteiVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settei"];
    StampViewController *stampVC = [self.storyboard instantiateViewControllerWithIdentifier:@"stamp"];
    
    NSLog(@"タッチ");
    NSLog(@"%d",(int)plusView.tag);
    NSLog(@"%d",(int)touch.view.tag);
    
    
    switch (touch.view.tag) {
        case 1:
            
            [self presentViewController:setteiVC animated:YES completion:nil];
            
            NSLog(@"設定画面遷移");
            
            [_contentsView removeFromSuperview];
            _contentsView = nil;
            
            break;
            
        case 2:
            [self presentViewController:stampVC animated:YES completion:nil];
            
            NSLog(@"スタンプ画面遷移");
            
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
    
    
    if(_contentsView) {
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            //labelの中身を書き換える
        }
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:23]];
            
            
            //iPadの場合
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:50]];
        }
        
        
        
        if(!resaveMArray){
            textView.text = dic[@"contents"];
        }else{
            textView.text = resaveMDic[@"contents"];
        }
        
        textView.delegate = self;
        [textView setScrollEnabled:NO];
        
        //stamp画像を書き換える
        contentsStamp.image = button.currentImage;
        
        closeButton.tag = button.tag;
        
        NSLog(@"ボタンのタグ！！！%d",(int)button.tag);
        
    }else {
        
        //contentsViewの初期化
        _contentsView = [[ContentsView alloc] init];
        [self.view addSubview:_contentsView];
        NSLog(@"うわあああああああ");
        
        //closeボタンを表示
        close = [UIImage imageNamed:@"closeView.png"];
        closeView = [[UIImageView alloc] initWithImage:close];
        closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            closeButton.frame = CGRectMake(211, 0, 60, 60);
            
        }else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            closeButton.frame = CGRectMake(211, 0, 70, 70);
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPadの場合
            closeButton.frame = CGRectMake(481, 0, 120, 120);
        }
        
        
        closeButton.tag = button.tag;
        
        NSLog(@"ボタンのタグ！！！%d",(int)button.tag);
        
        [_contentsView addSubview:closeButton];
        [closeButton setImage:close forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeButtonPushed:)forControlEvents:UIControlEventTouchUpInside];
        _contentsView.userInteractionEnabled = YES; //タッチの検知をする
        
        
        //labelを表示する部分
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            textView = [[UITextView alloc] initWithFrame:CGRectMake(45,115,180,135)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }
        else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,117,170,145)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:22]];
            
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPad
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
        
        if([[UIScreen mainScreen] bounds].size.height==480){
            //iPhone4,4s,iPod Touch第4世代
            contentsStamp = [[UIImageView alloc] initWithFrame:CGRectMake(110, 30, 50, 50)];
            
        }else if([[UIScreen mainScreen] bounds].size.height==568){
            //iPhone5,5s,iPhod Touch第5世代
            contentsStamp = [[UIImageView alloc] initWithFrame:CGRectMake(115, 33, 50, 50)];
            
        }else if([[UIScreen mainScreen] bounds].size.height==1024){
            //iPad
            contentsStamp = [[UIImageView alloc] initWithFrame:CGRectMake(245, 70, 110, 110)];
        }
        
        contentsStamp.image = button.currentImage;
        contentsStamp.tag = 2;
        [_contentsView addSubview:contentsStamp];
        
        
        [self closeImageFadeIn];
    }
    
    [self.view bringSubviewToFront:stampButton];
    
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
    // 入力済みのテキストを取得
    NSMutableString *mText = [lenTextView.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [mText replaceCharactersInRange:range withString:text];
    
    
    

    if([[UIScreen mainScreen] bounds].size.height==480){
        //iPhone4,4s,iPod Touch第4世代
        
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

    }
    else if([[UIScreen mainScreen] bounds].size.height==568){
        //iPhone5,5s,iPhod Touch第5世代
        
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

        
    }else if([[UIScreen mainScreen] bounds].size.height==1024){
        //iPad
        
        
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
                
                if(_contentsView){
                    [self.view bringSubviewToFront:_contentsView];
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



/**
 * バージョン判定
 * ユーザのバージョンが前のバージョンの場合はアラートを表示
 */
- (void)checkVersionNotification:(NSNotification *)notification{
    NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%d",824743666
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


/**
 * AlertViewで"アップデート"を選択した際の処理
 * AppStoreに遷移
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        NSString* urlString;
        
        //iOSのバージョンでAppStoreに遷移するURLスキームの変更
        if( [self isIOS7]){
            //iOS7以上
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%d",824743666
];
        }else{
            urlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%d&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",824743666
];
        }
        
        NSURL* url= [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
    }
}


/**
 *  実行中の環境がiOS7以上かどうかを判定する
 *  ios7以上ならTRUEを返す
 */
- (BOOL)isIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    return (iOsVersionMajor <= 7);
}


@end
