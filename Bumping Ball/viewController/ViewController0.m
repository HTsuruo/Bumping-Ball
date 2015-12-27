//
//  ViewController0.m
//  Ball
//
//  Created by Tsuru on 2014/06/19.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController0.h"
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import "Sound.h"
#import "AppDelegate.h"

AppDelegate * delegate;

@interface ViewController0 ()

@end

@implementation ViewController0


double WIDTH;//画面の幅を取得
double HEIGHT;//画面の高さを取得

double x;//円運動x
double y;//円運動y
double x_0;//円の中心のx座標
double y_0;//円の中心のy座標
double radius;//半径
double t;//円運動の時間
const double omega = 1;//角速度
//SystemSoundID button_sound;//ボタンを押したときの効果音
int isSelected;
int imageSize;

int modeNumber;//モード番号

BOOL  matchStarted;

//BGMの宣言
AVAudioPlayer * titleBGM;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
   // if([delegate.gameCenerAvailable isEqualToString:@"YES"]){
    // ゲーム招待を処理するためのハンドラを設定する
    //[self initMatchInviteHandler];
    //}
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString *modelname = [ [ UIDevice currentDevice] model];
    sound = [[Sound alloc]init];
    
    //背景の設定
    //imageBack = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-HEIGHT/14)];
    back = [UIImage imageNamed:@"titleBackground"];
    imageBack.image = back;
    [self.view addSubview:imageBack];
    
    //初期起動か否かの判別(backgroundの後じゃないとダメ)
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    BOOL  isNotFirst = [ud boolForKey:@"firstLaunch"];
   
    if(!isNotFirst){//初期起動の場合
        NSLog(@"初期起動");
         [self firstLaunch];//初期起動処理
    }else{
         [self secondLaunch];//初期起動処理
    }
    
    //BGMの読み込み
    NSURL * url2 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"texture1"] withExtension:@"mp3"];
    titleBGM = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    titleBGM.numberOfLoops = -1;
    titleBGM.volume = 1.0f;//音量設定(0.0~1.0)*/
    [titleBGM prepareToPlay];
    [titleBGM play];
    
    
    
    //--------------------------------------主な4つのボタン--------------------------------------//
    UIImage * oneImage = [UIImage imageNamed:@"play_one.png"];//画像の取得
    UIImage * bluetoothImage = [UIImage imageNamed:@"play_bluetooth.png"];//画像の取得
  //  UIImage * networkImage = [UIImage imageNamed:@"play_network.png"];//画像の取得
    
    for(int i=0;i<3;i++){
        btn[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作
        
        // iPadかどうか判断する
        if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
            btn[0].frame =CGRectMake(WIDTH*0.285,HEIGHT*0.38,WIDTH*0.43,WIDTH*0.28);
            btn[i].frame =CGRectMake(WIDTH*0.275-(WIDTH*0.05),HEIGHT*0.42+(i*HEIGHT*0.15),WIDTH*0.43+(WIDTH*0.1),WIDTH*0.28);
        }else{
            btn[0].frame =CGRectMake(WIDTH*0.31,HEIGHT*0.36,WIDTH*0.38,WIDTH*0.23);
            btn[i].frame =CGRectMake(WIDTH*0.3-(WIDTH*0.05),HEIGHT*0.4+(i*HEIGHT*0.17),WIDTH*0.38+(WIDTH*0.1),WIDTH*0.23);
        }
    }
    [btn[0] setBackgroundImage:oneImage forState:UIControlStateNormal];  // 画像をセットする
    [btn[1] setBackgroundImage:bluetoothImage forState:UIControlStateNormal];  // 画像をセットする
  //  [btn[2] setBackgroundImage:networkImage forState:UIControlStateNormal];  // 画像をセットする
    [btn[1] addTarget:self action:@selector(btn_bluetooth) forControlEvents:UIControlEventTouchUpInside];
    [btn[0] addTarget:self action:@selector(btn_one) forControlEvents:UIControlEventTouchUpInside];
  //  [btn[2] addTarget:self action:@selector(btn_network) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btn[0]];
    [self.view addSubview:btn[1]];
 //   [self.view addSubview:btn[2]];
    
    //モード変更ボタン
    easy = [UIImage imageNamed:@"easy.png"];//画像の取得
    normal = [UIImage imageNamed:@"normal.png"];//画像の取得
    hard = [UIImage imageNamed:@"hard.png"];//画像の取得
    btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    btn2.frame =CGRectMake(WIDTH*0.7,HEIGHT*0.48,WIDTH*0.25,WIDTH*0.2);//位置と大き
    [btn2 addTarget:self action:@selector(btn_mode) forControlEvents:UIControlEventTouchUpInside];
    
    switch (modeNumber) {
        case 1://easyの場合
            [btn2 setBackgroundImage:easy forState:UIControlStateNormal];  // 画像をセットする
            delegate.mode = @"easy";
            break;
        case 2://hardの場合
            [btn2 setBackgroundImage:hard forState:UIControlStateNormal];  // 画像をセットする
            delegate.mode = @"hard";
            break;
        default://normalの場合（初期起動のときはnormalになっている）
            [btn2 setBackgroundImage:normal forState:UIControlStateNormal];  // 画像をセットする
            delegate.mode = @"normal";
            break;
    }
    
    [self.view addSubview:btn2];
    
    
    
    UIImage * ruleImage = [UIImage imageNamed:@"help.png"];//画像の取得
    UIImage * rankImage = [UIImage imageNamed:@"rank.png"];//画像の取得
    for(int i=0;i<2;i++){
        btn3[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        btn3[i].frame =CGRectMake(WIDTH*0.1 +(i*WIDTH*0.6),HEIGHT*0.7,WIDTH*0.2,WIDTH*0.2);//位置と大きさ
    }
    [btn3[0] setBackgroundImage:ruleImage forState:UIControlStateNormal];  // 画像をセットする
    [btn3[1] setBackgroundImage:rankImage forState:UIControlStateNormal];  // 画像をセットする
    [btn3[0] addTarget:self action:@selector(btn3_rule) forControlEvents:UIControlEventTouchUpInside];
    [btn3[1] addTarget:self action:@selector(btn3_rank) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3[0]];
    [self.view addSubview:btn3[1]];
    
    
    //--------------------------------------背景のボタン--------------------------------------//
    theme1 = [UIImage imageNamed:@"theme1.png"];//デフォルト
    theme2 = [UIImage imageNamed:@"theme2.png"];//空
    theme3 = [UIImage imageNamed:@"theme3.png"];//宇宙
    theme4 = [UIImage imageNamed:@"theme4.png"];//モノクロ
    theme5 = [UIImage imageNamed:@"theme5.png"];//木
    
    background = [UIImage imageNamed:@"background.png"];
    background2 = [UIImage imageNamed:@"background2.png"];
    background3 = [UIImage imageNamed:@"background3.png"];
    background4 = [UIImage imageNamed:@"background4.png"];
    background5 = [UIImage imageNamed:@"background5.png"];
    
    radius = WIDTH/16;
    imageSize = WIDTH/32;
    
    for(int i=0;i<5;i++){
        backBtn[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backBtn[i].frame = CGRectMake(WIDTH*0.035+(i*WIDTH/5),HEIGHT*9/10,radius*2,radius*4);//位置と大きさ
        
        switch (i) {
            case 0:
                [backBtn[i] setBackgroundImage:theme1 forState:UIControlStateNormal];  // 画像をセットする
                [backBtn[i] addTarget:self action:@selector(btn01) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [backBtn[i] setBackgroundImage:theme2 forState:UIControlStateNormal];  // 画像をセットする
                [backBtn[i] addTarget:self action:@selector(btn02) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 2:
                [backBtn[i] setBackgroundImage:theme3 forState:UIControlStateNormal];  // 画像をセットする
                [backBtn[i] addTarget:self action:@selector(btn03) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 3:
                [backBtn[i] setBackgroundImage:theme4 forState:UIControlStateNormal];  // 画像をセットする
                [backBtn[i] addTarget:self action:@selector(btn04) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            default:
                [backBtn[i] setBackgroundImage:theme5 forState:UIControlStateNormal];  // 画像をセットする
                [backBtn[i] addTarget:self action:@selector(btn05) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        [self.view addSubview:backBtn[i]];
    }
    
    //タイマーを作成してスタート
    tm =
    [NSTimer
     scheduledTimerWithTimeInterval:0.05f
     target:self
     selector:@selector(selecting:)
     userInfo:nil
     repeats:YES
     ];
    
    image = [UIImage imageNamed:@"star.png"];
    
    
    
    switch (isSelected) {
        case 1://空
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            delegate.themeImage = background2;//theme2をthemeImageに渡す
            [self x_and_y:1];
            break;
        default://宇宙(デフォルトに設定します)
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            delegate.themeImage = background3;//theme3をthemeImageに渡す
            [self x_and_y:2];
            break;
        case 3://モノクロ
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            delegate.themeImage = background4;//theme4をthemeImageに渡す
            [self x_and_y:3];
            break;
        case 4://木
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            delegate.themeImage = background5;//theme5をthemeImageに渡す
            [self x_and_y:4];
            break;
        case 5://デフォルト
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            delegate.themeImage = background;//theme1をthemeImageに渡す
            [self x_and_y:0];
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初期起動の場合
-(void)firstLaunch{
    
    check = [UIImage imageNamed:@"check.png"];
    checkV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.05, HEIGHT*0.65, WIDTH*0.1, WIDTH*0.1)];
    checkV.image = check;
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,1.3, 1.3);
    
    [UIView animateWithDuration:0.7f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         checkV.transform = t2;
                         [self.view addSubview:checkV];
                         [UIView setAnimationRepeatCount:30];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         checkV.transform = t1;
                         
                         
                     }completion:^(BOOL finished){//処理が終わったら
                         checkV = nil;
                     }];

}
//二回目以降起動の場合
-(void)secondLaunch{
    
    checkV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH,HEIGHT,0,0)];
    [self.view addSubview:checkV];
    checkV = nil;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

//一人で遊ぶボタンが押された時
- (void)btn_one{
    
    [sound button_sound];
    
    [tm invalidate];
    tm = nil;
    
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
    
    [titleBGM stop];
    [titleBGM prepareToPlay];
    
}

//モード選択ボタン
-(void)btn_mode{
    
    [sound button_sound];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    
    switch (modeNumber) {
        case 1://easyの場合
            modeNumber = 0;
            [btn2 setBackgroundImage:normal forState:UIControlStateNormal];
            delegate.mode= @"normal";
            break;
        case 2://hardの場合
            modeNumber = 1;
            [btn2 setBackgroundImage:easy forState:UIControlStateNormal];
            delegate.mode= @"easy";
            break;
            
        default://normalの場合
            modeNumber = 2;
            [btn2 setBackgroundImage:hard forState:UIControlStateNormal];
            delegate.mode= @"hard";
            break;
    }
    
    [self.view addSubview:btn2];
}

//bluetoothで遊ぶボタンが押された時
- (void)btn_bluetooth{
    
    [sound button_sound];
    
    [tm invalidate];
    tm = nil;
    [titleBGM stop];
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    // iPadかどうか判断する
    if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
        UIViewController * vc2_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_1"];
        [self presentViewController:vc2_1 animated:YES completion:nil];
    }else{
        UIViewController * vc2_1_iPad = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_1_iPad"];
        [self presentViewController:vc2_1_iPad animated:YES completion:nil];
    }
    
}
/*
-(void)btn_network{
    
    [sound button_sound];
    
    // 招待するユーザを指定してマッチメイク要求を作成する
     //参加するプレイヤー
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = 2;
    request.maxPlayers = 2;
    
    [self showMatchmakerWithRequest:request];//ゲームセンターUIを開く（対戦要求ver）
}*/



//ルールボタンが押された時
- (void)btn3_rule{
    
    [sound button_sound];
    
    [tm invalidate];
    tm = nil;

    
        
    UIViewController * vc3_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc3_1"];
    [self presentViewController:vc3_1 animated:YES completion:nil];
}

//ランクボタンが推された時
-(void)btn3_rank{
    
    
    [sound button_sound];
    
    /*-------------------ランキング設定-----------------------------*/
    //ハイスコアを取得
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];     //ユーザデフォルトのインスタンスを作成
    NSInteger highScore_easy;
    NSInteger highScore_normal;
    NSInteger highScore_hard;
    GKScore * scoreReporter_easy;//ゲームセンターに送信
    GKScore * scoreReporter_normal;//ゲームセンターに送信
    GKScore * scoreReporter_hard;//ゲームセンターに送信
    
    // ユーザデフォルトから最高点を取得
    
    //easy
    highScore_easy = [ud integerForKey:@"highScore_easy"];
    scoreReporter_easy = [[GKScore alloc]  initWithLeaderboardIdentifier:@"BB_easy"];
    //normal
    highScore_normal = [ud integerForKey:@"highScore_normal"];
    scoreReporter_normal = [[GKScore alloc]  initWithLeaderboardIdentifier:@"BB_normal"];
    //hard
    highScore_hard = [ud integerForKey:@"highScore_hard"];
    scoreReporter_hard = [[GKScore alloc]  initWithLeaderboardIdentifier:@"BB_hard"];
    
    //難易度別にデフォルトに設定する
    //scoreReporter.shouldSetDefaultLeaderboard = YES;
    
    NSInteger scoreR_easy;
    NSInteger scoreR_normal;
    NSInteger scoreR_hard;
    scoreR_easy = highScore_easy;
    scoreR_normal = highScore_normal;
    scoreR_hard = highScore_hard;
    scoreReporter_easy.value = scoreR_easy;
    scoreReporter_normal.value = scoreR_normal;
    scoreReporter_hard.value = scoreR_hard;
    
    
    [scoreReporter_easy reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil){
            // 報告エラーの処理
            //  NSLog(@"error %@",error);
        }
    }];
    
    [scoreReporter_normal reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil){
            // 報告エラーの処理
            //  NSLog(@"error %@",error);
        }
    }];
    
    [scoreReporter_hard reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil){
            // 報告エラーの処理
            // NSLog(@"error %@",error);
        }
    }];
    
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil)
    {
        // カテゴリ指定を解除(=nil)
        //難易度別にデフォルトに設定する
        switch (modeNumber) {
            case 1:
                leaderboardController.category = @"BB_easy";
                break;
            case 2:
                leaderboardController.category = @"BB_hard";
                break;
            default:
                leaderboardController.category = @"BB_normal";
                break;
        }
        
        leaderboardController.leaderboardDelegate = self;
        [self presentModalViewController: leaderboardController animated: YES];
    }
}

