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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewWillAppear

- (void)viewWillAppear:(BOOL)animated{ //画面が表示される都度呼び出される
    ud = [NSUserDefaults standardUserDefaults];  //UserDefaultsのデータ領域の一部をudとおく
    gomibako = [UIImage imageNamed:@"ゴミ箱.png"];
    gomi = [[UIImageView alloc] initWithImage:gomibako];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if(screenSize.width == 320.0 && screenSize.height == 568.0)
    {
        gomi.frame = CGRectMake(50, 493, 73, 73);
        [self.view addSubview:gomi];
    }
    
    //iPod touchの場合
    else if(screenSize.width == 320.0 && screenSize.height == 480.0)
    {
        gomi.frame = CGRectMake(58, 422, 55, 55);
        [self.view addSubview:gomi];
        
    }
    //iPadの場合
    else {
        gomi.frame = CGRectMake(150, 913, 105, 105);
        [self.view addSubview:gomi];
    }
    
    
    //一回mainViewを全部消す
    [mainView removeFromSuperview];
    mainView = [self createView];//-------------スタンプの描画呼び出し(ゴミがなくなったmainViewを新たに作り直す)
    
    [self.view addSubview:mainView];
    [self.view bringSubviewToFront:plusButton];
}


#pragma mark - ViewDidAppear
- (void)viewDidAppear:(BOOL)animated{
    
}



- (UIView *)createView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)]; //画面の宣言
    
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    SetteiViewController *svc = [[self storyboard] instantiateViewControllerWithIdentifier:@"settei"];
    NSUserDefaults *stampUd = [NSUserDefaults standardUserDefaults];
    svc.stampNum = [stampUd integerForKey:@"stamp"];
    //svc.stampNum = (int)[stampUd intgerForKey:@"stamp"];なら警告は消える
    
    
    
    for(i = 0; i < [array count]; i++)
    {
        stampButton = [[UIButton alloc] init];
        
        stampButton.frame = CGRectMake(0, 0, 35, 35);
        stampButton.tag = i;
        NSLog(@"tag%d",stampButton.tag);
        stampButton.userInteractionEnabled = YES; //タッチの検知をするかしないかの設定
        NSDictionary *dic = array[i];
        
        NSLog(@"dic is %@", dic);
        
        NSString *GVstStampNum = [dic objectForKey:@"stamp"];
        kigenNum = [[dic objectForKey:@"kigen"] intValue]; //０だったら近い
        juyouNum = [[dic objectForKey:@"juyou"] intValue]; //０だったら重要
        
        
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
        
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        //iPhoneの場合
        if(screenSize.width == 320.0 && screenSize.height == 568.0)
        {
            
            w = 45;
            h = 70;
            
            
            int ww,hh;
            if (kigenNum<=2) {
                hh=80;
            }else{
                hh=60;
            }
            if (juyouNum<=2) {
                ww=20;
            }else{
                ww=37;
            }
            
            stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,35, 35);
            
            [view addSubview:stampButton];
        }
        
        //iPod touchの場合
        else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            
            w = 45;
            h = 60;
            
            
            int ww,hh;
            if (kigenNum<=2) {
                hh=60;
            }else{
                hh=50;
            }
            if (juyouNum<=2) {
                ww=20;
            }else{
                ww=37;
            }
            
            stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,35, 35);
            
            [view addSubview:stampButton];
            
            
        }
        //iPadの場合
        else{
            
            w = 108;
            h = 140;
            
            
            int ww,hh;
            if (kigenNum<=2) {
                hh=100;
            }else{
                hh=80;
            }
            if (juyouNum<=2) {
                ww=50;
            }else{
                ww=80;
            }
            
            stampButton.frame=CGRectMake(ww+juyouNum*w,hh+(5-kigenNum)*h,85, 85);
            
            [view addSubview:stampButton];
            
        }
        
        
    }
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
    
    /* --- ボタン内の画像を調べる --- */
    ud = [NSUserDefaults standardUserDefaults];
    array = [ud objectForKey:@"hoge"];
    NSDictionary *dic = array[button.tag];
    
    plusButton.enabled = NO;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    
    
    
    
    
    NSDictionary *resaveDic = array[button.tag];
    NSMutableDictionary *resaveMDic = [resaveDic mutableCopy];
    
    textView.text = [ud stringForKey:@"contents"];
    
    NSMutableArray *resaveMArray = [array mutableCopy];
    resaveMArray = [[NSMutableArray alloc] init];

