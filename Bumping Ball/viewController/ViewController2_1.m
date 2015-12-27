//
//  ViewController2_1.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/08/29.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController2_1.h"
#import "Sound.h"
#import "BGM.h"
#import "AppDelegate.h"
#import "Difficulty.h"

AppDelegate * delegate;

float WIDTH;
float HEIGHT;

int size[NUM];//ボールのサイズ
float dy[NUM];//ボールの速度
float ballX[NUM];//ボールのx座標
float ballY[NUM];//ボールのy座標
int num;//配列番号
int storageX;//ボールの保管庫
int storageY;//ボールの保管庫

BOOL touchField;//タッチされた場所の真偽
BOOL isStop;//ストップメニューが表示されているか否か

int countDownSec;//カウントダウンのための秒数
BOOL isCountDown;//カウントダウンの真偽

BOOL isNotMove;//指をドラッグしているか否か

int size2[NUM2];//ボールのサイズ
float dy2[NUM2];//ボールの速度
float dx2[NUM2];//ボールの速度
int often_global;//ボールの生成頻度
float alpha_global;//ボールの速度変更
float ballX2[NUM2];//ボールのx座標
float ballY2[NUM2];//ボールのy座標
int num2;
int storageX2;//ボールの保管庫
int storageY2;//ボールの保管庫 （この値は画面外にでたかどうかの判断のためのy座標と相談する必要がある）
int a;
int colorJudge[NUM];//ボールの色を判定する（自分）
int colorJudge2[NUM2];//ボールの色を判定する（CPU）
int colorJudge3[NUM3];//ボールの色を判定する（アイテムボール）
int colorJudge4[NUM4];//ボールの色を判定する(相手からきたボール)
CGPoint location;
CGPoint newLocation;
CGPoint location2;//指を離したときの座標

float tempSize[NUM];//矩形の調整に使う
float tempSize2[NUM2];//矩形の調整に使う
float tempSize3[NUM3];//矩形の調整に使う
BOOL isFire[NUM];//指を離してボールを発射したかどうか
BOOL isFire2[NUM2];//指を離してボールを発射したかどうか

int comboCount;//コンボカウント

int vertical[10];//横移動の判別（0,1,2,3の４つを設定する）

int lifeCount;//ライフをカウントする
NSString * lifeCount_str;//NSdata型に変換するためのstring型

//ItemBall
int size3[NUM3];//ボールのサイズ
float dx3[NUM3];//ボールの速度
float dy3[NUM3];//ボールの速度
float ballX3[NUM3];//ボールのx座標
float ballY3[NUM3];//ボールのy座標
int num3;//配列番号
int storageX3;//ボールの保管庫
int storageY3;//ボールの保管庫

int itemCount[NUM3];//アイテムボールが動く事の出来る時間をカウントする

BOOL lifeChange;
BOOL ballComing;
BOOL rivalBall;//相手からボールが送られてきたか否か

int blue_number_judge[NUM2];
int green_number_judge[NUM2];
int orange_number_judge[NUM2];
int blue_number_judge2[NUM2];

int chargeCount;//金ボールのチャージカウント
BOOL isGolden;//金ボールをうてる状態にあるのか否か

BOOL isCrisis;//自分が今ピンチな状態か否かを判断

int ball_total;

BOOL isReverse;//リバースのオンオフ
BOOL isSpeed_up;//スピードアップのオ

BOOL isItemBall_gold;//アイテムボールは一つだけ表示にする

@interface ViewController2_1 ()

@end

@implementation ViewController2_1

//インスタンス変数の作成
GKPeerPickerController * _picker;
GKSession * _currentSession;

//getterとsetterの区別
@synthesize picker = _picker;
@synthesize currentSession = _currentSession;

int i;

