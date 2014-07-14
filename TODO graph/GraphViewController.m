//
//  GraphViewController.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/10/07.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import "GraphViewController.h"

@implementation GraphViewController
//@synthesize mainView;

#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    plusButton.enabled = YES;
    todoFade = YES;
    
    [plusButton.layer setShadowOpacity:0.2f];
    [plusButton.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
    [gomi.layer setShadowOpacity:0.2f];
    [gomi.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewWillAppear

- (void)viewWillAppear:(BOOL)animated{ //画面が表示される都度呼び出される
    ud = [NSUserDefaults standardUserDefaults];  //UserDefaultsのデータ領域の一部をudとおく
    gomibako = [UIImage imageNamed:@"trash.png"];
    gomi = [[UIImageView alloc] initWithImage:gomibako];
    isUnder = NO;//あんべ(5/18)
    
    NSString *model = [UIDevice currentDevice].model;
    
    if ([model isEqualToString:@"iPhone"])
    {
        NSLog(@"iPhoneである");
        gomi.frame = CGRectMake(55,490,62,62);
        [self.view addSubview:gomi];
    }
    
    //iPod touchの場合
    else if ([model isEqualToString:@"iPod touch"]){
        gomi.frame = CGRectMake(58, 418, 53, 53);
        [self.view addSubview:gomi];
        
    }
    //iPadの場合
    else if ([model isEqualToString:@"iPad"]) {
        gomi.frame = CGRectMake(150, 872, 120, 120);
        [self.view addSubview:gomi];
    }else{
        NSLog(@"シュミレーター");
    }
    
    
    //一回mainViewを全部消す
    [mainView removeFromSuperview];
    mainView = [self createView];//-------------スタンプの描画呼び出し(ゴミがなくなったmainViewを新たに作り直す)
    
    [self.view addSubview:mainView];
    [self.view bringSubviewToFront:plusButton];
    
    [self.view bringSubviewToFront:stampButton];
    
}


#pragma mark - ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    
}



- (UIView *)createView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //画面の宣言
    
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    NSLog(@"わんわんわん%@", array);
    
    SetteiViewController *svc = [[self storyboard] instantiateViewControllerWithIdentifier:@"settei"];
    NSUserDefaults *stampUd = [NSUserDefaults standardUserDefaults];
    svc.stampNum = [stampUd integerForKey:@"stamp"];
    
    NSString *model = [UIDevice currentDevice].model;
    
    
    for(i = 0; i < [array count]; i++)
    {
        stampButton = [[UIButton alloc] init];
        
        if ([model isEqualToString:@"iPhone"])
        {
            stampButton.frame = CGRectMake(0, 0, 45, 45);
        } else if ([model isEqualToString:@"iPod touch"]){
            stampButton.frame = CGRectMake(0, 0, 42, 42);
        }else if ([model isEqualToString:@"iPad"]) {
            stampButton.frame = CGRectMake(0, 0, 85, 85);
        }
        
        stampButton.tag = i;
        
        //NSLog(@"tag%d",(int)stampButton.tag);
        
        stampButton.userInteractionEnabled = YES; //タッチの検知をするかしないかの設定
        
        // TODO:arrayには座標の情報が入っているのに、dicには座標の情報が入っていない！！！わんわん！
        NSDictionary *dic = array[i];
        
        NSLog(@"dic is %@", dic);
        
        NSString *GVstStampNum = [dic objectForKey:@"stamp"];
        kigenNum = [[dic objectForKey:@"kigen"] intValue]; //０だったら近い
        juyouNum = [[dic objectForKey:@"juyou"] intValue]; //０だったら重要
        
        int xpoint =[[dic objectForKey:@"x"] floatValue];
        int ypoint =[[dic objectForKey:@"y"] floatValue];
        
        /* --- スタンプの条件分け ---*/
        if([GVstStampNum intValue] == 0) [stampButton setImage:[UIImage imageNamed:@"icon01.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 1) [stampButton setImage:[UIImage imageNamed:@"icon02.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 2) [stampButton setImage:[UIImage imageNamed:@"icon03.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 3) [stampButton setImage:[UIImage imageNamed:@"icon04.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 4) [stampButton setImage:[UIImage imageNamed:@"icon05.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 5) [stampButton setImage:[UIImage imageNamed:@"icon06.png"] forState:UIControlStateNormal];
        
        [stampButton addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        //stampButtonが押されたらbuttonPushedが呼び出される
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]; //ドラッグを検知してpanActionを呼び出す
        [stampButton addGestureRecognizer:pan]; //stampViewにpanを設定する
        
        
        //iPhoneの場合
        if ([model isEqualToString:@"iPhone"])
        {
            
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
        
        //iPod touchの場合
        else if ([model isEqualToString:@"iPod touch"]) {
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
        
        //iPadの場合
        else if ([model isEqualToString:@"iPad"]) {
            
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
            
        }
        
        
        
    }
    [self.view bringSubviewToFront:stampButton];
    
    
    return view;
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // キーボードを閉じる
    [textView resignFirstResponder];
}



#pragma mark - スタンプの選択(移動)
/* -- ここで画面遷移 --- */

- (void)buttonPushed:(UIButton *)button //buttonとstampButtonは同じって考えていい
{
    NSLog(@"%d番目に作られたやつ",(int)button.tag);
    
    /* --- ボタン内の画像を調べる --- */
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"];
    NSDictionary *dic = array[button.tag];
    NSLog(@"%@",dic[@"contents"]);
    plusButton.enabled = NO;

    NSString *model = [UIDevice currentDevice].model;
    
    
    NSDictionary *resaveDic = array[button.tag];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    textView.text = [ud stringForKey:@"contents"];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    resaveMArray = [[NSMutableArray alloc] init];
    
    
    if(_noteView) {
        
        //labelの中身を書き換える
        if ([model isEqualToString:@"iPhone"]){
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }else if ([model isEqualToString:@"iPod touch"]) {
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }else if ([model isEqualToString:@"iPad"]) {
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
        
        if ([model isEqualToString:@"iPhone"])        {
            cancelButton.frame = CGRectMake(225, 225, 45, 45);
        }else if ([model isEqualToString:@"iPod touch"]) {
            cancelButton.frame = CGRectMake(219, 222, 45, 45);
        }else if ([model isEqualToString:@"iPad"]) {
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
        if ([model isEqualToString:@"iPhone"])
        {
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,110,170,145)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            
        }else if ([model isEqualToString:@"iPod touch"]) {
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,120,180,135)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }else if ([model isEqualToString:@"iPad"]) {
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
        if ([model isEqualToString:@"iPhone"])
        {
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        } else if ([model isEqualToString:@"iPod touch"]) {
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        }else if ([model isEqualToString:@"iPad"]) {
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 140, 140)];
        }
        
        todoStamp.image = button.currentImage;
        [_noteView addSubview:todoStamp];
        
        
        [self noteImageFadeIn];
        
        todoFade = !todoFade;
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
    
    plusButton.enabled = YES;
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

- (void)saveEdit:(int)editIndex
{
    ud = [NSUserDefaults standardUserDefaults];
    
    array = [ud objectForKey:@"hoge"];
    NSDictionary *resaveDic = array[editIndex];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    //    resaveMArray = [[NSMutableArray alloc] init];
    
    if(textView.text) [resaveMDic setObject:textView.text forKey:@"contents"];
    
    resaveMArray[editIndex] = resaveMDic;
    
    [ud setObject:resaveMArray forKey:@"hoge"];
    [ud synchronize];
    
    
    NSLog(@"saveEditIndex------%d",editIndex);
}


#pragma mark - スタンプの移動
- (void)panAction:(UIPanGestureRecognizer *)sender {
    
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    NSLog(@"%d番目のスタンプが動かされたよ",(int)sender.view.tag);
    NSDictionary *dic = array[(int)sender.view.tag];
    NSMutableDictionary *mDic = [dic mutableCopy];
    CGPoint p = [sender translationInView:sender.view];
    
    NSString *model = [UIDevice currentDevice].model;
    
    
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
    
    //plusボタンに重なっていた(もぐっていた)場合(あんべ)
    if([self isUnderPlusButton:movedPoint.x Y:movedPoint.y] ){
        NSLog(@"もぐった！");
        
        //isUnderがnoのとき→座標を記録する
        if(!isUnder){
            isUnder = YES;
            
            NSLog(@"きろく！");
        }
        
        //指を離したときにもぐっていた場合、動かす
        if(sender.state == UIGestureRecognizerStateEnded && isUnder){
            
            //iPhoneの場合
            if ([model isEqualToString:@"iPhone"])
            {
                sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-60);
            }else if ([model isEqualToString:@"iPod touch"])
            {
                    sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-60);
            }else if ([model isEqualToString:@"iPad"])
            {
                    sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-150);
            }
                
                movedPoint = sender.view.center;
                
                NSLog(@"うごいた");
            }
            
        }else{
            isUnder = NO;
            NSLog(@"かぶってない");
            
        }
        //あんべここまで
        
        
        
        /* ---　はじっこから脱出　--- */
        
        //iPhone5
        if ([model isEqualToString:@"iPhone"])
        {
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
            if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y >= 545)
            {
                sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-90);
            }
            movedPoint = sender.view.center;
        }
        
        
        //iPhone4
        else if ([model isEqualToString:@"iPod touch"])
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
                if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y >= 460)
                {
                    sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-80);
                }
                movedPoint = sender.view.center;
            }
            
            
            //iPad
            else if ([model isEqualToString:@"iPad"]) {
                NSLog(@"iPad");
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
                if(sender.state == UIGestureRecognizerStateEnded && movedPoint.y >= 980)
                {
                    sender.view.center = CGPointMake(movedPoint.x, movedPoint.y-210);
                }
                movedPoint = sender.view.center;
            }
            
            
            if(sender.state == UIGestureRecognizerStateEnded)
            {
                [mDic setObject:[NSNumber numberWithFloat:movedPoint.x] forKey:@"x"];
                [mDic setObject:[NSNumber numberWithFloat:movedPoint.y] forKey:@"y"];
                
                NSMutableArray *mArray = [array mutableCopy];
                mArray[sender.view.tag] = mDic;
                
                NSLog(@"-----------------------%@",mArray);
                
                [ud setObject:mArray forKey:@"hoge"];
                [ud synchronize];
                
            }
            
            /*--- ゴミ箱 ---*/
            if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x >= gomi.frame.origin.x && movedPoint.x <= gomi.frame.origin.x + gomi.frame.size.width && movedPoint.y >= gomi.frame.origin.y && movedPoint.y <= gomi.frame.origin.y + gomi.frame.size.height)
            {
                //ゴミ箱と重なっていたら削除！　消えろ！　うら！
                NSMutableArray *mArray = [array mutableCopy];
                NSLog(@"%d",(int)sender.view.tag,[mArray count]);
                [mArray removeObjectAtIndex:sender.view.tag];
                
                // TODO:hogeにmArrayをset(ゴミ箱)
                [ud setObject:mArray forKey:@"hoge"];
                [ud synchronize];
                
                [mainView removeFromSuperview];
                mainView = [self createView];
                [self.view addSubview:mainView];
                [self.view bringSubviewToFront:plusButton];
                
                if(_noteView){
                    [self.view bringSubviewToFront:_noteView];
                }
                return;
            }
            
            
            // ドラッグで移動した距離を初期化する
            [sender setTranslation:CGPointZero inView:self.view];
            [self.view bringSubviewToFront:stampButton];
            
        }
    
        //もぐったかどうかを判定する(あんべ5/18)
        -(BOOL) isUnderPlusButton:(float)x Y:(float)y {
            if((x < plusButton.center.x+50 && x > plusButton.center.x-50 )&& (y > plusButton.center.y-30 && y < plusButton.center.y+30)){
                return true;
            }else{
                return false;
            }
        }
        //あんべここまで
        
        
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