//    [resaveMDic setObject:textView.text forKey:@"contents"];
//    resaveMArray[svc.editIndex] = resaveMDic;
    
    
    
    if(_noteView) {
        
        //labelの中身を書き換える
        if(screenSize.width == 320.0 && screenSize.height == 568.0){
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }else{
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:60]];
        }
        
        if(!resaveMArray){
            NSLog(@"ノートもともと出てたけどいままで編集したことない");
            textView.text = dic[@"contents"];
        }else{
            NSLog(@"ノートもともと出てたし今までに編集もした");
        textView.text = resaveMDic[@"contents"];
        }
        
        //stamp画像を書き換える
        todoStamp.image = button.currentImage;
        
    } else {
        
        //NoteViewの初期化
        _noteView = [[NoteView alloc] init];
        [self.view addSubview:_noteView];
        
        
        //キャンセルボタンを表示
        batsu = [UIImage imageNamed:@"ばつ.png"];
        batsuView = [[UIImageView alloc] initWithImage:batsu];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(screenSize.width == 320.0 && screenSize.height == 568.0)
        {
            cancelButton.frame = CGRectMake(225, 230, 30, 30);
            
        }else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            cancelButton.frame = CGRectMake(225, 230, 30, 30);
        }else{
            cancelButton.frame = CGRectMake(460, 480, 70, 70);
        }
        
        cancelButton.tag = button.tag;
        
        [_noteView addSubview:cancelButton];
        [cancelButton setImage:batsu forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonPushed:)forControlEvents:UIControlEventTouchUpInside];
        _noteView.userInteractionEnabled = YES; //タッチの検知をする
        
        
        //labelを表示する部分
        if(screenSize.width == 320.0 && screenSize.height == 568.0)
        {
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,85,180,150)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
            
        }else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            textView = [[UITextView alloc] initWithFrame:CGRectMake(60,85,180,150)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        }
        else{
            textView = [[UITextView alloc] initWithFrame:CGRectMake(130,190,400,250)];
            [textView setFont:[UIFont fontWithName:@"azuki_font" size:60]];
            
        }
        
        textView.backgroundColor = [UIColor clearColor];
        
        if(!resaveMArray){
            NSLog(@"ノートもともと出てないし今まで編集もしてない");
            textView.text = dic[@"contents"];
        }else{
            NSLog(@"ノートもともと出てないけど今までに編集したことある");
            textView.text = resaveMDic[@"contents"];
        }
        
        [_noteView addSubview:textView];
        [self.view bringSubviewToFront:textView];
        
        //とどの上にstampの画像を表示
        if(screenSize.width == 320.0 && screenSize.height == 568.0)
        {
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        }else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(45, 38, 50, 50)];
        }else{
            todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 140, 140)];
        }
        
        todoStamp.image = button.currentImage;
        [_noteView addSubview:todoStamp];
        
        
        [self noteImageFadeIn];
        
        todoFade = !todoFade;
    }
}


-(void)cancelButtonPushed:(UIButton *)sender
{
    [self saveEdit:(int)sender.tag];
    [self noteImageFadeOut];
    [_noteView removeFromSuperview];
    _noteView = nil;
    textView = nil;
    
    plusButton.enabled = YES;
    //stampButton.enabled = NO;
    //mainView.enabled = NO;
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
}