BOOL isCut;//接続が切れたか否か

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
    
    //bluetoothの接続開始
    [self startPicker];
    
    difficulty = [[Difficulty alloc]init];
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取
    
    num = 0;
    num2 = 0;
    num3 = 0;
    touchField = false;
    isStop = false;
    comboCount = 0;
    countDownSec = 4;
    //lifeChange = false;
    for(int i=0;i<NUM3;i++){
        itemCount[i] = 0;
    }
    chargeCount = 0;//チャージカウントの初期化
    often_global = 0;
    alpha_global = 0.0;
    lifeChange = false;
    ballComing = false;
    rivalBall = false;
    isCrisis = false;
    ball_total = 0;
    isReverse = false;
    isSpeed_up = false;
    isItemBall_gold = false;
    
    storageX = WIDTH;
    storageY = 0;
    storageX2 = WIDTH;
    storageY2 = HEIGHT;
    storageX3 = WIDTH/2;
    storageY3 = -100;
    
    a =0;
    
    lifeCount = 3;
    
    
    //サウンドとBGMの準備
    sound = [[Sound alloc]init];
    bgm = [[BGM alloc]init];
    [bgm BGM_load];
    
    isCut = false;
    
    //背景の設定
    imageBack = [[UIImageView alloc] initWithFrame:self.view.bounds];
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    imageBack.image = delegate.themeImage;//テーマの画像を背景のイメージビューに貼る
    [self.view addSubview:imageBack];
    
    //ライフ関連
    UIImage * you = [UIImage imageNamed:@"life_name_you.png"];
    UIImage * rival = [UIImage imageNamed:@"life_name_rival.png"];
    //life_no_blue = [UIImage imageNamed:@"life_no_blue.png"];
    life_yes_blue = [UIImage imageNamed:@"life_yes_blue.png"];
   // life_no_red = [UIImage imageNamed:@"life_no_red.png"];
    life_yes_red = [UIImage imageNamed:@"life_yes_red.png"];
    
    //youとrivalの表示
    for(int i=0;i<2;i++){
        //life_name[i] = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.19-(i*WIDTH*0.015), HEIGHT*0.015+(i*HEIGHT*0.04), WIDTH*0.15+(i*WIDTH*0.03), WIDTH*0.1)];
        life_name[i] = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.22-(i*WIDTH*0.015), HEIGHT*0.015+(i*HEIGHT*0.04), WIDTH*0.15+(i*WIDTH*0.03), WIDTH*0.1)];
    }
    life_name[0].image = you;
    life_name[1].image = rival;
    [self.view addSubview:life_name[0]];
    [self.view addSubview:life_name[1]];
    
    //ライフの表示
    for(int i=0;i<3;i++){//ライフの数
        for(int j=0;j<2;j++){//自分のライフか相手のライフかの判断
            lifeV[i][j] = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.38+(WIDTH*i*0.08), HEIGHT*0.025+(j*HEIGHT*0.04), WIDTH*0.08, WIDTH*0.08)];
            switch (j) {
                case 0://自分のライフ
                    lifeV[i][j].image = life_yes_blue;
                    break;
                case 1://相手のライフ
                    lifeV[i][j].image = life_yes_red;
                    break;
            }
            [self.view addSubview:lifeV[i][j]];
        }
    }
    
    //停止ボタン
    UIImage * image = [UIImage imageNamed:@"stopImage.png"];//画像の取得
    stopButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    stopButton.frame =CGRectMake(10,15,HEIGHT*0.08,HEIGHT*0.08);//位置と大きさ
    [stopButton setBackgroundImage:image forState:UIControlStateNormal];  // 画像をセットす
    [stopButton addTarget:self action:@selector(stopButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    //ボールの色画像を取得
    ball_blue = [UIImage imageNamed:@"ball_blue.png"];
    ball_green = [UIImage imageNamed:@"ball_green.png"];
    ball_orange = [UIImage imageNamed:@"ball_orange.png"];
    ball_red= [UIImage imageNamed:@"ball_red.png"];
    ball_gold = [UIImage imageNamed:@"ball_gold.png"];
    
    //ボールのエフェクト画像を取得
    effect_blue = [UIImage imageNamed:@"effect_blue.png"];
    effect_green = [UIImage imageNamed:@"effect_green.png"];
    effect_orange = [UIImage imageNamed:@"effect_orange.png"];
    effect_red= [UIImage imageNamed:@"effect_red.png"];
    effect_gold= [UIImage imageNamed:@"effect_gold.png"];
    
    ball_blue_five = [UIImage imageNamed:@"ball_blue_five.png"];
    ball_blue_four = [UIImage imageNamed:@"ball_blue_four.png"];
    ball_blue_three = [UIImage imageNamed:@"ball_blue_three.png"];
    ball_blue_two = [UIImage imageNamed:@"ball_blue_two.png"];
    ball_blue_one = [UIImage imageNamed:@"ball_blue_one.png"];
    ball_green_three = [UIImage imageNamed:@"ball_green_three.png"];
    ball_green_two = [UIImage imageNamed:@"ball_green_two.png"];
    ball_green_one = [UIImage imageNamed:@"ball_green_one.png"];
    ball_orange_two = [UIImage imageNamed:@"ball_orange_two.png"];
    ball_orange_one = [UIImage imageNamed:@"ball_orange_one.png"];
    
    //アイテム
    ball_reverse = [UIImage imageNamed:@"ball_reverse.png"];
    ball_speed_up = [UIImage imageNamed:@"ball_speed_up.png"];
    //ball_one_up = [UIImage imageNamed:@"ball_one_up.png"];
    
    
    //コンボを表示するための準備
    combo1 = [UIImage imageNamed:@"combo_1.png"];
    combo2 = [UIImage imageNamed:@"combo_2.png"];
    combo3 = [UIImage imageNamed:@"combo_3.png"];
    combo4 = [UIImage imageNamed:@"combo_4.png"];
    comboMax = [UIImage imageNamed:@"comboMax.png"];
    
    //アイテムボール
    itemBall_blue = [UIImage imageNamed:@"itemBall_blue.png"];
    itemBall_green = [UIImage imageNamed:@"itemBall_green.png"];
    itemBall_orange = [UIImage imageNamed:@"itemBall_orange.png"];
    itemBall_red = [UIImage imageNamed:@"itemBall_red.png"];
    itemBall_golden = [UIImage imageNamed:@"itemBall_golden.png"];
    
    //相手から送られてきたボール
    rival_ball_blue = [UIImage imageNamed:@"rival_ball_blue.png"];
    rival_ball_green = [UIImage imageNamed:@"rival_ball_green.png"];
    rival_ball_orange = [UIImage imageNamed:@"rival_ball_orange.png"];
    rival_ball_red = [UIImage imageNamed:@"rival_ball_red.png"];
    
    
    for(int i=0;i<NUM;i++){
        imageV[i]= [[UIImageView alloc]init];//メモリ割当
        newImageV[i]= [[UIImageView alloc]init];//メモリ割当
    }
    
    for(int i=0;i<NUM2;i++){
        imageV2[i]= [[UIImageView alloc]init];//メモリ割当
        newImageV2[i]= [[UIImageView alloc]init];//メモリ割当
    }
    
    for(int i=0;i<NUM3;i++){
        imageV3[i]= [[UIImageView alloc]init];//メモリ割当
        newImageV3[i]= [[UIImageView alloc]init];//メモリ割当
    }
    
    
    
    [self Store];//ボール15個をいったんすべて保管庫に入れます
    [self Store2];//ボール10個をいったんすべて保管庫に入れます
    [self Store3];//ボール10個をいったんすべて保管庫に入れます
    
    //ストップメニューの準備
    stopMenuV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage * stopMenu = [UIImage imageNamed:@"stopMenu.png"];//画像の取得
    stopMenuV.image = stopMenu;
    //相手側がストップメニューを押したときの表示
    stopMenu2V = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage * please_wait = [UIImage imageNamed:@"please_wait.png"];//画像の取得
    stopMenu2V.image = please_wait;
    
    
    //再開ボタン
    UIImage * restart;
    //接続を切るボタン
    UIImage * cut;
    
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
        restart = [UIImage imageNamed:@"restart.png"];//画像の取得
        cut = [UIImage imageNamed:@"cut.png"];//画像の取得
    } else {
        restart = [UIImage imageNamed:@"restart_eng.png"];//画像の取得
        cut = [UIImage imageNamed:@"cut_eng.png"];//画像の取得
    }
    
    restartBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    [restartBtn setBackgroundImage:restart forState:UIControlStateNormal];  // 画像をセットする
    [restartBtn addTarget:self action:@selector(restartButton) forControlEvents:UIControlEventTouchUpInside];
    
    cutBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    [cutBtn setBackgroundImage:cut forState:UIControlStateNormal];  // 画像をセットする
    [cutBtn addTarget:self action:@selector(cutButton) forControlEvents:UIControlEventTouchUpInside];
    
    /*--------------------------------------チャージ関連---------------------------------------*/
    //チャージビュー
    charge_zero = [UIImage imageNamed:@"charge_zero.png"];
    charge_one = [UIImage imageNamed:@"charge_one.png"];
    charge_two = [UIImage imageNamed:@"charge_two.png"];
    charge_three = [UIImage imageNamed:@"charge_three.png"];
    charge_four = [UIImage imageNamed:@"charge_four.png"];
    charge_five = [UIImage imageNamed:@"charge_five.png"];
    charge_six = [UIImage imageNamed:@"charge_six.png"];
    charge_seven = [UIImage imageNamed:@"charge_seven.png"];
    charge_comp = [UIImage imageNamed:@"charge_comp.png"];
    chargeV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 0.65, HEIGHT*0.016, WIDTH*0.18,  WIDTH*0.18 )];
    chargeV.image = charge_zero;
    [self.view addSubview:chargeV];
    
    //金色の枠
    goldenImage = [UIImage imageNamed:@"golden_frame.png"];
    goldenFrameV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2, HEIGHT*0.035, 0, 0)];
    goldenFrameV.image = goldenImage;
    
    //金色ボールが発射されたときのエフェクト
    golden_effect = [UIImage imageNamed:@"golden_effect.png"];
    golden_effectV = [[UIImageView alloc]init];
    golden_effectV.image = golden_effect;
    
    /*id (^f) (NSString*) = ^(NSString* name) {
        return [UIImage imageNamed:name];
    };*/
    
    //相手のボールトータルの表示
    zero_white = [UIImage imageNamed:@"zero_white.png"];
    one_white = [UIImage imageNamed:@"one_white.png"];
    two_white = [UIImage imageNamed:@"two_white.png"];
    three_white = [UIImage imageNamed:@"three_white.png"];
    four_white = [UIImage imageNamed:@"four_white.png"];
    five_white = [UIImage imageNamed:@"five_white.png"];
    six_white = [UIImage imageNamed:@"six_white.png"];
    seven_white = [UIImage imageNamed:@"seven_white.png"];
    eight_white = [UIImage imageNamed:@"eight_white.png"];
    nine_white = [UIImage imageNamed:@"nine_white.png"];
    many_white = [UIImage imageNamed:@"many_white.png"];
    
    ballTotalV = [[UIImageView alloc]initWithFrame:CGRectMake( WIDTH * 0.85, HEIGHT*0.021, WIDTH*0.13,  WIDTH*0.16 )];
    ballTotalV.image = zero_white;
    [self.view addSubview:ballTotalV];
    
    //イベントが起きた時
    eventV = [[UIImageView alloc]init];
    reverse_alert = [UIImage imageNamed:@"reverse_alert.png"];
    speed_up_alert = [UIImage imageNamed:@"speed_up_alert.png"];
    
    
    //bluetoothをつないでない状態
    /*[self ReadyGo];
     [bgm BGM_play];*/
    
}


/*--------------------------------------bluetooth関連-------------------------------------*/

-(void)startPicker{
    // ピアピッカーを表示
    self.picker = [[GKPeerPickerController alloc] init];
    self.picker.delegate = self;
    // 接続タイプはBluetoothのみ
    self.picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    // ピアピッカーを表示
    [self.picker show];
    
    //  NSLog(@"BlueToothつなぎます");
    
}

// ピアの接続がキャンセルされたときに呼ばれるメソッド
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
    // The controller dismisses the dialog automatically.
    
    isCut = true;
    [self sendData];
    
    [self finish];
    
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    vc0.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc0 animated:YES completion:nil];
}

//接続が完了したら呼ばれるメソッド
- (void)peerPickerController:(GKPeerPickerController *)picker
              didConnectPeer:(NSString *)peerID
                   toSession:(GKSession *)session
{
    // セッションを保管
    self.currentSession = session;
    // デリゲートのセット
    session.delegate = self;
    // データ受信時のハンドラを設定
    [session setDataReceiveHandler:self withContext:nil];
    
    // ピアピッカーを閉じる
    picker.delegate = nil;
    [picker dismiss];
    
    //NSLog(@"接続完了！！");
    
    //つながったらカウントダウンが始まる
    [self ReadyGo];
    [bgm BGM_play];
    
    
}

/*----------------------------------------------スタート前の準備--------------------------------------*/
//3,2,1のカウントダウンの準備

-(void)ReadyGo{
    
    isCountDown = true;//カウントダウンが終わっていない状態
    
    CountDownV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 0.2, HEIGHT*0.35, WIDTH*0.625, HEIGHT*0.35)];
    three = [UIImage imageNamed:@"three.png"];//画像の取得
    two = [UIImage imageNamed:@"two.png"];//画像の取得
    one = [UIImage imageNamed:@"one.png"];//画像の取得
    go = [UIImage imageNamed:@"go.png"];//画像の取得
    
    //カウントダウンタイマーを作成してスタート
    countDownT =
    [NSTimer
     scheduledTimerWithTimeInterval:1.0f
     target:self
     selector:@selector(countDown:)
     userInfo:nil
     repeats:YES
     ];
}


//3,2,1のカウントダウン