//リーダーボードで完了を押した時に呼ばれる
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//中心を求めます
-(void)x_and_y:(int) a{
    
    x_0 = WIDTH*0.035+(a*WIDTH/5)+radius-imageSize/2;
    y_0 = HEIGHT*9/10+radius-imageSize/2;
    
}


//背景の選択
-(void)selecting:(NSTimer*)timer{
    
    t += 0.15;
    
    x = x_0 + radius * cos(omega*t);
    y = y_0 + radius * sin(omega*t);
    
    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageSize, imageSize)];
    imageV.image = image;
    [self.view addSubview:imageV];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         imageV.alpha = 0.0;
                     }
                     completion:^(BOOL finished){//処理が終わったら
                     }];
    
}

//デフォルト
- (void)btn01{
    
    [sound button_sound];
    
    [self x_and_y:0];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    delegate.themeImage = background;//theme1をthemeImageに渡す
    delegate.themeName = @"default";
    isSelected = 0;//背景の番号
}
//空
- (void)btn02{
    
    [self x_and_y:1];
    
    [sound button_sound];
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    delegate.themeImage = background2;//theme2をthemeImageに渡す
    delegate.themeName = @"sky";
    isSelected = 1;
}
//宇宙
- (void)btn03{
    
    [sound button_sound];
    
    [self x_and_y:2];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    delegate.themeImage = background3;//theme3をthemeImageに渡す
    delegate.themeName = @"space";
    isSelected = 2;
    
    
}
//モノクロ
- (void)btn04{
    
    [sound button_sound];
    
    [self x_and_y:3];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    delegate.themeImage = background4;//theme4をthemeImageに渡す
    delegate.themeName = @"mono";
    isSelected = 3;
}
//木
- (void)btn05{
    
    
    [sound button_sound];
    
    [self x_and_y:4];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    delegate.themeImage = background5;//theme5をthemeImageに渡す
    delegate.themeName = @"wood";
    isSelected = 4;
}