#pragma mark - スタンプの移動
- (void)panAction:(UIPanGestureRecognizer *)sender {
    array = [ud objectForKey:@"hoge"]; //hogeでudをarrayに入れる
    
    NSLog(@"%d番目のスタンプが動かされたよ",sender.view.tag);
    NSDictionary *dic = array[sender.view.tag];
    NSMutableDictionary * mDic = [dic mutableCopy];
    CGPoint p = [sender translationInView:sender.view];
    
    // 移動した距離だけ、UIImageViewのcenterポジションを移動させる
    CGPoint movedPoint = CGPointMake(sender.view.center.x + p.x, sender.view.center.y + p.y);
    sender.view.center = movedPoint;
    
    
    if(sender.state == UIGestureRecognizerStateEnded && movedPoint.x >= gomi.frame.origin.x && movedPoint.x <= gomi.frame.origin.x + gomi.frame.size.width && movedPoint.y >= gomi.frame.origin.y && movedPoint.y <= gomi.frame.origin.y + gomi.frame.size.height)
    {
        //ゴミ箱と重なっていたら削除！　消えろ！　うら！
        NSMutableArray *mArray = [array mutableCopy];
        NSLog(@"%d %d",sender.view.tag,[mArray count]);
        [mArray removeObjectAtIndex:sender.view.tag];
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
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.x] forKey:@"x"];
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.y] forKey:@"y"];
        
        kigenNum = 0;
        juyouNum = 0;
        
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        
        //iPhoneの場合
        if(screenSize.width == 320.0 && screenSize.height == 568.0)
        {
            
            if(movedPoint.x <= 52) juyouNum = 0;
            else if(movedPoint.x <= 104) juyouNum = 1;
            else if(movedPoint.x <= 156) juyouNum = 2;
            else if(movedPoint.x <= 208) juyouNum = 3;
            else if(movedPoint.x <= 260) juyouNum = 4;
            else if(movedPoint.x <= 312) juyouNum = 5;
            NSLog(@"%f",movedPoint.x);
            
            if(movedPoint.y < 80) kigenNum = 5;
            else if(movedPoint.y <= 160) kigenNum = 4;
            else if(movedPoint.y <= 240) kigenNum = 3;
            else if(movedPoint.y <= 320) kigenNum = 2;
            else if(movedPoint.y <= 400) kigenNum = 1;
            else if(movedPoint.y <= 440) kigenNum = 0;
        }
        //iPod touchの場合
        else if(screenSize.width == 320.0 && screenSize.height == 480.0){
            if(movedPoint.x <= 52) juyouNum = 0;
            else if(movedPoint.x <= 104) juyouNum = 1;
            else if(movedPoint.x <= 156) juyouNum = 2;
            else if(movedPoint.x <= 208) juyouNum = 3;
            else if(movedPoint.x <= 260) juyouNum = 4;
            else if(movedPoint.x <= 312) juyouNum = 5;
            NSLog(@"%f",movedPoint.x);
            
            if(movedPoint.y < 75) kigenNum = 5;
            else if(movedPoint.y <= 150) kigenNum = 4;
            else if(movedPoint.y <= 225) kigenNum = 3;
            else if(movedPoint.y <= 300) kigenNum = 2;
            else if(movedPoint.y <= 375) kigenNum = 1;
            else if(movedPoint.y <= 450) kigenNum = 0;
        }
        else{
            if(movedPoint.x <= 124) juyouNum = 0;
            else if(movedPoint.x <= 248) juyouNum = 1;
            else if(movedPoint.x <= 372) juyouNum = 2;
            else if(movedPoint.x <= 496) juyouNum = 3;
            else if(movedPoint.x <= 620) juyouNum = 4;
            else if(movedPoint.x <= 744) juyouNum = 5;
            NSLog(@"%f",movedPoint.x);
            
            if(movedPoint.y < 160) kigenNum = 5;
            else if(movedPoint.y <= 320) kigenNum = 4;
            else if(movedPoint.y <= 480) kigenNum = 3;
            else if(movedPoint.y <= 640) kigenNum = 2;
            else if(movedPoint.y <= 800) kigenNum = 1;
            else if(movedPoint.y <= 960) kigenNum = 0;
        }
        
        NSLog(@"kigenNum is %d",kigenNum);
        NSLog(@"juyouNum is %d",juyouNum);
        
        [mDic setObject:[NSNumber numberWithInt:kigenNum] forKey:@"kigen"];
        [mDic setObject:[NSNumber numberWithInt:juyouNum] forKey:@"juyou"];
        
        NSMutableArray *mArray = [array mutableCopy];
        mArray[sender.view.tag] = mDic;
        
        [ud setObject:mArray forKey:@"hoge"];
        [ud synchronize];
    }
    
    // ドラッグで移動した距離を初期化する
    [sender setTranslation:CGPointZero inView:self.view];
    
}

//フェードイン
- (void)noteImageFadeIn
{
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