-(void)countDown:(NSTimer*)timer{
    
    countDownSec --;
    
    
    switch(countDownSec){
            
        case 3:
            
            CountDownV.image = three;
            [self.view addSubview:CountDownV];
            [sound countDown_sound];
            break;
            
        case 2:
            
            CountDownV.image = two;
            [self.view addSubview:CountDownV];
            [sound countDown_sound];
            break;
            
        case 1:
            
            CountDownV.image = one;
            [self.view addSubview:CountDownV];
            [sound countDown_sound];
            break;
            
        case 0:
            
            CountDownV.image = go;
            [self.view addSubview:CountDownV];
            [sound go_sound];
            
            [countDownT invalidate];//カウントダウンタイマーを停止
            countDownT =nil;
            
            
            //メインタイマーを作成してスタート
            tm =
            [NSTimer
             scheduledTimerWithTimeInterval:0.005f
             target:self
             selector:@selector(move:)
             userInfo:nil
             repeats:YES
             ];
            
            //CPUメインタイマーを作成してスタート
            CPUtm = [NSTimer
             scheduledTimerWithTimeInterval:0.02f
             target:self
             selector:@selector(moveCPU:)
             userInfo:nil
             repeats:YES
             ];
                
            CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
            CGAffineTransform t2 = CGAffineTransformScale(t1,2.0, 2.0);
            
            [UIView animateWithDuration:0.7f
                                  delay:0.0f
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^(void){
                                 
                                 CountDownV.transform = t2;
                                 [self.view addSubview:CountDownV];
                                 CountDownV.alpha = 0.0;
                             }
                             completion:^(BOOL finished){//処理が終わったら
                                 CountDownV = nil;
                             }];
            
            
            isCountDown = false;//カウントダウンが終わった状態
            
            break;
    }
}


//ボールを保管庫に格納(メモリの削減)

-(void)Store{
    
    for(int i=0;i<NUM;i++){
        ballX[i] = storageX;//一旦すべて保管庫へ
        ballY[i] = storageY;//一旦すべて保管庫へ
    }
}


//ボールが保管庫に入っているか否か
-(BOOL)isInStorage{
    
    if(ballX[num] == storageX && ballY[num] == storageY){
        return true;
    }
    return false;
}

//ボールを初期化する

-(void)ballReset{
    
    size[num]  = 20;//最初のサイズは20
    imageV[num].image = ball_blue;//初期化の色は青
    dy[num] = 2.0;//速度の初期化
    [self.view addSubview:imageV[num]];//imageVを表示
    isFire[num] = false;//ボールは発射されていない
    colorJudge[num] =1;//デフォルトは1に設定
}

/*-----------------------------------------currentSessionにデータを送信------------------------------*/
//NSData型に変換してデータを送信する
-(void)sendData{
    
    if(isCut){
        NSData *cutData = [@"cut" dataUsingEncoding:NSUTF8StringEncoding];
        [self mySendDataToPeers:cutData];
    }
    
}

