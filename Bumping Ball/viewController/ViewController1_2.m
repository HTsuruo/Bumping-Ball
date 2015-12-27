//
//  ViewController1_2.m
//  Ball
//
//  Created by Tsuru on 2014/06/25.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController1_2.h"
#import <Social/Social.h>//SNSのためのライブラリ
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import "Sound.h"

AppDelegate * delegate;

AVAudioPlayer * result_sound;//ボタンを押したときの効果音

double WIDTH;//画面の幅を取得
double HEIGHT;//画面の高さを取得

int score;
int a;

@interface ViewController1_2 ()

@end

@implementation ViewController1_2


/*------------------------------------------広告関連----------------------------------------*/
-(void)viewWillAppear:(BOOL)animated{
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    // iPadかどうか判断する
    if ( ![modelname hasPrefix:@"iPad"] ) {//iPhoneなら
        // NADView の作成
        nadview = [[NADView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-NAD_ADVIEW_SIZE_320x50.height,  NAD_ADVIEW_SIZE_320x50.width,  NAD_ADVIEW_SIZE_320x50.height)];
        // apiKey, spotID をセットする
        [nadview setNendID:@"71da0d3bccbdf5363d814de6917dc9fe68672bf8" spotID:@"209240"];
        
    }else{
        nadview = [[NADView alloc] initWithFrame:CGRectMake(WIDTH*0.03,self.view.frame.size.height-90,  728,  90)];
        [nadview setNendID:@"e620ef4ac9ffc5d97f87a009d275c544f5ed794f" spotID:@"209857"];
    }
    
    // デリゲートオブジェクトの指定
    [nadview setDelegate:self];
    // 広告のロードを開始
    [nadview load];
    [self.view addSubview:nadview] ;

    
}


- (void)viewDidLoad