/*-----------------------------------GameCenterのマッチング関連-----------------------------------------*/

- (void)initMatchInviteHandler
{
    [GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
        // 既存のマッチングを破棄する
        currentMatch = nil;
        
        if (acceptedInvite) {
            // ゲーム招待を利用してマッチメイク画面を開く
            [self showMatchmakerWithInvite:acceptedInvite];//ゲームセンターUIを開く（対戦受諾ver）
        }else if(playersToInvite){
            
            GKMatchRequest *request = [[GKMatchRequest alloc] init];
            request.minPlayers = 2;
            request.maxPlayers = 2;
            request.playersToInvite = playersToInvite;
            
            [self showMatchmakerWithRequest:request];//ゲームセンターUIを開く（対戦要求ver）
        }
    };
}

//リクエストするときにゲームセンターUIを表示する
- (void)showMatchmakerWithRequest:(GKMatchRequest *)request
{
    //デフォルトのUIでマッチメークを行う
    GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc]initWithMatchRequest:request];
    mmvc.matchmakerDelegate = self;
                                 
    [self presentViewController:mmvc animated:YES completion:nil];
                                 
}

//対戦要求がきたときにゲームセンターUIを表示する
- (void)showMatchmakerWithInvite:(GKInvite *)invite
{
    //デフォルトのUIでマッチメークを行う
    GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithInvite:invite];
    mmvc.matchmakerDelegate = self;
    
    [self presentViewController:mmvc animated:YES completion:nil];
}