-(void)sendData_stop{
    
    NSData * stopData;
    
    if(isStop){
        stopData = [@"stop_yes" dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        stopData = [@"stop_no" dataUsingEncoding:NSUTF8StringEncoding];
    }
    [self mySendDataToPeers:stopData];
    
}

-(void)sendData_life:(int)lifeCount{
    
    NSData * lifeData;
    switch (lifeCount) {
        case 3:
            lifeData = [@"lifeChange_3" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 2:
            lifeData = [@"lifeChange_2" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 1:
            lifeData = [@"lifeChange_1" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 0:
            lifeData = [@"lifeChange_0" dataUsingEncoding: NSUTF8StringEncoding];
            break;
    }
    
    [self mySendDataToPeers:lifeData];
    
}

-(void)sendData_ball:(int)ball_id{
    
    NSData * ballData;
    switch (ball_id) {
        case 1://blue
            ballData = [@"ballComing_blue" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 2://green
            ballData = [@"ballComing_green" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 3://orange
            ballData = [@"ballComing_orange" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 4://red
            ballData = [@"ballComing_red" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 5://blue*5
            ballData = [@"ballComing_blue_5" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 6://blue*3
            ballData = [@"ballComing_blue_3" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 7://green*3
            ballData = [@"ballComing_green_3" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 8://orange*4
            ballData = [@"ballComing_orange_2" dataUsingEncoding: NSUTF8StringEncoding];
            break;
       
        case 10://reverse
            ballData = [@"ballComing_reverse" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 11://speed_up
            ballData = [@"ballComing_speed_up" dataUsingEncoding: NSUTF8StringEncoding];
            break;
    }
    
    [self mySendDataToPeers:ballData];
    
}

-(void)sendData_ballTotal:(int)num{
    
    NSData * ballTotalData;
    
    switch (num) {
        case 0:
            ballTotalData = [@"ballTotal_0" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 1:
            ballTotalData = [@"ballTotal_1" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 2:
            ballTotalData = [@"ballTotal_2" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 3:
            ballTotalData = [@"ballTotal_3" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 4:
            ballTotalData = [@"ballTotal_4" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 5:
            ballTotalData = [@"ballTotal_5" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 6:
            ballTotalData = [@"ballTotal_6" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 7:
            ballTotalData = [@"ballTotal_7" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 8:
            ballTotalData = [@"ballTotal_8" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        case 9:
            ballTotalData = [@"ballTotal_9" dataUsingEncoding: NSUTF8StringEncoding];
            break;
        default:
            ballTotalData = [@"ballTotal_many" dataUsingEncoding: NSUTF8StringEncoding];
            break;
    }
    [self mySendDataToPeers:ballTotalData];
}

//つながっているセッションにデータを送信する
- (void) mySendDataToPeers: (NSData *) data
{
    [self.currentSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}


//データの受け取り側
-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    
    //NSLog(@"recieve");
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    if([string isEqualToString:@"cut"]){
        //NSLog(@"切断されました");
        [self bluetooth_cut];
    }
    
    if([string hasPrefix:@"stop"]){
        if([string isEqualToString:@"stop_yes"]){
            [self bluetooth_stop];
           // NSLog(@"stop");
        }else{
            [self bluetooth_restart];
           // NSLog(@"start");
        }
    }
    
    if([string hasPrefix:@"lifeChange"]){
        
        if([string isEqualToString:@"lifeChange_3"]){
            [self lifeChange:3];
        }else if([string isEqualToString:@"lifeChange_2"]){
            [self lifeChange:2];
        }else if([string isEqualToString:@"lifeChange_1"]){
            [self lifeChange:1];
        }else{
            [self lifeChange:0];
        }
    }
    
    if([string hasPrefix:@"ballComing"]){
        
        rivalBall = true;//ボールが送られてきたか否かの判定
        //NSLog(@"rivalball : %d",rivalBall);
        
        /*colorJudge2
         1,5,6 : blue
         2,7 : green
         3,8 : orange
         4 : red
         */
        
        if([string isEqualToString:@"ballComing_blue"]){//blue
            size2[num2] = arc4random_uniform(9)+30;//30~39
            colorJudge2[num2] =1;
            imageV2[num2].image = rival_ball_blue;
        }else if([string isEqualToString:@"ballComing_blue_5"]){//blue*5
            size2[num2] = 39;
            colorJudge2[num2] =5;
            imageV2[num2].image = ball_blue_five;
        }else if([string isEqualToString:@"ballComing_blue_3"]){//blue*3
            size2[num2] = 39;
            colorJudge2[num2] =6;
            imageV2[num2].image = ball_blue_three;
        }else if([string isEqualToString:@"ballComing_green"]){//green
            size2[num2] = arc4random_uniform(19)+40;//40~59
            colorJudge2[num2] =2;
            imageV2[num2].image = rival_ball_green;
        }else if([string isEqualToString:@"ballComing_green_3"]){//green*3
            size2[num2] = arc4random_uniform(19)+40;//40~59
            colorJudge2[num2] =7;
            imageV2[num2].image = ball_green_three;
        }else if([string isEqualToString:@"ballComing_orange"]){//orange
            size2[num2] = arc4random_uniform(19)+60;//60~79
            colorJudge2[num2] =3;
            imageV2[num2].image = rival_ball_orange;
        }else if([string isEqualToString:@"ballComing_orange_2"]){//orange*2
            size2[num2] = arc4random_uniform(19)+60;//60~79
            colorJudge2[num2] =8;
            imageV2[num2].image = ball_orange_two;
        }else if([string isEqualToString:@"ballComing_red"]){//red
            size2[num2] = arc4random_uniform(15)+80;//80~15
            colorJudge2[num2] =4;
            imageV2[num2].image = rival_ball_red;
        }else if([string isEqualToString:@"ballComing_reverse"]){
            isReverse = true;
            [self event_animation:0];
        }else if([string isEqualToString:@"ballComing_speed_up"]){
            isSpeed_up = true;
            [self event_animation:1];
        }
    }
    
    if([string hasPrefix:@"ballTotal"]){
        if([string isEqualToString:@"ballTotal_0"]){
            [self ballTotal_count:0];
        }else if([string isEqualToString:@"ballTotal_1"]){
            [self ballTotal_count:1];
        }else if([string isEqualToString:@"ballTotal_2"]){
            [self ballTotal_count:2];
        }else if([string isEqualToString:@"ballTotal_3"]){
            [self ballTotal_count:3];
        }else if([string isEqualToString:@"ballTotal_4"]){
            [self ballTotal_count:4];
        }else if([string isEqualToString:@"ballTotal_5"]){
            [self ballTotal_count:5];
        }else if([string isEqualToString:@"ballTotal_6"]){
            [self ballTotal_count:6];
        }else if([string isEqualToString:@"ballTotal_7"]){
            [self ballTotal_count:7];
        }else if([string isEqualToString:@"ballTotal_8"]){
            [self ballTotal_count:8];
        }else if([string isEqualToString:@"ballTotal_9"]){
            [self ballTotal_count:9];
        }else{
            [self ballTotal_count:10];//many
        }
    }
    
}

//接続を解除されたときの処理
-(void)bluetooth_cut{
    
    [self finish];
    UIAlertView *  av;
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
        av = [[UIAlertView alloc] initWithTitle:@"接続エラー" message:@"相手が接続を切りました"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }else{
        av = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your partner disconnected"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    [av show];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    delegate.win_lost_bluetooth = @"win";
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    vc2_2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
}

//bluetoothの停止と開始のメソッド（stopbuttonとcutButtonだと再起的に何度も呼ばれてしまうためNG）
-(void)bluetooth_stop{
    
    if(!isStop){
        
         isStop = true;
        
        [sound release_sound];
        stopMenu2V.frame = self.view.bounds;
        [self.view addSubview:stopMenu2V];
        
        //すべてのタイマーを一時停止
        [tm invalidate];
        [tmSize invalidate];
        [CPUtm invalidate];
        [countDownT invalidate];
        [bgm BGM_pause];
    }
}

-(void)bluetooth_restart{
    [sound button_sound];
    
     isStop = false;
    
    //カウントダウンの途中だったらカウントダウンタイマーを再稼働
    if(isCountDown){
        countDownT=
        [NSTimer
         scheduledTimerWithTimeInterval:1.0f
         target:self
         selector:@selector(countDown:)
         userInfo:nil
         repeats:YES
         ];
    }else{//カウントダウンが終わっていたら
        //主要タイマーを再稼働
        tm =
        [NSTimer
         scheduledTimerWithTimeInterval:0.005f
         target:self
         selector:@selector(move:)
         userInfo:nil
         repeats:YES
         ];
        
        //CPUタイマーを再稼働
        CPUtm =
        [NSTimer
         scheduledTimerWithTimeInterval:0.02f
         target:self
         selector:@selector(moveCPU:)
         userInfo:nil
         repeats:YES
         ];
    }
    stopMenu2V.frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
    [self.view addSubview:stopMenu2V];
    [bgm BGM_play];
}
//lifeChangeがあったときの処理
-(void)lifeChange:(int) lifeCount{
    
    // NSLog(@"lifeCount :%d",lifeCount);
    
    switch (lifeCount) {
        case 3:
            for(int i=0;i<3;i++){
                lifeV[i][1].image  = life_yes_red;
            }
           
            break;
        case 2:
            for(int i=0;i<2;i++){
                lifeV[i][1].image  = life_yes_red;
            }
             lifeV[2][1].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
            break;
        case 1:
            lifeV[0][1].image  = life_yes_red;
              lifeV[1][1].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
            break;
        case 0:
            //NSLog(@"あなたの勝ち");
             lifeV[0][1].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
             [self.view addSubview:lifeV[0][1]];
            [self finish];
            
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
            delegate.win_lost_bluetooth = @"win";
            
            UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
            vc2_2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:vc2_2 animated:YES completion:nil];
            
            break;
    }
    
    [self lifeDisapper_animation:lifeCount int:1];
    
    for(int i=0;i<3;i++){
        [self.view addSubview:lifeV[i][1]];
    }
}

-(void)ballTotal_count:(int) num{
    
    switch (num) {
        case 0:
            ballTotalV.image = zero_white;
            break;
        case 1:
            ballTotalV.image = one_white;
            break;
        case 2:
            ballTotalV.image = two_white;
            break;
        case 3:
            ballTotalV.image = three_white;
            break;
        case 4:
            ballTotalV.image = four_white;
            break;
        case 5:
            ballTotalV.image = five_white;
            break;
        case 6:
            ballTotalV.image = six_white;
            break;
        case 7:
            ballTotalV.image = seven_white;
            break;
        case 8:
            ballTotalV.image = eight_white;
            break;
        case 9:
            ballTotalV.image = nine_white;
            break;
        default://many
            ballTotalV.image = many_white;
            break;
    }
    [self.view addSubview:ballTotalV];
}


/*------------------------------------------------機能全般----------------------------------------------*/

//終了メソッド

-(void)finish{
    
    [tm invalidate];//タイマーを破棄しただけでオブジェクト自体は残っている
    tm = nil;//完全に初期化
    [tmSize invalidate];
    tmSize = nil;
    [CPUtm invalidate];
    CPUtm = nil;
    [countDownT invalidate];
    countDownT = nil;
    
    [bgm BGM_stop];;//BGMのストップ
    
}


//停止ボタンをおした時の画面
-(void)stopMenu{
    
    isStop = true;//ストップメニューが開いている状態
    
    stopMenuV.frame = self.view.bounds;
    [self.view addSubview:stopMenuV];
    
    restartBtn.frame =CGRectMake(WIDTH*0.31,HEIGHT*0.4,WIDTH*0.375,HEIGHT*0.09);//位置と大きさ
    cutBtn.frame =CGRectMake(WIDTH*0.31,HEIGHT*0.6,WIDTH*0.375,HEIGHT*0.09);//位置と大きさ
    [self.view addSubview:restartBtn];
    [self.view addSubview:cutBtn];
    
}

//停止ボタンを隠します
-(void)stopMenu_hide{
    
    isStop = false;//ストップメニューが閉じた状態
    
    stopMenuV.frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
    [self.view addSubview:stopMenuV];
    
    restartBtn.frame =CGRectMake(WIDTH, HEIGHT, 0, 0);//位置と大きさ
    cutBtn.frame =CGRectMake(WIDTH, HEIGHT, 0, 0);//位置と大きさ
    [self.view addSubview:restartBtn];
    [self.view addSubview:cutBtn];
}

//停止ボタンが押されたら

- (void)stopButton{
    
    if(!isStop){
        
        [sound release_sound];
        
        [self stopMenu];
        
        //相手側にも送信
        [self sendData_stop];
        
        
        //すべてのタイマーを一時停止
        [tm invalidate];
        [tmSize invalidate];
        [CPUtm invalidate];
        [countDownT invalidate];
        
        [bgm BGM_pause];
    }
}

-(void)cutButton{
    
    [sound button_sound];
    isCut = true;
    
    if (self.currentSession)
    {
        
        [self sendData];
        // PtoP接続を切断する
        [self.currentSession disconnectFromAllPeers];
        self.currentSession = nil;
        //NSLog(@"切断されました");
    }
    [self finish];
    
    UIAlertView *  av;
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
        av = [[UIAlertView alloc] initWithTitle:@"" message:@"接続を切りました"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }else{
        av = [[UIAlertView alloc] initWithTitle:@"" message:@"Disconnected BlueTooth"
                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    [av show];

    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    [self presentViewController:vc0 animated:YES completion:nil];
    
}

//再開ボタンが押されたら

-(void)restartButton{
    
    [sound button_sound];
    
    //カウントダウンの途中だったらカウントダウンタイマーを再稼働
    if(isCountDown){
        countDownT=
        [NSTimer
         scheduledTimerWithTimeInterval:1.0f
         target:self
         selector:@selector(countDown:)
         userInfo:nil
         repeats:YES
         ];
    }else{//カウントダウンが終わっていたら
        //主要タイマーを再稼働
        tm =
        [NSTimer
         scheduledTimerWithTimeInterval:0.005f
         target:self
         selector:@selector(move:)
         userInfo:nil
         repeats:YES
         ];
        
        //CPUタイマーを再稼働
        CPUtm =
        [NSTimer
         scheduledTimerWithTimeInterval:0.02f
         target:self
         selector:@selector(moveCPU:)
         userInfo:nil
         repeats:YES
         ];
    }
    
    [self stopMenu_hide];
    
    [self sendData_stop];//再起的に何度も呼ばれてしまっているため
    
    [bgm BGM_play];
}

/*----------------------------------------処理全般--------------------------------------*/
//タップした時の処理

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    // シングルタッチの場合
    
    UITouch *touch = [touches anyObject];
    
    location = [touch locationInView:self.view];//タッチされた座標を取得
    
    
    //ストップメニューが開かれていなかったら and カウントダウンが終わったら
    
    if(!isStop && !isCountDown){
        
        if(CGRectContainsPoint(CGRectMake(0, HEIGHT*0.92, WIDTH, HEIGHT),location)){//指定された場所でのみ生成
            
            touchField = YES;//指定の場所でボールを生成したらYES
            
            
            //保管庫にボールが入っていればボールを生成(最後のボールが画面外に出たら)
            
            if([self isInStorage]){
                
                [self ballReset];//ボールを初期化する
                [self sizeChange];//押している間は増加する
                
                ballX[num] = location.x - (size[num]/2);//矩形の左側をballXとする
                ballY[num] = location.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
                isNotMove = true;//動いていない
            }
        }
    }
}

//金ボール生成メソッド
-(void)goldenBall{
    
    imageV[num].image = ball_gold; //gold
    dy[num] = 0.7;//金ボールだけ遅め
    colorJudge[num] =5;
    size[num] = 100;
    ballX[num] = location.x - (size[num]/2);//矩形の左側をballXとする
    ballY[num] = location.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
    imageV[num].frame = CGRectMake(ballX[num],ballY[num],size[num],size[num]);
    [self.view addSubview:imageV[num]];//imageVを表示
    isFire[num] = false;//ボールは発射されていない
}

//ボールのサイズを変えるメソッド
-(void)sizeChange{
    //タイマーを作成してスタート
    tmSize =
    [NSTimer
     scheduledTimerWithTimeInterval:0.007f
     target:self
     selector:@selector(bigger_or_smaller:)
     userInfo:nil
     repeats:YES
     ];
}

// ボールが大きくなるbiggerメソッド
-(void)bigger_or_smaller:(NSTimer*)timer{
    
    //NSLog(@"sizeChange %d",num);
    
    if(!isReverse){
        size[num] ++;
    }else{
        size[num] --;
    }

    
    //止まっている状態の場合（ドラッグしていない状態）
    if(isNotMove ==true){
        ballX[num] = location.x -(size[num]/2);
        ballY[num] = location.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
    }else{//ドラッグしている状態
        ballX[num] = newLocation.x -(size[num]/2);
        ballY[num] = newLocation.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
    }
    
    if(!isReverse){
        if(size[num] == 30){
            
            [sound bigger_sound];
        }
    }else{
        if(size[num] == 90){
            
            [sound smaller_sound];
        }
    }

    
    //横の壁にあたったら反射
    
    if(ballX[num] <0){
        
        ballX[num] = 0;
        
    }else if(ballX[num] + size[num] >WIDTH){
        
        ballX[num] = WIDTH - size[num];
        
    }else{}
    
    if(!isReverse){
        //sizeが99になったら20に戻す
        if(size[num] > 100){
            
            size[num] = 20;
        }
    }else{
        //sizeが20になったら99に戻す
        if(size[num] < 21){
            
            size[num] = 99;
        }
    }
    
    dy[num] =2.0;//ボールの速さ（金ボール以外）
    
    
    if(size[num]<40){//青:20~39
        imageV[num].image = ball_blue; //blue
        colorJudge[num] =1;
    }else if(size[num] < 60){//緑:40~59
        imageV[num].image = ball_green; //green
        colorJudge[num] =2;
    }else if(size[num] < 80){//オレンジ:60~79
        imageV[num].image = ball_orange; //orange
        colorJudge[num] =3;
    }else{//赤:80~99
        imageV[num].image = ball_red; //red
        colorJudge[num] =4;
    }
    
    imageV[num].frame = CGRectMake(ballX[num],ballY[num],size[num],size[num]);
    [self.view addSubview:imageV[num]];
    
}

//指を離した時の処理

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [tmSize invalidate];//指を離したらそのボールのサイズ変更終了
    [sound bigger_sound_stop];
    
    UITouch * touchEnded = [touches anyObject];
    location2 = [touchEnded locationInView:self.view];
    
    //生成場所が指定の枠内であったら
    if(touchField){
        
        if(location2.y > location.y && location2.y > HEIGHT && isGolden  ){
            
            [self goldenBall];
            chargeCount = 0;//チャージカウントの初期化
            
            //金色ボールのエフェクト
            golden_effectV.frame = self.view.bounds;
            [self.view addSubview:golden_effectV];
            
            //金色フレームを隠す
            goldenFrameV.frame = CGRectMake(WIDTH/2, HEIGHT*0.035, 0, 0);
            [self.view addSubview:goldenFrameV];
            goldenFrameV = nil;
            goldenFrameV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2, HEIGHT*0.035, 0, 0)];
            goldenFrameV.image = goldenImage;
            
            
            [self chargeMake];
            isGolden = false;
            
        }
        
        isFire[num] = true;//ボールが発射された
        
        //衝突判定用のtempSizeを作成(表示はしません)
        tempSize[num] = size[num]/4;
        
        if(colorJudge[num] == 5){
            [sound launch2_sound];
        }else{
            [sound launch_sound];
        }
        
        num++;//指を離したらnumをインクリメント
        
        if(num == NUM){
            
            num = 0;//numを初期化
        }
        
    }else{}
    touchField = false;
}

// ボールの移動

-(void)move:(NSTimer*)timer{
    
    for(int i=0;i<NUM;i++){
        
        if(isFire[i]){//ボールが発射された場合
            
            if(ballY[i]>HEIGHT*0.07){//画面内にあったら
                
                ballY[i] -= dy[i];
                
            }else{//画面の外に出たら保管庫に戻す
                
                if(colorJudge[i] == 5){//金色ボールが外に出たらエフェクトを消す
                    golden_effectV.frame = CGRectMake(0, 0, 0, 0);
                    [self.view addSubview:golden_effectV];
                }
                
                ballX[i] = storageX;
                ballY[i] = storageY;
                isFire[i] = false;
                
                //キンボール以外のときにコンボをリセット
                if(colorJudge[i] !=5){
                    comboCount = 0;
                }
            }
            
            imageV[i].frame = CGRectMake(ballX[i],ballY[i],size[i],size[i]);
            [self.view addSubview:imageV[i]];
        }
    }
}



//タッチをしている状態で指を動かした時

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //生成場所が指定の枠内であったら
    
    if(touchField){
        
        
        UITouch *touch = [touches anyObject];
        newLocation = [touch locationInView:self.view];
        
        if(CGRectContainsPoint(CGRectMake(0, HEIGHT*0.92, WIDTH, HEIGHT),newLocation)){//指定された場所でのみ生成可能
            
            ballX[num] = newLocation.x -(size[num]/2);
            ballY[num] = newLocation.y -(size[num]/2)-50;
            
            imageV[num].frame = CGRectMake(ballX[num], ballY[num], size[num], size[num]);
            
            isNotMove = false;//動いている
        }
    }
}

/*--------------------------------------CPU関連---------------------------------------*/

//ボールを保管庫に格納(メモリの削減)

-(void)Store2{
    
    for(int i=0;i<NUM2;i++){
        
        ballX2[i] = storageX2;//一旦すべて-500に配置される
        ballY2[i] = storageY2;//一旦すべて-500に配置される
    }
}


//ボールが保管庫に入っているか否か

-(BOOL)isInStorage2{
    
    if(ballX2[num2] == storageX2 && ballY2[num2] == storageY2){
        return true;
    }
    return false;
}



//呼ばれるmoveメソッド

-(void)moveCPU:(NSTimer*)timer{
    
    a++;
    
    if(a% 3000 == 0 || a==1){
        
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
        delegate.totalTime = [NSString stringWithFormat:@"%d",a];
        
        NSArray * array =  [difficulty battleMode];
        //リストの最初の要素（生成頻度）を取り出す
        NSString *oftenS = [array objectAtIndex:0];
        //リストの2番目の要素（生成頻度）を取り出す
        NSString *alphaS = [array objectAtIndex:1];
        often_global = [oftenS intValue];
        alpha_global = [alphaS floatValue];
        
    }
    
    //イベント中に音が鳴る
    if(isSpeed_up || isReverse){
        if(a%30 == 0){
            [sound event_sound];
        }
    }
    

    [self ballProduce:often_global int:alpha_global];
    
    
    
    for(int i=0;i<NUM2;i++){
        
        if(ballY2[i]+size2[i]<HEIGHT*0.95){//保管庫のy座標と相談が必要
            
           if(isSpeed_up){
                ballY2[i] += (dy2[i]+0.5);
            }else{
                ballY2[i] += dy2[i];
            }
            
            //ランダム
            if(vertical[i] == 0){//vertical が0の場合, 直で落ちてくる
                dx2[i] = 0;
            }else{
                if(isSpeed_up){
                    if(dx2[i]>0){
                           ballX2[i] += (dx2[i]+0.4);
                    }else{
                           ballX2[i] += (dx2[i]-0.4);
                    }
                }else{
                ballX2[i] += dx2[i];
                }
            }
            
            //跳ね返り
            if(ballX2[i]<0 || ballX2[i]+size2[i]>WIDTH){
                
                    dx2[i] = -dx2[i];
            }
            
        }else if(ballX2[i] == storageX2 && ballY2[i] == storageY2){
            
        }else{//自分のエリアに3回ボールが入ってしまったら終了
            
            [self lifeDisapper_animation:lifeCount int:0];
            
            switch (lifeCount) {
                case 3:
                    lifeCount = 2;
                    
                    for(int i=0;i<2;i++){
                        lifeV[i][0].image = life_yes_blue;
                    }
                    lifeV[2][0].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
                    
                    break;
                case 2:
                    lifeCount = 1;
                    
                    lifeV[0][0].image = life_yes_blue;
                    lifeV[1][0].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
                    
                    break;
                case 1:
                    lifeV[0][0].frame = CGRectMake(WIDTH, HEIGHT, 0, 0);
                     [self.view addSubview:lifeV[0][0]];
                    lifeCount = 0;
           
                    //NSLog(@"あなたの負け");
                    [self finish];
                    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
                    delegate.win_lost_bluetooth = @"lost";
                    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
                    vc2_2.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:vc2_2 animated:YES completion:nil];
                    
                    break;
            }
            
            lifeChange = true;
            [self sendData_life:lifeCount];
            
            
            for(int i=0;i<3;i++){
                [self.view addSubview:lifeV[i][0]];
            }
            
            ballX2[i] = storageX2;
            ballY2[i] = storageY2;
            
        }
        
        imageV2[i].frame = CGRectMake(ballX2[i],ballY2[i],size2[i],size2[i]);
        [self.view addSubview:imageV2[i]];
        
    }
    [self Collision];//当たり判定
    
    /*------------------------------------ItemBallの動き-------------------------------*/
    for(int i=0;i<NUM3;i++){
        
        if(ballY3[i] > 0 ){//保管庫のy座標と相談が必要(画面に出ているItemBallのみ)
            
            ballX3[i] += dx3[i];
            ballY3[i] += dy3[i];
            itemCount[i] ++;
            
            //跳ね返り
            if(ballX3[i]<0 || ballX3[i]+size3[i]>WIDTH){
                
                dx3[i] = -dx3[i];
            }
            
            if(ballY3[i]< HEIGHT*0.075 || ballY3[i] + size3[i] >HEIGHT/2){
                dy3[i] = -dy3[i];
            }
            
        }
        
        if(ballY3[i] > 0 && itemCount[i] > 1000){
            ballX3[i] = storageX3;
            ballY3[i] = storageY3;
            itemCount[i] = 0;//アイテムカウントを戻す
            
            if(colorJudge3[i] == 5){
            isItemBall_gold = false;
            }
            
            /*NSLog(@"ballX3[%d] : %f",i,ballX3[i] );
             NSLog(@"ballY3[%d] : %f",i,ballY3[i] );
             NSLog(@"itemCount[%d] : %d",i,itemCount[i]);*/
        }
        
        
        imageV3[i].frame = CGRectMake(ballX3[i], ballY3[i], size3[i], size3[i]);
        [self.view addSubview:imageV3[i]];//imageV3を表示
    }
    
    [self Collision_Item];
}

//ボールの生成
-(void)ballProduce:(int)b int:(float) alpha{
    
    //保管庫にボールが入っていればボールを生成
    
    if([self isInStorage2]){
        
        
        if(a%b == 0 || a ==1 || rivalBall){//ボールの生成頻度
            
            ballX2[num2] = arc4random_uniform(WIDTH);
            vertical[num2]  = arc4random_uniform(5);//0も含まれる
            
            if(!rivalBall){
                size2[num2] = arc4random_uniform(65)+30;//赤を少し少なめ
                ballY2[num2] = HEIGHT*0.07;
            }else{//相手から送られてきたボールのとき(sizeは既に決まっている)
                ballY2[num2] = HEIGHT*0.05;
                blue_number_judge[num2] = 0;
                green_number_judge[num2] = 0;
                orange_number_judge[num2] = 0;
                blue_number_judge2[num2] = 0;
                imageV2[num2].alpha = 0.0;
                
            }
            
            //衝突判定用のtempSize2(表示はしません)
            tempSize2[num2] = size2[num2]/4;
            
            if(ballX2[num2] <0){
                ballX2[num2] = 0;
            }else if(ballX2[num2] + size2[num2] >WIDTH){
                ballX2[num2] = WIDTH - size2[num2];
            }else{}
            
            if(size2[num2]< 40){
                
                dy2[num2] =1.0 + alpha;
                dx2[num2] = 1.0 + alpha|| -1.0 - alpha;
                
                if(!rivalBall){
                    imageV2[num2].image = ball_blue; //blue
                    colorJudge2[num2] =1;
                }else{//ライバルボールの時
                    if(colorJudge2[num2] == 1){//通常のライバルボールのみ
                        dy2[num2] =1.2 + alpha;
                        dx2[num2] = 1.2 + alpha|| -1.2 - alpha;
                    }
                }
                
            }else if(size2[num2] < 60){
                
                dy2[num2] = 0.8 + alpha;
                dx2[num2] = 0.8 + alpha || -0.8 - alpha;
                
                if(!rivalBall){
                    imageV2[num2].image = ball_green; //green
                    colorJudge2[num2] =2;
                }else{//ライバルボールの時
                    if(colorJudge2[num2] == 2){//通常のライバルボールのみ
                        dy2[num2] = 1.0 + alpha;
                        dx2[num2] = 1.0 + alpha || -1.0 - alpha;
                    }
                }
                
            }else if(size2[num2] < 80){
                
                dy2[num2] = 0.7 + alpha;
                dx2[num2] = 0.7 +alpha  || -0.7 - alpha;
                
                if(!rivalBall){
                    imageV2[num2].image = ball_orange; //orange
                    colorJudge2[num2] =3;
                }else{//ライバルボールの時
                    if(colorJudge2[num2] == 3){//通常のライバルボールのみ
                        dy2[num2] = 0.9 + alpha;
                        dx2[num2] = 0.9 +alpha  || -0.9- alpha;

                    }
                }
        
            }else{
                
                dy2[num2] = 0.5 + alpha;
                dx2[num2] = 0.5 + alpha || -0.5 -alpha;

                if(!rivalBall){
                    imageV2[num2].image = ball_red; //red
                    colorJudge2[num2] =4;
                }else{//ライバルボールの時
                    if(colorJudge2[num2] == 4){//通常のライバルボールのみ
                        dy2[num2] = 0.7 + alpha;
                        dx2[num2] = 0.7 + alpha || -0.7 -alpha;

                    }
                }

            }
            
            if(rivalBall){//相手から送られてきたボールはアニメーションつきで生成される
                [self ballAppear_animation_rival:colorJudge2[num2] int:ballX2[num2] float:HEIGHT*0.075 float:size2[num2]];
            }else{
                   [self ballAppear_animation_normal:colorJudge2[num2] int:ballX2[num2] float:ballY2[num2] float:(int)size2[num2]];
            imageV2[num2].frame = CGRectMake(ballX2[num2],ballY2[num2],size2[num2],size2[num2]);
                  [self.view addSubview:imageV2[num2]];
            }
            
            if(num2 ==NUM2-1) {
                num2= 0;//初期化
            }else{
                num2++;
            }
            
            
            if(rivalBall){
                rivalBall = false;
            }
            
            ball_total ++;
            if(!isStop){
                [self sendData_ballTotal : ball_total];
            }
        }
    }
}

-(void)ballAppear_animation_normal:(int) color int:(float)xPos float:(float) yPos float: (int)size2{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,0.0, 0.0);
    
    /*color
     1,5,6 : blue
     2,7 : green
     3,8 : orange
     4 : red
     */
    
    
    UIImageView * ballAppearV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos-size2/4, yPos-size2/4, size2*1.5, size2*1.5)];
    
    if(color == 1 || color == 5 || color ==6){//blue
        ballAppearV.image = effect_blue;
    }else if(color == 2 || color == 7){//green
        ballAppearV.image = effect_green;
    }else if(color == 3 || color == 8){//orange
        ballAppearV.image = effect_orange;
    }else if(color == 4){//red
        ballAppearV.image = effect_red;
    }
    
    
    [UIView animateWithDuration:0.8f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         ballAppearV.transform = t2;
                         [self.view addSubview:ballAppearV];
                         ballAppearV.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         
                     }];
    
}




-(void)ballAppear_animation_rival:(int) color int:(float)xPos float:(float)yPos float:(int)size2{
    
    /*color
     1,5,6 : blue
     2,7 : green
     3,8 : orange
     4 : red
     */
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,0.0, 0.0);
    
    UIImageView * ballFallsV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2,-100, size2, size2)];
    
    if(color == 1 || color == 5 || color ==6){//blue
        ballFallsV.image = rival_ball_blue;
    }else if(color == 2 || color == 7){//green
        ballFallsV.image = rival_ball_green;
    }else if(color == 3 || color == 8){//orange
        ballFallsV.image = rival_ball_orange;
    }else if(color == 4){//red
        ballFallsV.image = rival_ball_red;
    }
    
    UIImageView * ballAppearV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos-size2/4, yPos-size2/4, size2*1.5, size2*1.5)];
    
    if(color == 1 || color == 5 || color ==6){//blue
        ballAppearV.image = effect_blue;
    }else if(color == 2 || color == 7){//green
        ballAppearV.image = effect_green;
    }else if(color == 3 || color == 8){//orange
        ballAppearV.image = effect_orange;
    }else if(color == 4){//red
        ballAppearV.image = effect_red;
    }
    
    [UIView animateWithDuration:0.4f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         ballFallsV.frame = CGRectMake(xPos, yPos, size2, size2);
                         [self.view addSubview:ballFallsV];
                         ballFallsV.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         ballFallsV.alpha = 0.0;
                       }];
     
                [UIView animateWithDuration:0.5f
                                               delay:0.1f
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^(void){
                                              
                                              ballAppearV.transform = t2;
                                              [self.view addSubview:ballAppearV];
                                              ballAppearV.alpha = 0.0;
                                              
                                          }
                                          completion:^(BOOL finished){//処理が終わったら
                                              [self.view addSubview:imageV2[num2]];
                                              
                                              for(int i=0;i<NUM2;i++){
                                                  imageV2[i].alpha = 1.0;
                                              }
                                            
                                        
                                          }];

}

//あたり判定
-(void)Collision{
    
    for(int i=0;i<NUM;i++){
        
        for(int j=0;j<NUM2;j++){
            
            if(isFire[i]){//指が離されたボールに関して
                
                newImageV[i].frame = CGRectMake(ballX[i]+tempSize[i],ballY[i]+tempSize[i],size[i]-tempSize[i],size[i]-tempSize[i]);
                
                //衝突判定用
                newImageV2[j].frame = CGRectMake(ballX2[j]+tempSize2[j],ballY2[j]+tempSize2[j],size2[j]-tempSize2[j],size2[j]-tempSize2[j]);
                
                if (CGRectIntersectsRect(newImageV[i].frame, newImageV2[j].frame )){//ボールがぶつかったら
                    
                    if(colorJudge[i] == colorJudge2[j] || colorJudge[i] == 5){//同じボールだったら
                        
                        if(colorJudge[i] != 5){//金ボール以外（青、緑、オレンジ、赤）を生成した場合
                            
                            ballX[i] = storageX;
                            ballY[i] = storageY;
                            isFire[i] = false;
                            
                        }else{//金ボールを生成した時の処理(全てのボールを消す)
                        }
                        
                        comboCount ++;
                        
                        if(comboCount >= 6){
                            [sound collision2_sound];
                        }else{
                            [sound collision_sound];
                        }
                        
                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//エフェクト
                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                        
                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                        ballY2[j] = storageY2;//一旦すべて600に配置される
                        
                        imageV[i].frame = CGRectMake(ballX[i],ballY[i],size[i],size[i]);
                        
                        ball_total --;
                        if(!isStop){
                            [self sendData_ballTotal : ball_total];
                        }
                        
                    }else{//違うボールの場合
                        
                        if(colorJudge2[j] == 5){//blue_five
                            
                            if(colorJudge[i] == 1){
                                
                                switch (blue_number_judge2[j]) {
                                    case 0:
                                        imageV2[j].image = ball_blue_four;
                                        blue_number_judge2[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 1:
                                        imageV2[j].image = ball_blue_three;
                                        blue_number_judge2[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 2:
                                        imageV2[j].image = ball_blue_two;
                                        blue_number_judge2[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 3:
                                        imageV2[j].image = ball_blue_one;
                                        blue_number_judge2[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 4:
                                        comboCount ++;
                                        
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        //[self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        ball_total --;
                                        if(!isStop){
                                            [self sendData_ballTotal : ball_total];
                                        }
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        break;
                                }
                                
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                            }
                            
                        }else if(colorJudge2[j] == 6){//blue_three
                            
                            if(colorJudge[i] == 1){
                                
                                switch (blue_number_judge[j]) {
                                    case 0:
                                        imageV2[j].image = ball_blue_two;
                                        blue_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 1:
                                        imageV2[j].image = ball_blue_one;
                                        blue_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 2:
                                        comboCount ++;
                                        
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        ball_total --;
                                        if(!isStop){
                                            [self sendData_ballTotal : ball_total];
                                        }
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        break;
                                        
                                }
                                
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                            }
                            
                        }else if(colorJudge2[j] == 7){//green_three
                            
                            if(colorJudge[i] == 2){
                                
                                switch (green_number_judge[j]) {
                                    case 0:
                                        imageV2[j].image = ball_green_two;
                                        green_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 1:
                                        imageV2[j].image = ball_green_one;
                                        green_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 2:
                                        comboCount ++;
                                        
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        ball_total --;
                                        if(!isStop){
                                            [self sendData_ballTotal : ball_total];
                                        }
                                        
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        break;
                                }
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                            }
                            
                        }else if(colorJudge2[j] == 8){//orange_two
                            
                            if(colorJudge[i] == 3){
                                
                                switch (orange_number_judge[j]) {
                                    case 0:
                                        imageV2[j].image = ball_orange_one;
                                        orange_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:3];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 1:
                                        
                                        comboCount ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:3];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        ball_total --;
                                        if(!isStop){
                                            [self sendData_ballTotal : ball_total];
                                        }
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        break;
                                }
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                            }
                        }
                        imageV[i].frame = CGRectMake(ballX[i],ballY[i],size[i],size[i]);
                        [self.view addSubview:imageV2[j]];
                        
                    }
                    
                }
            }
            
        }
        
    }
}


-(void)Collision_Item{
    
    for(int i=0;i<NUM;i++){
        
        for(int j=0;j<NUM3;j++){
            
            if(isFire[i]){//指が離されたボールに関して
                
                newImageV[i].frame = CGRectMake(ballX[i]+tempSize[i],ballY[i]+tempSize[i],size[i]-tempSize[i],size[i]-tempSize[i]);
                
                //衝突判定用
                newImageV3[j].frame = CGRectMake(ballX3[j]+tempSize3[j],ballY3[j]+tempSize3[j],size3[j]-tempSize3[j],size3[j]-tempSize3[j]);
                
                if (CGRectIntersectsRect(newImageV[i].frame, newImageV3[j].frame )){//ボールがぶつかったら
                    
                    if(colorJudge[i] == colorJudge3[j]){//同じボールだったら
                        
                        [self ball_move_animation:ballX3[j] float:ballY3[j]+HEIGHT*0.05 float:size3[j] int:colorJudge3[j]];
                        
                        ballX[i] = storageX;
                        ballY[i] = storageY;
                        isFire[i] = false;
                        
                        //エフェクトを隠します
                        if(colorJudge3[j] == 5){
                        golden_effectV.frame = CGRectMake(0, 0, 0, 0);
                        [self.view addSubview:golden_effectV];
                        isItemBall_gold = false;
                        }
                        
                        imageV[i].frame = CGRectMake(ballX[i],ballY[i],size[i],size[i]);
                        
                        
                        //コンボはカウントせず音のみ
                        if(comboCount >= 6){
                            [sound collision2_sound];
                        }else{
                            [sound collision_sound];
                        }
                        
                        ballX3[j] = storageX3;
                        ballY3[j] = storageY3;
                        itemCount[j] = 0;
                        
                        imageV3[j].frame = CGRectMake(ballX3[j],ballY3[j],size3[j],size3[j]);
                    }
                }
            }
        }
    }
}

-(void)ball_move_animation :(float) xPos  float:(float) ypos float:(int) size int:(int)color{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, -(ypos+size));
    CGAffineTransform t2 = CGAffineTransformMakeTranslation(0, size);
    CGAffineTransform t3_0 = CGAffineTransformMakeTranslation(0, size);
    CGAffineTransform t3 = CGAffineTransformScale(t3_0,0.0, 0.0);
    
    UIImageView * ball_animationV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos, ypos, size, size)];
    UIImageView * effectV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos-size/2, ypos, size*2, size*2)];
    
    int rand = arc4random_uniform(3);//0~2
    int ball_id = 0;
    /*
     1:blue
     2:green
     3:orange
     4:red
     5:blue×5
     6:blue×3
     7:green×3
     8:orange×2
     
     10:reverse
     11:speed_up
     */
    
    switch (color) {
        case 1://blue
            switch (rand) {
                case 0://blue*5
                    ball_animationV.image = ball_blue_five;
                    ball_id = 5;
                    break;
                case 1://blue*3
                    ball_animationV.image = ball_blue_three;
                    ball_id = 6;
                    break;
                default://normal_blue
                    ball_animationV.image = ball_blue;
                    ball_id = 1;
                    break;
            }
            effectV.image = effect_blue;
            break;
        case 2://green
            switch (rand) {
                case 0://green*3
                    ball_animationV.image = ball_green_three;
                    ball_id = 7;
                    break;
                default://normal_greeen
                    ball_animationV.image = ball_green;
                    ball_id = 2;
                    break;
            }
            effectV.image = effect_green;
            break;
        case 3://orange
            switch (rand) {
                case 0://orange*2
                    ball_animationV.image = ball_orange_two;
                    ball_id = 8;
                    break;
                default:
                    ball_animationV.image = ball_orange;
                    ball_id = 3;
                    break;
            }
            effectV.image = effect_orange;
            break;
            
        case 4://red
            ball_animationV.image = ball_red;
            ball_id = 4;
            effectV.image = effect_red;
            break;
            
        case 5://golden
            
            switch (rand) {
                
                case 0://reverse
                    ball_animationV.image = ball_reverse;
                    ball_id = 10;
                   break;
                    
                default://speed_up
                    ball_animationV.image = ball_speed_up;
                    ball_id = 11;
                    break;
            }
            effectV.image = effect_gold;
            break;
    }
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         effectV.transform = t3;
                         [self.view addSubview:effectV];
                         effectV.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                     }];
    
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         ball_animationV.transform = t2;
                         [self.view addSubview:ball_animationV];
                         //ball_animationV.alpha = 0.2;
                         
                     }
     
                     completion:^(BOOL finished){//処理が終わったら
                         
                         [sound rivalBall_launch_sound];
                         
                         [UIView animateWithDuration:0.5f
                                               delay:0.0f
                                             options:UIViewAnimationOptionAllowUserInteraction
                                          animations:^(void){
                                              // ball_animationV.alpha = 1.0;
                                              [self.view addSubview:ball_animationV];
                                              ball_animationV.transform = t1;
                                              
                                              
                                          }
                                          completion:^(BOOL finished){//処理が終わったら
                                              
                                            //  NSLog(@"ball_id :%d",ball_id);
                                              [self sendData_ball:ball_id];
                                              
                                          }];
                         
                     }];
    
}

