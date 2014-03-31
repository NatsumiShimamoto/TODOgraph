//
//  GraphViewController.m
//  TODO graph
//
//  Created by 嶋本夏海 on 2013/10/07.
//  Copyright (c) 2013年 嶋本夏海. All rights reserved.
//

#import "GraphViewController.h"


@implementation GraphViewController


#pragma mark - ViewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
    gomi.frame = CGRectMake(50, 493, 73, 73);
    [self.view addSubview:gomi];
    
    
    [mainView removeFromSuperview]; //一回mainViewを全部消す
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
    
    for(i = 0; i < [array count]; i++)
    {
        stampButton = [[UIButton alloc] init];
        stampButton.frame = CGRectMake(0, 0, 35, 35);
        
        stampButton.tag = i;
        NSLog(@"tag:%d",stampButton.tag);
        stampButton.userInteractionEnabled = YES; //タッチの検知をするかしないかの設定
        NSDictionary *dic = array[i];
        
        NSLog(@"dic is %@", dic);
        
        NSString *GVstStampNum = [dic objectForKey:@"stamp"];
        kigenNum = [[dic objectForKey:@"kigen"] intValue]; //０だったら近い
        juyouNum = [[dic objectForKey:@"juyou"] intValue]; //０だったら重要
        
        
        /* --- スタンプの条件分け ---*/
        if([GVstStampNum intValue] == 0) [stampButton setImage:[UIImage imageNamed:@"icon4.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 1) [stampButton setImage:[UIImage imageNamed:@"icon03.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 2) [stampButton setImage:[UIImage imageNamed:@"icon01.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 3) [stampButton setImage:[UIImage imageNamed:@"icon2.png"] forState:UIControlStateNormal];
        if([GVstStampNum intValue] == 4) [stampButton setImage:[UIImage imageNamed:@"icon5.png"] forState:UIControlStateNormal];
        
        [stampButton addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        //stampButtonが押されたらbuttonPushedが呼び出される
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]; //ドラッグを検知してpanActionを呼び出す
        [stampButton addGestureRecognizer:pan]; //stampViewにpanを設定する
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
    return view;
    
}



#pragma mark - スタンプの選択(移動)
/* -- ここで画面遷移 --- */

- (void)buttonPushed:(UIButton *)button //buttonとstampButtonは同じって考えていい
{
    /* -- 画面の宣言 -- */
    SetteiViewController *svc = [[self storyboard] instantiateViewControllerWithIdentifier:@"settei"];
    
    
    NSUserDefaults *stampUd = [NSUserDefaults standardUserDefaults];
    svc.stampNum = [stampUd integerForKey:@"stamp"];
    NSLog(@"スタンプの番号 is %d", svc.stampNum);
    
    
    /* --- ここでeditIndexを使用 --- */
    svc.editIndex = stampButton.tag;//ボタンタグを入れる
    NSLog(@"スタンプの順番 is %d",svc.editIndex);
    
    /* --- ボタン内の画像を調べる --- */
    array = [ud objectForKey:@"hoge"];
    NSDictionary *dic = array[button.tag];
    
    
    if(_noteView) {
        
        //labelの中身を書き換える
        todoLabel.numberOfLines = 4;
        [todoLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        todoLabel.text = dic[@"contents"];
        todoLabel.adjustsFontSizeToFitWidth = YES;
        todoLabel.minimumScaleFactor = 0.8f;
        
        //stamp画像を書き換える
        todoStamp.image = button.currentImage;
        
    } else {
        
        //大きなとどの画像を表示
        noteImage = [UIImage imageNamed:@"ノート正方形.png"];
        _noteView = [[UIImageView alloc] initWithImage:noteImage];
        _noteView.frame = CGRectMake(15,130,280,280);
        _noteView.layer.shadowOpacity = 0.4; // 濃さを指定
        _noteView.layer.shadowOffset = CGSizeMake(10.0, 10.0); // 影までの距離を指定
        [self.view addSubview:_noteView];
        
        
        //キャンセルボタンを表示
        
        batsu = [UIImage imageNamed:@"ばつ.png"];
        batsuView = [[UIImageView alloc] initWithImage:batsu];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(225, 230, 30, 30);
        [_noteView addSubview:cancelButton];
        [cancelButton setImage:batsu forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonPushed:)forControlEvents:UIControlEventTouchUpInside];
        _noteView.userInteractionEnabled = YES; //タッチの検知をする
        
        
        //labelを表示する部分
        todoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,85,180,150)];
        [todoLabel setFont:[UIFont fontWithName:@"azuki_font" size:25]];
        todoLabel.numberOfLines = 4;
        todoLabel.adjustsFontSizeToFitWidth = YES;
        todoLabel.minimumScaleFactor = 0.8f;
        todoLabel.text = dic[@"contents"];
        [_noteView addSubview:todoLabel];
        [self.view bringSubviewToFront:todoLabel];
        
        
        
        //とどの上にstampの画像を表示
        todoStamp = [[UIImageView alloc] initWithFrame:CGRectMake(47, 42, 45, 45)];
        todoStamp.image = button.currentImage;
        [_noteView addSubview:todoStamp];
        
        
        [self noteImageFadeIn];
        
        todoFade = !todoFade;
    }
}



-(void)cancelButtonPushed:(UIButton *)sender{
    
    [self noteImageFadeOut];
    [_noteView removeFromSuperview];
    _noteView = nil;
    
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
        
        return;
    }
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.x] forKey:@"x"];
        [mDic setObject:[NSNumber numberWithFloat:movedPoint.y] forKey:@"y"];
        
        kigenNum = 0;
        juyouNum = 0;
        
        if(movedPoint.x <= 50) juyouNum = 0;
        else if(movedPoint.x <= 100) juyouNum = 1;
        else if(movedPoint.x <= 150) juyouNum = 2;
        else if(movedPoint.x <= 200) juyouNum = 3;
        else if(movedPoint.x <= 250) juyouNum = 4;
        else if(movedPoint.x <= 300) juyouNum = 5;
        
        if(movedPoint.y < 80) kigenNum = 5;
        else if(movedPoint.y <= 160) kigenNum = 4;
        else if(movedPoint.y <= 240) kigenNum = 3;
        else if(movedPoint.y <= 320) kigenNum = 2;
        else if(movedPoint.y <= 400) kigenNum = 1;
        else if(movedPoint.y <= 440) kigenNum = 0;
        
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