{
    [super viewDidLoad];
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得
    
    sound = [[Sound alloc]init];
    a = 0;
    
    // Do any additional setup after loading the view.
    
    UIImage * back;
    // 各言語の結果に対して処理を記述
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
         back = [UIImage imageNamed:@"background1_2.png"];
    } else {//他言語の場合
         back = [UIImage imageNamed:@"background1_2.eng.png"];
    }
    backGroundV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backGroundV.image = back;
    [self.view addSubview:backGroundV];
    
    
    //スコアを表示するための準備
    zero_red = [UIImage imageNamed:@"zero_red.png"];
    one_red = [UIImage imageNamed:@"one_red.png"];
    two_red = [UIImage imageNamed:@"two_red.png"];
    three_red = [UIImage imageNamed:@"three_red.png"];
    four_red = [UIImage imageNamed:@"four_red.png"];
    five_red = [UIImage imageNamed:@"five_red.png"];
    six_red = [UIImage imageNamed:@"six_red.png"];
    seven_red = [UIImage imageNamed:@"seven_red.png"];
    eight_red = [UIImage imageNamed:@"eight_red.png"];
    nine_red = [UIImage imageNamed:@"nine_red.png"];
    
    for(int i=0;i<7;i++){
        scoreView[i] = [[UIImageView alloc]init];
    }
    
    NSURL * url2 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"result"] withExtension:@"mp3"];
    result_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    result_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [result_sound play];
    
    
    
    //--------------------------------------主な2つのボタン--------------------------------------//
    
    UIImage * again = [UIImage imageNamed:@"again.png"];//画像の取得
    UIImage * home = [UIImage imageNamed:@"home.png"];//画像の取得
    for(int i=0;i<2;i++){
        
        btn[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        btn[i].frame =CGRectMake(WIDTH*0.22+(WIDTH*0.3*i),HEIGHT*0.53,WIDTH*0.25,WIDTH*0.25);//位置と大きさ
        
        switch (i) {
                
            case 0:
                [btn[0] setBackgroundImage:again forState:UIControlStateNormal];  // 画像をセットする
                [btn[0] addTarget:self action:@selector(btn0) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            case 1:
                [btn[1] setBackgroundImage:home forState:UIControlStateNormal];  // 画像をセットする
                [btn[1] addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        
        [self.view addSubview:btn[i]];
        
    }
    
    //スタート合図を知らせるタイマー
    tm =
    [NSTimer
     scheduledTimerWithTimeInterval:0.5f
     target:self
     selector:@selector(timer:)
     userInfo:nil
     repeats:YES
     ];
    
    
    /*---------------------------------------SNS-----------------------------------------------*/
    
    twitterImage = [UIImage imageNamed:@"twitter.png"];//画像の取得
    facebookImage = [UIImage imageNamed:@"facebook.png"];//画像の取
    
    for(int i=0;i<2;i++){
        
        snsB[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        snsB[i].frame =CGRectMake(WIDTH/20+(WIDTH*2/3*i),HEIGHT*0.65,WIDTH*0.2,WIDTH*0.2);//位置と大きさ
        
        switch (i) {
                
            case 0:
                [snsB[0] setBackgroundImage:twitterImage forState:UIControlStateNormal];  // 画像をセットする
                [snsB[0] addTarget:self action:@selector(snsButton0) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                [snsB[1] setBackgroundImage:facebookImage forState:UIControlStateNormal];  // 画像をセットする
                [snsB[1] addTarget:self action:@selector(snsButton1) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        [self.view addSubview:snsB[i]];
        
    }
    
    
   if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
       
        str1 = @"Bumping Ballで";
        str2 = @"バンプを達成しました。\nBB : https://itunes.apple.com/us/app/bumping-ball/id904579413?l=ja&ls=1&mt=8";
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        str = [NSString stringWithFormat: @"%@%@%@",str1,delegate.ScoreS,str2];
        
        av = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"つぶやきました"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        av2 = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"完了しました"
                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        av3 = [[UIAlertView alloc] initWithTitle:@"接続エラー" message:@"設定からサインインしてください"
                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       
       //レビュー促進
       av_review = [[UIAlertView alloc] initWithTitle:@"レビューのお願い" message:@"Bumping Ballをプレイしていただきありがとうございます。\n レビューを書いていただくと当方大変嬉しく思います。\nご協力よろしくお願いいたします。"
                                                           delegate:self cancelButtonTitle:@"絶対にいやだ" otherButtonTitles:@"そこまで言うなら",nil];
    }else{
        str1 = @"Bumping Ball : ";
        str2 = @"bump!! \nBB : https://itunes.apple.com/us/app/bumping-ball/id904579413?l=ja&ls=1&mt=8";
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        str = [NSString stringWithFormat: @"%@%@%@",str1,delegate.ScoreS,str2];
        
        av = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"completed"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        av2 = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"completed"
                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        av3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please sign in"
                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        //レビュー促進
        av_review = [[UIAlertView alloc] initWithTitle:@"review　request" message:@"Thank you for playing Bumping Ball!! \n I'm so happy if you write a review.\n Please write down."
                                              delegate:self cancelButtonTitle:@"Absolutely Not" otherButtonTitles:@"OK!!",nil];
    }
    
}


- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}

-(void)timer:(NSTimer*)timer{
    
    a++;
    if(a == 1){
        [tm invalidate];
        tm = nil;
        //バンプ数の表示
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        scoreLabel.text = delegate.ScoreS;
        score = [delegate.ScoreS intValue];
        [self scoreCount];
    }
}

-(void)btn0{
    
    [sound button_sound];
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    // iPadかどうか判断する
    if ( ![modelname hasPrefix:@"iPad"] ) {
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"vc"];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        UIViewController * vc_iPad = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_iPad"];
        [self presentViewController:vc_iPad animated:YES completion:nil];
    }
    
}

-(void)btn1{
    
       [sound button_sound];
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    [self presentViewController:vc0 animated:YES completion:nil];
    
}

-(void)snsButton0{//twitter
    
    
    [sound button_sound];
    [self postToTwitter];
    
}



-(void)snsButton1{//facebook
    
    [sound button_sound];
    [self postToFacebook];
}



// Twitterに投稿

- (void)postToTwitter {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        
        cvc = [SLComposeViewController
               
               composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [cvc setInitialText:str];
        
        
        // 処理終了後に呼び出されるコールバックを指定する
        
        [cvc setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                    
                case SLComposeViewControllerResultDone:
                    
                    // １行で書くタイプ（１ボタンタイプ）
                    [av show];
                    break;
                    
                case SLComposeViewControllerResultCancelled:;
                    
                    //NSLog(@"Cancel!!");
            }
        }];
        
        [self presentViewController:cvc animated:YES completion:nil];
        
    }else{
        
        [av3 show];
        
    }
}

// Facebookに投稿

- (void)postToFacebook {
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        
        // NSLog(@"facebook");
        
        cvc2 = [SLComposeViewController
                
                composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [cvc2 setInitialText:str];
        
        
        
        // 処理終了後に呼び出されるコールバックを指定する
        
        [cvc setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                    
                    [av2 show];
                    break;
                case SLComposeViewControllerResultCancelled:;
                   // NSLog(@"Cancel!!");
                    
            }
            
        }];
        
        [self presentViewController:cvc2 animated:YES completion:nil];
        
    }else{
        
        [av3 show];
    }
}

-(void)scoreCount{
    
    int tempScore_1000000;//あまり
    int tempScore_100000;//あまり
    int tempScore_10000;//あまり
    int tempScore_1000;//あまり
    int tempScore_100;//あまり
    int tempScore_10;//あまり
    
    int limit;
    
    int temp = score;//ユーザデフォルトからの値, hiScoreを取得
    
    int size  = WIDTH/4;
    int between = WIDTH/7;
    
    if(score <1000){//3桁（2桁はあり得ない）
        
        for(int i=0;i<3;i++){
            scoreView[i].frame =CGRectMake((WIDTH*7/10-size)-(between*i) , HEIGHT/4 - HEIGHT/100, size, size);
        }
        limit = 3;
    }else if (score <10000){//4桁
        for(int i=0;i<4;i++){
            scoreView[i].frame =CGRectMake((WIDTH*8/10-size)-(between*i) , HEIGHT/4 - HEIGHT/100, size, size);
        }
        limit =4;
    }else if (score <100000){//5桁
        for(int i=0;i<5;i++){
            scoreView[i].frame =CGRectMake((WIDTH*9/10-size)-(between*i) , HEIGHT/4 - HEIGHT/100, size, size);
        }
        limit =5;
    }else if (score <1000000){//6桁
        for(int i=0;i<6;i++){
            scoreView[i].frame =CGRectMake((WIDTH-size)-(between*i) , HEIGHT/4 - HEIGHT/100, size, size);
        }
        limit =6;
    }else{//7桁
        for(int i=0;i<7;i++){
            scoreView[i].frame = CGRectMake((WIDTH-size)-(between*0.9*i) , HEIGHT/4 - HEIGHT/100, size, size);
        }
        limit = 7;
    }
    
    if(score == 0){
        scoreView[0].frame = CGRectMake(WIDTH/3, HEIGHT/4 - HEIGHT/100, size, size);
        limit = 1;
    }
    
    //NSLog(@"limit : %d",limit);
    
    tempScore_1000000  = temp / 1000000;//1000000で割った商(1000000の位)
    temp %= 1000000;//1000000で割ったあまり
    tempScore_100000 = temp / 100000;//(100000の位)
    temp %= 100000;//100000で割ったあまり
    tempScore_10000 = temp / 10000;//(10000の位)
    temp %= 10000;//10000で割ったあまり
    tempScore_1000 = temp / 1000;//1000の位
    temp %= 1000;//1000で割ったあまり
    tempScore_100 = temp / 100;//100の位
    temp %= 100;//100で割ったあまり
    tempScore_10 = temp / 10;//10の位
    scoreView[0].image = zero_red;//1の位
    
    [self ScoreJudge:tempScore_1000000 int:6];
    [self ScoreJudge:tempScore_100000 int:5];
    [self ScoreJudge:tempScore_10000 int:4];
    [self ScoreJudge:tempScore_1000 int:3];
    [self ScoreJudge:tempScore_100 int:2];
    [self ScoreJudge:tempScore_10 int:1];
    
    [self scoreAnimation:limit];
}

-(void)scoreAnimation:(int)limit{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,3.0, 3.0);
    
    //数字アニメーション
    for(int i=0;i<limit;i++){
        [self numberAnimation:limit int:i*0.2f float:i];
    }
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([delegate.NewRecord isEqualToString:@"YES"]){
        UIImage * newRecordImage = [UIImage imageNamed:@"newRecord.png"];
        NewRecordV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.05, HEIGHT*0.15, WIDTH*0.6, WIDTH*0.2)];
        NewRecordV.image = newRecordImage;
        NewRecordV.transform = t2;
        NewRecordV.alpha = 0.0;
        
        // アニメーション
        [UIView animateWithDuration:0.2f // アニメーション速度2.5秒
                              delay:1.0f // 0秒後にアニメーション
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             [self.view addSubview:NewRecordV];
                             NewRecordV.alpha = 1.0;
                             NewRecordV.transform = t1;
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    }

}