-(void)effect:(int)xPos int:(int)yPos int:(int)size int:(int)color{
    
    
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(10, 10);
    CGAffineTransform t2 = CGAffineTransformScale(t1,12.0, 12.0);
    
    
    [UIView animateWithDuration:0.6f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         effectImageV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos+size, yPos+size, size,size)];
                         
                         
                         switch (color) {
                             case 1:
                                 effectImageV.image = effect_blue;
                                 break;
                             case 2:
                                 effectImageV.image = effect_green;
                                 break;
                             case 3:
                                 effectImageV.image = effect_orange;
                                 break;
                             case 4:
                                 effectImageV.image = effect_red;
                                 break;
                             default:
                                 effectImageV.image = effect_gold;
                                 break;
                         }
                         effectImageV.transform = t2;
                         [self.view addSubview:effectImageV];
                         effectImageV.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         effectImageV = nil;
                     }];
}


//コンボに関する処理全般（コンボのアニメーション及びコンボの得点）
-(void)combo:(int)xPos int:(int)yPos int:(int)size int:(int)color{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, -HEIGHT*0.035);
    CGAffineTransform t2 = CGAffineTransformScale(t1,2.0, 2.0);
    
    [UIView animateWithDuration:1.2f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         comboV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos+size, yPos+size,WIDTH*0.187,HEIGHT*0.035)];
                         
                         if(comboCount ==2) {
                             comboV.image = combo1;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 5;//チャージがたまります
                                 [self chargeMake];
                             }
                         }else if (comboCount ==3){
                             comboV.image = combo2;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 5;//チャージが5たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount ==4){
                             comboV.image = combo3;
                             [self ItemBall_produce];
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount ==5){
                             comboV.image = combo4;
                             [self ItemBall_produce];
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount >= 6){
                             comboV.image = comboMax;
                             [self ItemBall_produce];
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                         }else{
                             comboV.image = nil;
                             
                         }
                         
                         comboV.transform = t2;
                         [self.view addSubview:comboV];
                         comboV.alpha = 0.0;
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         comboV = nil;
                     }];
}