//キャンセルが推されたときのメソッド（マッチの構築に失敗したら）
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController
                                              *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // ゲームに固有のコードをここに実装する。
}

//エラー処理メソッド
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController
                didFailWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
    // ゲームに固有のコードをここに実装する。
}

//matchが成功したら呼ばれるメソッド
//対戦検索メソッドの実装(接続された全てのデバイスで同時に呼ばれるデリゲードメソッド)
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController
                    didFindMatch:(GKMatch *)match
{
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.myMatch = match; // 保持用のプロパティを使用して対戦を保持す

    match.delegate = self;
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    [tm invalidate];
    tm = nil;
    [titleBGM stop];
    
    if (!delegate.matchStarted && match.expectedPlayerCount == 0)//expectedPlayerCount は残りの必要プレイヤー数
        //（０になれば、必要なプレイヤーがそろった事になる）
    {
        matchStarted = YES;//ゲームスタートの合図
        //ゲーム開始の処理(networkビューに画面遷移するのみ)
        /*ポイント：ここをアニメーションにしないとビューが戻る（v0）動きとvc_netに遷移する動きがかぶってしまってエラー*/
       [self dismissViewControllerAnimated:YES
                                 completion:^{

                                     // iPadかどうか判断する
                                     if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
                                         UIViewController * vc_net = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_net"];
                                         vc_net.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                         [self presentViewController:vc_net animated:YES completion:nil];
                                     }else{
                                         UIViewController * vc_net_iPad = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_net_iPad"];
                                         vc_net_iPad.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                                         [self presentViewController:vc_net_iPad animated:YES completion:nil];
                                     }
                                     
                                 }];
    }
    
}


@end