-(void)numberAnimation:(int) limit int:(float)delay float:(int)i{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,4.0, 4.0);
    
    //3倍の大きさ
        scoreView[i].transform = t2;
        scoreView[i].alpha = 0.0;
        [self.view addSubview:scoreView[i]];
    
    [UIView animateWithDuration:0.8f // アニメーション速度2.5秒
                          delay:delay// 0秒後にアニメーション
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                             [self.view addSubview:scoreView[i]];
                             scoreView[i].alpha = 1.0;
                             scoreView[i].transform = t1;
                             
                         
                         
                     } completion:^(BOOL finished) {
                         
                         //初期起動か否かの判別(backgroundの後じゃないとダメ)
                         NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
                        // [ud removeObjectForKey:@"firstPlay"];  // KEY_Iを削除する
                         BOOL  isNotFirst = [ud boolForKey:@"firstPlay"];
                         
                         if(!isNotFirst){//初期起動の場合
                             [av_review show];
                             /*初回プレイか否かを判別*/
                             [ud setBool:YES forKey:@"firstPlay"];
                             [ud synchronize];//userDefaultsへの反映*/
                         }else{
                             //なにもなし
                         }
                         
                     }];
}

-(void)ScoreJudge:(int)a int:(int)tempId{
    
    switch (a) {
        case 0:
            scoreView[tempId].image = zero_red;
            break;
        case 1:
            scoreView[tempId].image = one_red;
            break;
        case 2:
            scoreView[tempId].image = two_red;
            break;
        case 3:
            scoreView[tempId].image = three_red;
            break;
        case 4:
            scoreView[tempId].image = four_red;
            break;
        case 5:
            scoreView[tempId].image = five_red;
            break;
        case 6:
            scoreView[tempId].image = six_red;
            break;
        case 7:
            scoreView[tempId].image = seven_red;
            break;
        case 8:
            scoreView[tempId].image = eight_red;
            break;
            
        default:
            scoreView[tempId].image = nine_red;
            break;
    }
    
}

// アラートのボタンが押された時に呼ばれるデリゲート例文
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            //１番目のボタンが押されたときの処理を記述する
            break;
        case 1:
            [self openReviewUrl:@"904579413"];
            break;
    }
    
}

// AppStoreのレビューURLを開く (引数に AppStoreのアプリIDを指定)
- (void)openReviewUrl:(NSString *)appStoreId
{
    // レビュー画面の URL
    NSString *reviewUrl;
    
    reviewUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appStoreId];
    
    // レビュー画面へ遷移
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewUrl]];
    
}


//広告のロードが初めて成功した場合に実行される
- (void)nadViewDidFinishLoad:(NADView *)adView {
    
}

//タップした時の処理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)even{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

@end