-(void)lifeDisapper_animation:(int) i int:(int) j{
    
    //i : 何番目のlifeが消えたか
    //j : 自分と相手のどちらlifeが消えたか
    
    [sound life_disapper_sound];
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,25.0, 25.0);
    
    UIImageView * life_animationV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.38+(WIDTH*(i-1)*0.08), HEIGHT*0.025+(j*HEIGHT*0.04), WIDTH*0.08, WIDTH*0.08)];
    
    switch (j) {
        case 0://自分の場合
            life_animationV.image = [UIImage imageNamed:@"life_disapper_effect.png"];
            break;
        case 1://相手の場合
            life_animationV.image = [UIImage imageNamed:@"life_disapper_effect2.png"];
            break;
    }
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         [self.view addSubview:life_animationV];
                         life_animationV.alpha = 0.0;
                         life_animationV.transform = t2;
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         
                     }];
    
}

/*-----------------------------------------------Item Ball---------------------------------------------*/

//ボールを保管庫に格納

-(void)Store3{
    
    for(int i=0;i<NUM3;i++){
        ballX3[i] = storageX3;//一旦すべて保管庫へ
        ballY3[i] = storageY3;//一旦すべて保管庫へ
    }
}


//ボールが保管庫に入っているか否か
-(BOOL)isInStorage3{
    
    if(ballX3[num3] == storageX3 && ballY3[num3] == storageY3){
        return true;
    }
    return false;
}

-(void)ItemBall_produce{
    
    //NSLog(@"num3 : %d",num3);
    
    if([self isInStorage3]){
        
        int rand;
        
        //goldのItemボールは一つしか出さない
        if(isItemBall_gold){
            rand = arc4random_uniform(12);//0~11
        }else{
            rand = arc4random_uniform(13);//0~12
        }
        
       // NSLog(@"rand :%d",rand);
        
        if(rand <=3){//012
            rand = 0;
        }else if(rand <=5){//345
            rand = 1;
        }else if(rand <=8){//678
            rand = 2;
        }else if(rand <=11){//9,10,11
            rand = 3;
        }else{//12
            rand = 4;
            isItemBall_gold = true;
        }
        
        [self ItemBall_parameter:rand];
        
        if(num3 == NUM3-1){
            num3 = 0;
        }else{
            num3 ++;
        }
        
    }
    
}

//サイズ、速さ、初期値
-(void)ItemBall_parameter : (int)ItemNum{
    
    float rand_width = arc4random_uniform(WIDTH/2)+size3[num3];
    float rand_height = arc4random_uniform(HEIGHT/3)+HEIGHT*0.075;
    
    ballX3[num3]  = rand_width;
    ballY3[num3] = rand_height;
    dx3[num3] = 1.0;
    dy3[num3] = 1.0;
    
    switch (ItemNum) {
        case 0:
            size3[num3]  = 30;
            imageV3[num3].image = itemBall_blue;
            colorJudge3[num3] = 1;
            break;
        case 1:
            size3[num3]  = 35;
            imageV3[num3].image = itemBall_green;
            colorJudge3[num3] = 2;
            break;
        case 2:
            size3[num3]  = 40;
            imageV3[num3].image = itemBall_orange;
            colorJudge3[num3] = 3;
            break;
        case 3:
            size3[num3]  = 45;
            imageV3[num3].image = itemBall_red;
            colorJudge3[num3] = 4;
            break;
        case 4:
            size3[num3]  = 40;
            imageV3[num3].image = itemBall_golden;
            colorJudge3[num3] = 5;
            break;
    }
    tempSize2[num3] = size2[num3]/4;
    
    imageV3[num3].frame = CGRectMake(ballX3[num3], ballY3[num3], size3[num3], size3[num3]);
    [self.view addSubview:imageV3[num3]];//imageV3を表示
}

/*-------------------------------------金色ボールのチャージ関連-----------------------------------*/
-(void)chargeMake{
    
    //NSLog(@"chargeCount : %d ",chargeCount);
    
    if(chargeCount <= 10) {
        chargeV.image = charge_zero;
        [self chargeAnimation];
    }else if(chargeCount<=20){
        chargeV.image = charge_one;
        [self chargeAnimation];
    }else if(chargeCount<=30){
        chargeV.image = charge_two;
        [self chargeAnimation];
    }else if(chargeCount<=40){
        chargeV.image = charge_three;
        [self chargeAnimation];
    }else if(chargeCount<=50){
        chargeV.image = charge_four;
        [self chargeAnimation];
    }else if(chargeCount<=60){
        chargeV.image = charge_five;
        [self chargeAnimation];
    }else if(chargeCount<=70){
        chargeV.image = charge_six;
        [self chargeAnimation];
    }else if(chargeCount<=80){
        chargeV.image = charge_seven;
        [self chargeAnimation];
    }else if(chargeCount <=90){
        chargeV.image = charge_comp;
        [self chargeAnimation_comp];
        isGolden = true;
        
        if(isGolden){
            goldenFrameV.frame = CGRectMake(-WIDTH*0.04, HEIGHT*0.905, WIDTH*1.08, HEIGHT*0.16);
            [self.view addSubview:goldenFrameV];
            
            //点滅アニメーション
            [UIView animateWithDuration:0.2f
                                  delay:1.0f
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^(void){
                                 
                                 goldenFrameV.alpha = 1.0;
                                 [self.view addSubview:goldenFrameV];
                                 [UIView setAnimationRepeatCount: 10];
                                 [UIView setAnimationRepeatAutoreverses:YES];
                                 goldenFrameV.alpha = 0.3;
                                 
                             }
                             completion:^(BOOL finished){//処理が終わったら
                                 goldenFrameV.alpha = 1.0;
                             }];
            
            
        }
    }
    
}

-(void)chargeAnimation{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,1.5, 1.5);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         chargeV.transform = t2;
                         [self.view addSubview:chargeV];
                         //[UIView setAnimationRepeatAutoreverses:YES];
                         chargeV.transform = t1;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                     }];
}

-(void)chargeAnimation_comp{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,1.8, 1.8);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         chargeV.transform = t2;
                         [self.view addSubview:chargeV];
                         [UIView setAnimationRepeatCount:10];
                         [UIView setAnimationRepeatAutoreverses:YES];
                         chargeV.transform = t1;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                     }];
}

    
-(void)event_animation:(int)a{
    
    /*a
     0:reverse
     1:speed_up
     */
    
        CGAffineTransform t1 = CGAffineTransformMakeTranslation(0, 0);
        CGAffineTransform t2 = CGAffineTransformScale(t1,1.5, 1.5);
    
        eventV.frame = CGRectMake(WIDTH*0.2, HEIGHT*0.3, WIDTH*0.6, HEIGHT*0.3);
    
    switch (a) {
        case 0:
            eventV.image = reverse_alert;
            break;
        case 1:
            eventV.image = speed_up_alert;
            break;
    }
        
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^(void){
                             
                             eventV.transform = t2;
                             [self.view addSubview:eventV];
                             [UIView setAnimationRepeatCount:15];
                             [UIView setAnimationRepeatAutoreverses:YES];
                             eventV.transform = t1;
                             
                             
                         }
                         completion:^(BOOL finished){//処理が終わったら
                             
                             eventV.frame = CGRectMake(WIDTH, HEIGHT, 0,0);
                             [self.view addSubview:eventV];
                             switch (a) {
                                 case 0:
                                        isReverse = false;
                                     break;
                                 case 1:
                                        isSpeed_up = false;
                                     break;
                            
                             }
                             
                         }];
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
