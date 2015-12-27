//
//  ViewController.m
//  Ball
//
//  Created by Tsuru on 2014/06/06.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController_iPad.h"
#import "Sound.h"
#import "BGM.h"

AppDelegate * delegate;

int size[NUM];//ボールのサイズ
float dy[NUM];//ボールの速度
float ballX[NUM];//ボールのx座標
float ballY[NUM];//ボールのy座標
int num;//配列番号
int storageX;//ボールの保管庫
int storageY;//ボールの保管庫

int totalScore;//全体の得点
int score;//個々の得点

BOOL touchField;//タッチされた場所の真偽
BOOL isStop;//ストップメニューが表示されているか否か

int countDownSec;//カウントダウンのための秒数
BOOL isCountDown;//カウントダウンの真偽

BOOL isNotMove;//指をドラッグしているか否か

int size2[NUM2];//ボールのサイズ
float dy2[NUM2];//ボールの速度
float dx2[NUM2];//ボールの速度
float ballX2[NUM2];//ボールのx座標
float ballY2[NUM2];//ボールのy座標
int num2;
int storageX2;//ボールの保管庫
int storageY2;//ボールの保管庫 （この値は画面外にでたかどうかの判断のためのy座標と相談する必要がある）
int a;
int colorJudge[NUM];//ボールの色を判定する
int colorJudge2[NUM2];//ボールの色を判定する
CGPoint location;
CGPoint newLocation;
CGPoint location2;//指が離された時の座標

float tempSize[NUM];//矩形の調整に使う
float tempSize2[NUM2];//矩形の調整に使う
BOOL isFire[NUM];//指を離してボールを発射したかどうか
BOOL isFire2[NUM2];//指を離してボールを発射したかどうか
NSInteger highScore;//ハイスコアの整数型

int comboCount;

int vertical[10];//横移動の判別（0,1,2,3の４つを設定する）

NSString * mode;

int skyblue_judge[NUM2];
int purple_judge[NUM2];
int brawn_judge[NUM2];
int blue_number_judge[NUM2];
int green_number_judge[NUM2];
int orange_number_judge[NUM2];
int blue_number_judge2[NUM2];

int chargeCount;

BOOL isGolden;//金ボールをうてる状態にあるのか否か

double WIDTH;
double HEIGHT;

int often_global;//ボールの生成頻度
float alpha_global;//ボールの速度変更

@interface ViewController_iPad ()
@end
@implementation ViewController_iPad




- (void)viewDidLoad

{
    
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得
    
    num = 0;
    num2 = 0;
    totalScore = 0;//0点からスタート
    delegate.totalScore_del = [NSString stringWithFormat:@"%d",totalScore];
    touchField = false;
    isStop = false;
    comboCount = 0;
    countDownSec = 4;
    chargeCount = 0;
    isGolden = false;
    
    storageX = WIDTH;
    storageY = HEIGHT;
    storageX2 = 0;
    storageY2 = HEIGHT+200;
    
    chargeCount = 0;//チャージカウントの初期化
    often_global = 0;
    alpha_global = 0.0;
    
    a =0;
    num2 = 0;
    
    //サウンドクラス
    sound = [[Sound alloc]init];
    //BGMクラス
    bgm = [[BGM alloc]init];
    [bgm BGM_load];
    [bgm BGM_play];
    
    //難易度クラス
    difficulty = [[Difficulty alloc]init];
    [difficulty dif_iPad];//速度の初期化
    
    //NSLog(@"mode : %@",delegate.mode);
    mode = delegate.mode;
    
    //背景の設定
    imageBack = [[UIImageView alloc] initWithFrame:self.view.bounds];
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    imageBack.image = delegate.themeImage;//テーマの画像を背景のイメージビューに貼る
    [self.view addSubview:imageBack];
    
    //ボールの色画像を取得
    ball_blue = [UIImage imageNamed:@"ball_blue.png"];
    ball_green = [UIImage imageNamed:@"ball_green.png"];
    ball_orange = [UIImage imageNamed:@"ball_orange.png"];
    ball_red= [UIImage imageNamed:@"ball_red.png"];
    ball_gold = [UIImage imageNamed:@"ball_gold.png"];
    ball_purple = [UIImage imageNamed:@"ball_purple.png"];
    ball_skyblue= [UIImage imageNamed:@"ball_skyblue.png"];
    ball_purple_red = [UIImage imageNamed:@"ball_purple_red.png"];
    ball_purple_blue = [UIImage imageNamed:@"ball_purple_blue.png"];
    ball_skyblue_green = [UIImage imageNamed:@"ball_skyblue_green.png"];
    ball_skyblue_blue = [UIImage imageNamed:@"ball_skyblue_blue.png"];
    ball_brawn  = [UIImage imageNamed:@"ball_brawn.png"];
    ball_brawn_orange = [UIImage imageNamed:@"ball_brawn_orange.png"];
    ball_brawn_blue = [UIImage imageNamed:@"ball_brawn_blue.png"];
    ball_blue_five = [UIImage imageNamed:@"ball_blue_five.png"];
    ball_blue_four = [UIImage imageNamed:@"ball_blue_four.png"];
    ball_blue_three = [UIImage imageNamed:@"ball_blue_three.png"];
    ball_blue_two = [UIImage imageNamed:@"ball_blue_two.png"];
    ball_blue_one = [UIImage imageNamed:@"ball_blue_one.png"];
    ball_green_two = [UIImage imageNamed:@"ball_green_two.png"];
    ball_green_one = [UIImage imageNamed:@"ball_green_one.png"];
    ball_orange_two = [UIImage imageNamed:@"ball_orange_two.png"];
    ball_orange_one = [UIImage imageNamed:@"ball_orange_one.png"];
    
    
    //ボールのエフェクト画像を取得
    effect_blue = [UIImage imageNamed:@"effect_blue.png"];
    effect_green = [UIImage imageNamed:@"effect_green.png"];
    effect_orange = [UIImage imageNamed:@"effect_orange.png"];
    effect_red= [UIImage imageNamed:@"effect_red.png"];
    effect_gold= [UIImage imageNamed:@"effect_gold.png"];
    effect_skyblue= [UIImage imageNamed:@"effect_skyblue.png"];
    effect_purple= [UIImage imageNamed:@"effect_purple.png"];
    effect_brawn= [UIImage imageNamed:@"effect_brawn.png"];
    
    for(int i=0;i<NUM;i++){
        imageV[i]= [[UIImageView alloc]init];//メモリ割当
        newImageV[i]= [[UIImageView alloc]init];//メモリ割当
    }
    
    for(int i=0;i<NUM2;i++){
        imageV2[i]= [[UIImageView alloc]init];//メモリ割当
        newImageV2[i]= [[UIImageView alloc]init];//メモリ割当
    }
    
    [self ReadyGo];//カウントダウンの開始
    
    [self Store];//ボール15個をいったんすべて保管庫に入れます
    [self Store2];//ボール10個をいったんすべて保管庫に入れます
    
    //停止ボタン
    
    UIImage * image = [UIImage imageNamed:@"stopImage.png"];//画像の取得
    stopButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    stopButton.frame =CGRectMake(10,20,HEIGHT*0.085,HEIGHT*0.085);//位置と大きさ
    [stopButton setBackgroundImage:image forState:UIControlStateNormal];  // 画像をセットす
    [stopButton addTarget:self action:@selector(stopButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    [self stopMenu];//ストップ画面を準備
    
    //scoreを表示するビュー
    scoreV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 0.17, 15, WIDTH*0.3, HEIGHT*0.05)];
    UIImage * scoreImage = [UIImage imageNamed:@"scoreImage.png"];
    scoreV.image = scoreImage;
    [self.view addSubview:scoreV];
    
    //highscoreを表示するビュー
    HighScoreV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH*0.65, 5, WIDTH/4, HEIGHT/15)];
    UIImage * highScoreImage = [UIImage imageNamed:@"highScoreImage.png"];
    HighScoreV.image = highScoreImage;
    [self.view addSubview:HighScoreV];
    
    //コンボを表示するための準備
    combo1 = [UIImage imageNamed:@"combo_1.png"];
    combo2 = [UIImage imageNamed:@"combo_2.png"];
    combo3 = [UIImage imageNamed:@"combo_3.png"];
    combo4 = [UIImage imageNamed:@"combo_4.png"];
    comboMax = [UIImage imageNamed:@"comboMax.png"];
    
    
    //スコアを表示するための準備
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
    
    //ハイスコアを表示するための準備
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
    
    //0のスコアを表示
    for(int i=0;i<7;i++){
        scoreView[i] =[[UIImageView alloc]init];
        scoreView2[i] =[[UIImageView alloc]init];
    }
    scoreView[0].frame = CGRectMake(WIDTH * 0.28, HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
    scoreView[0].image = zero_white;
    [self.view addSubview:scoreView[0]];
    
    //ハイスコアを表示する
    ud = [NSUserDefaults standardUserDefaults];     //ユーザデフォルトのインスタンスを作成
    if([delegate.mode isEqualToString:@"easy"]){
        highScore = [ud integerForKey:@"highScore_easy"];
    }else if([delegate.mode isEqualToString:@"normal"]){
        highScore = [ud integerForKey:@"highScore_normal"];
    }else if([delegate.mode isEqualToString:@"hard"]){
        highScore = [ud integerForKey:@"highScore_hard"];
    }
    
    [self scoreCount2];
    
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
    chargeV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * 0.48, HEIGHT*0.01, WIDTH*0.15,  WIDTH*0.15  )];
    chargeV.image = charge_zero;
    [self.view addSubview:chargeV];
    
    //金色の枠
    goldenImage = [UIImage imageNamed:@"golden_frame.png"];
    goldenFrameV = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2, HEIGHT*0.035, 0, 0)];
    goldenFrameV.image = goldenImage;
    
    golden_effect = [UIImage imageNamed:@"golden_effect.png"];
    golden_effectV = [[UIImageView alloc]init];
    golden_effectV.image = golden_effect;
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？
    delegate.NewRecord= @"NO";//記録が更新されたか否か
    
}

- (void)didReceiveMemoryWarnings

{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*--------------------------------viewDidLoadで呼ばれるメソッド---------------------------------------------*/

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
    
    [self update];//背景の更新
    
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
            CPUtm =
            [NSTimer
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
    
    size[num]  = 40;//最初のサイズは40
    imageV[num].image = ball_blue;//初期化の色は青
    colorJudge[num] =1;//デフォルトは1に設定
    dy[num] = 4.0;//速度の初期化
    [self.view addSubview:imageV[num]];//imageVを表示
    isFire[num] = false;//ボールは発射されていない
}

/*-------------------------------------------------------------------------------------------------------*/



//停止ボタンをおした時の画面

-(void)stopMenu{
    
    stopMenuV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    UIImage * stopMenu = [UIImage imageNamed:@"stopMenu.png"];//画像の取得
    stopMenuV.image = stopMenu;
    
    //再開ボタン
    UIImage * restart = [UIImage imageNamed:@"restart.png"];//画像の取得
    restartBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    restartBtn.frame =CGRectMake(WIDTH*0.31,HEIGHT*0.4,WIDTH*0.375,HEIGHT*0.09);//位置と大きさ
    [restartBtn setBackgroundImage:restart forState:UIControlStateNormal];  // 画像をセットする
    [restartBtn addTarget:self action:@selector(restartButton) forControlEvents:UIControlEventTouchUpInside];
    
    //戻るボタン
    UIImage * exit = [UIImage imageNamed:@"exit.png"];//画像の取得
    exitBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    exitBtn.frame =CGRectMake(WIDTH*0.27,HEIGHT*0.6,WIDTH*0.45,HEIGHT*0.09);//位置と大きさ
    [exitBtn setBackgroundImage:exit forState:UIControlStateNormal];  // 画像をセットする
    [exitBtn addTarget:self action:@selector(exitButton) forControlEvents:UIControlEventTouchUpInside];
    
}

//タップした時の処理

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    //シングルタッチ
    UITouch * touch = [touches anyObject];
    location = [touch locationInView:self.view];
    
    
    //ストップメニューが開かれていなかったら and カウントダウンが終わったら
    
    if(!isStop && !isCountDown){
        
        if(CGRectContainsPoint(CGRectMake(0, HEIGHT*0.9, WIDTH, HEIGHT),location)){//指定された場所でのみ生成
            
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

-(void)goldenBall{
    
    imageV[num].image = ball_gold; //gold
    dy[num] = 1.4;//金ボールだけ遅め
    colorJudge[num] =5;
    size[num] = 200;
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
     selector:@selector(bigger:)
     userInfo:nil
     repeats:YES
     ];
}

// ボールが大きくなるbiggerメソッド

-(void)bigger:(NSTimer*)timer{
    
    //NSLog(@"sizeChange %d",num);
    if([mode isEqualToString:@"easy"]){
        size[num] ++;
    }else{
        size[num] += 2;
    }
    
    //止まっている状態の場合（ドラッグしていない状態）
    if(isNotMove ==true){
        ballX[num] = location.x -(size[num]/2);
        ballY[num] = location.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
    }else{//ドラッグしている状態
        ballX[num] = newLocation.x -(size[num]/2);
        ballY[num] = newLocation.y - (size[num]/2)-WIDTH*0.15;//タッチしたところが見えるように-50
    }
    
    if(size[num] == 60){//
        
        // AudioServicesPlaySystemSound(bigger_sound);
        [sound bigger_sound];
    }
    
    //横の壁にあたったら反射
    
    if(ballX[num] <0){
        
        ballX[num] = 0;
        
    }else if(ballX[num] + size[num] >WIDTH){
        
        ballX[num] = WIDTH - size[num];
        
    }else{}
    
    if([mode isEqualToString:@"easy"]){
        
        //sizeが118になったら40に戻す
        if(size[num] > 118){
            
            size[num] = 40;
        }
    }else{
        //sizeが198になったら40に戻す
        if(size[num] > 198){
            
            size[num] = 40;
        }
    }
    
    dy[num] = 4.0;//速度の初期化
    
    if(size[num]<80){//青:20~39
        imageV[num].image = ball_blue; //blue
        colorJudge[num] =1;
    }else if(size[num] < 120){//緑:40~59
        imageV[num].image = ball_green; //green
        colorJudge[num] =2;
    }else if(size[num] < 160){//オレンジ:60~79
        imageV[num].image = ball_orange; //orange
        colorJudge[num] =3;
    }else if(size[num]<198){//赤:80~98
        imageV[num].image = ball_red; //red
        colorJudge[num] =4;
    }
    
    
    imageV[num].frame = CGRectMake(ballX[num],ballY[num],size[num],size[num]);
    //[self.view bringSubviewToFront:imageV[num]];
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
            //AudioServicesPlaySystemSound(launch2_sound);//金ボールの発射
            [sound launch2_sound];
        }else{
            //AudioServicesPlaySystemSound(launch_sound);//それ以外のボールの発射音
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
            //[self.view bringSubviewToFront:imageV[i]];
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
        
        if(CGRectContainsPoint(CGRectMake(0, HEIGHT*0.9, WIDTH, HEIGHT),newLocation)){//指定された場所でのみ生成可能
            
            ballX[num] = newLocation.x -(size[num]/2);
            ballY[num] = newLocation.y -(size[num]/2)-WIDTH*0.15;
            
            imageV[num].frame = CGRectMake(ballX[num], ballY[num], size[num], size[num]);
            
            isNotMove = false;//動いている
        }
    }
}


//停止ボタンが押されたら

- (void)stopButton{
    
    if(!isStop){
        [sound release_sound];
        [self.view addSubview:stopMenuV];//ストップメニューの生成
        [self.view addSubview:restartBtn];//再開ボタンを生成
        [self.view addSubview:exitBtn];//終了ボタンを生成
        
        isStop = true;//ストップメニューが開かれている状態
        
        //すべてのタイマーを一時停止
        [tm invalidate];
        [tmSize invalidate];
        [CPUtm invalidate];
        [countDownT invalidate];
        
        [bgm BGM_pause];//BGMの一時停止
    }
}


//再開ボタンが押されたら

-(void)restartButton{
    
    //AudioServicesPlaySystemSound(button_sound);
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
    
    
    [self update];//背景の更新
    isStop = false;//ストップメニューが閉じた状態
    
    [bgm BGM_play];
}

//終了ボタンが押されたら

-(void)exitButton{
    //AudioServicesPlaySystemSound(button_sound);
    [sound button_sound];
    
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    [self presentViewController:vc0 animated:YES completion:nil];
    
    [tm invalidate];//タイマーを破棄しただけでオブジェクト自体は残っている
    [self finish];//終了する
}

//背景の更新

-(void)update{
    
    [self.view addSubview:imageBack];
    [self.view addSubview:stopButton];
    [self.view addSubview:label];
    [self.view addSubview:scoreV];
    [self.view addSubview:HighScoreV];
    [self.view addSubview:HighScoreLabel];
    [self.view addSubview:chargeV];
    [self.view addSubview:goldenFrameV];
    
    if(isCountDown){
        [self.view addSubview:CountDownV];
    }
    
    for(int i=0;i<NUM;i++){
        [self.view addSubview:imageV[i]];
    }
    for(int i=0;i<NUM2;i++){
        [self.view addSubview:imageV2[i]];
    }
    
    for(int i=0;i<7;i++){
        [self.view addSubview:scoreView[i]];
        [self.view addSubview:scoreView2[i]];
    }
}

//終了メソッド

-(void)finish{
    
    [tm invalidate];//タイマーを破棄しただけでオブジェクト自体は残っている
    tm = nil;//完全に初期化
    [tmSize invalidate];
    tmSize = nil;
    [CPUtm invalidate];
    CPUtm = nil;
    
    [bgm BGM_stop];//BGMのストップ
}
/*----------------------------------------------CPU-------------------------------------------------*/



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
    
    [self difficulty];//ボールを生成
    
    for(int i=0;i<NUM2;i++){
        
        if(ballY2[i]+size2[i]<HEIGHT*0.95){//保管庫のy座標と相談が必要
            
            ballY2[i] += dy2[i];
            
            if(totalScore < 5000){//5000までは縦運動のみ
            }else if(totalScore < 10000){//5000を超えたら横運動の追加
                ballX2[i] += dx2[i];
            }else{ //10000を超えたらランダム
                if(vertical[i] == 0){//vertical が0の場合, 直で落ちてくる
                    dx2[i] = 0;
                }else{
                    ballX2[i] += dx2[i];
                }
            }
            
            //跳ね返り
            if(ballX2[i]<0 || ballX2[i]+size2[i]>WIDTH){
                
                dx2[i] = -dx2[i];
                
            }
        }else if(ballX2[i] == storageX2 && ballY2[i] == storageY2){
            
        }else{//自分のエリアにボールが入ってしまったら終了
            
            [self finish];
            delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
            delegate.ScoreS = [NSString stringWithFormat:@"%d",totalScore];//totalScoreをデリゲードのScoreSに渡す
            UIViewController * vc1_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc1_2"];
            [self presentViewController:vc1_2 animated:YES completion:nil];
        }
        imageV2[i].frame = CGRectMake(ballX2[i],ballY2[i],size2[i],size2[i]);
        [self.view addSubview:imageV2[i]];
    }
    if([mode isEqualToString:@"hard"]){
        [self Collision_hard];
    }else{
        [self Collision];//当たり判定
    }
    
}


-(void)difficulty{

    //生成頻度と加速度の２つのパラメータをarrayに格納します
    array  = [difficulty dif_iPad];
    
    //リストの最初の要素（生成頻度）を取り出す
    NSString *oftenS = [array objectAtIndex:0];
    //リストの2番目の要素（生成頻度）を取り出す
    NSString *alphaS = [array objectAtIndex:1];
    often_global = [oftenS intValue];
    alpha_global = [alphaS floatValue];
    
    if(often_global == 0 && alpha_global == 0){//全クリ出来たら終了します
        
        NSLog(@"なんで");
        
        totalScore = 1000000;
        [self finish];
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
        delegate.ScoreS = [NSString stringWithFormat:@"%d",totalScore];//totalScoreをデリゲードのScoreSに渡す
        UIViewController * vc1_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc1_2"];
        [self presentViewController:vc1_2 animated:YES completion:nil];
        
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
        delegate.NewRecord= @"YES";//記録が更新されたか否か
        ud = [NSUserDefaults standardUserDefaults];  // 取得
        if([delegate.mode isEqualToString:@"normal"]){
            [ud setInteger:totalScore forKey:@"highScore_normal"];
        }else if([delegate.mode isEqualToString:@"easy"]){
            [ud setInteger:totalScore forKey:@"highScore_easy"];
        }else if([delegate.mode isEqualToString:@"hard"]){
            [ud setInteger:totalScore forKey:@"highScore_hard"];
        }
        [ud synchronize];//userDefaultsへの反映*/
        
    }else{
        
        [self ballProduce:often_global float:alpha_global];//難易度に応じてボールを生成
        
        if(num2 ==NUM2) {
            num2= 0;//初期化
        }else{}
        
    }
}


//ボールの生成
-(void)ballProduce:(int)b float:(float)alpha{
    
    //保管庫にボールが入っていればボールを生成
    
    if([self isInStorage2]){
        
        
        if(a%b == 0 || a ==1){//ボールの生成頻度
            //NSLog(@"ball produce");
            //NSLog(@"num2 : %d",num2);
            
            
            if([mode isEqualToString:@"easy"]){
                size2[num2] = arc4random_uniform(59)+60;
            }else{
                size2[num2] = arc4random_uniform(140)+60;
            }
            
            ballX2[num2] = arc4random_uniform(WIDTH);
            ballY2[num2] = HEIGHT*0.07;
            
            vertical[num2]  = arc4random_uniform(5);
            
            if(ballX2[num2] <0){
                ballX2[num2] = 0;
            }else if(ballX2[num2] + size2[num2] >WIDTH){
                ballX2[num2] = WIDTH - size2[num2];
            }else{}
            
            
            //衝突判定用のtempSize2(表示はしません)
            tempSize2[num2] = size2[num2]/4;
            
            if([mode isEqualToString:@"hard"]){
                [self ballColor_hard:alpha];
            }else{
                [self ballColor:alpha];
            }
            
            [self ballAppear_animation:colorJudge2[num2] int:ballX2[num2] float:ballY2[num2] float:size2[num2]];
            imageV2[num2].frame = CGRectMake(ballX2[num2],ballY2[num2],size2[num2],size2[num2]);
            [self.view addSubview:imageV2[num2]];
        }
    }
}

-(void)ballAppear_animation:(int) color int:(float)xPos float:(float) yPos float: (int)size2{
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform t2 = CGAffineTransformScale(t1,0.0, 0.0);
    
    //color一覧
    //
    /*1:blue
     2:green
     3:orange
     4:red
     5:skyblue
     6:purple
     7:brawn
     11:number_blue_three
     12:number_green_two
     13:number_orange_two
     14:number_blue_five
     */
    
    
    UIImageView * ballAppearV = [[UIImageView alloc]initWithFrame:CGRectMake(xPos-size2/4, yPos-size2/4, size2*1.5, size2*1.5)];
    
    if(color == 1 || color == 11 || color ==14){//blue
        ballAppearV.image = effect_blue;
    }else if(color == 2 || color == 12){//green
        ballAppearV.image = effect_green;
    }else if(color == 3 || color == 13){//orange
        ballAppearV.image = effect_orange;
    }else if(color == 4){//red
        ballAppearV.image = effect_red;
    }else if(color == 5){//skyblue
        ballAppearV.image = effect_skyblue;
    }else if(color == 6){//purple
        ballAppearV.image = effect_purple;
    }else if(color == 7){//brawn
        ballAppearV.image = effect_brawn;
    }
    
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void){
                         
                         ballAppearV.transform = t2;
                         [self.view addSubview:ballAppearV];
                         ballAppearV.alpha = 0.0;
                         
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         num2++;
                     }];
    
}


-(void)ballColor:(float)alpha{
    
    if(size2[num2]<80){
        
        imageV2[num2].image = ball_blue; //blue
        dy2[num2] =1.0 + alpha;
        dx2[num2] = 1.0 + alpha|| -1.0 - alpha;
        colorJudge2[num2] =1;
        
        
    }else if(size2[num2] < 120){
        
        imageV2[num2].image = ball_green; //green
        dy2[num2] = 0.9 + alpha;
        dx2[num2] = 0.9 + alpha || -0.9 - alpha;
        colorJudge2[num2] =2;
        
    }else if(size2[num2] < 160){
        
        imageV2[num2].image = ball_orange; //orange
        dy2[num2] = 0.7 + alpha;
        dx2[num2] = 0.7 +alpha  || -0.7 - alpha;
        colorJudge2[num2] =3;
        
    }else{
        imageV2[num2].image = ball_red; //red
        dy2[num2] = 0.5 + alpha;
        dx2[num2] = 0.5 + alpha || -0.5 -alpha;
        colorJudge2[num2] =4;
        
    }
    
}

-(void)ballColor_hard:(float)alpha{
    
    // NSLog(@"size2[%d]:%d",num2,size2[num2]);
    
    //colorJudge一覧
    //size(60~200)
    /*1:blue
     2:green
     3:orange
     4:red
     5:skyblue
     6:purple
     7:brawn
     11:number_blue_three
     12:number_green_two
     13:number_orange_two
     14:number_blue_five
     */
    
    skyblue_judge[num2] = 0;
    purple_judge[num2] = 0;
    brawn_judge[num2] = 0;
    blue_number_judge[num2] = 0;
    green_number_judge[num2] = 0;
    orange_number_judge[num2] = 0;
    blue_number_judge2[num2] = 0;
    
    
    if(size2[num2]<70){
        
        imageV2[num2].image = ball_blue; //blue
        dy2[num2] =1.0 + alpha;
        dx2[num2] = 1.0 + alpha|| -1.0 - alpha;
        colorJudge2[num2] =1;
        
    }else if(size2[num2] < 74){
        
        imageV2[num2].image = ball_blue_three; //number_blue_three
        dy2[num2] = 0.9 + alpha;
        dx2[num2] = 0.9 + alpha || -0.9 - alpha;
        colorJudge2[num2] =11;
        
        
    }else if(size2[num2] < 80){
        
        imageV2[num2].image = ball_blue_five; //number_blue_five
        dy2[num2] = 0.9 + alpha;
        dx2[num2] = 0.9 + alpha || -0.9 - alpha;
        colorJudge2[num2] =14;
        
        
    }else if(size2[num2] < 100){
        
        imageV2[num2].image = ball_green; //green
        dy2[num2] = 0.9 + alpha;
        dx2[num2] = 0.9 + alpha || -0.9 - alpha;
        colorJudge2[num2] =2;
        
        
    }else if(size2[num2] < 106){
        
        imageV2[num2].image = ball_green_two; //number_green
        dy2[num2] = 0.8 + alpha;
        dx2[num2] = 0.8 + alpha || -0.8 - alpha;
        colorJudge2[num2] =12;
        
        
    }else if(size2[num2] < 120){
        
        imageV2[num2].image = ball_skyblue; //skyblue
        dy2[num2] = 0.8 + alpha;
        dx2[num2] = 0.8 + alpha || -0.8 - alpha;
        colorJudge2[num2] =5;
        
    }else if(size2[num2] < 140){
        
        imageV2[num2].image = ball_orange; //orange
        dy2[num2] = 0.7 + alpha;
        dx2[num2] = 0.7 +alpha  || -0.7 - alpha;
        colorJudge2[num2] =3;
        
    }else if(size2[num2] < 146){
        
        imageV2[num2].image = ball_orange_two; //number_orange
        dy2[num2] = 0.6 + alpha;
        dx2[num2] = 0.6 +alpha  || -0.6 - alpha;
        colorJudge2[num2] =13;
        
    }else if(size2[num2] < 160){
        
        imageV2[num2].image = ball_brawn; //brawn
        dy2[num2] = 0.6 + alpha;
        dx2[num2] = 0.6 +alpha  || -0.6 - alpha;
        colorJudge2[num2] =7;
        
    }else if(size2[num2] < 180){
        
        imageV2[num2].image = ball_purple; //purple
        dy2[num2] = 0.4 + alpha;
        dx2[num2] = 0.4 +alpha  || -0.4 - alpha;
        colorJudge2[num2] =6;
        
    }else{
        imageV2[num2].image = ball_red; //red
        dy2[num2] = 0.5 + alpha;
        dx2[num2] = 0.5 + alpha || -0.5 -alpha;
        colorJudge2[num2] =4;
        
    }
    
}



//あたり判定

-(void)Collision{
    
    for(int i=0;i<NUM;i++){
        
        for(int j=0;j<NUM2;j++){
            
            
            newImageV[i].frame = CGRectMake(ballX[i]+tempSize[i],ballY[i]+tempSize[i],size[i]-tempSize[i],size[i]-tempSize[i]);
            
            newImageV2[j].frame = CGRectMake(ballX2[j]+tempSize2[j],ballY2[j]+tempSize2[j],size2[j]-tempSize2[j],size2[j]-tempSize2[j]);
            
            if(isFire[i]){//指が離されたボールなら（動いているぼーるならば）
                
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
                        
                        [self score_update];
                        
                    }
                }
            }
        }
    }
}

-(void)Collision_hard{
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
                        
                        [self score_update];
                        
                    }else{//ボールの色が違う時
                        
                        if(colorJudge2[j] == 5){//スカイブルー
                            
                            if(skyblue_judge[j] == 0){//紫の状態
                                if(colorJudge[i] == 1){//青があたったら
                                    imageV2[j].image = ball_skyblue_green;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    skyblue_judge[j] = -1;
                                    
                                    [sound absorption_sound];
                                    
                                    
                                }else if (colorJudge[i] == 2){//緑が当たったら
                                    imageV2[j].image = ball_skyblue_blue;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    skyblue_judge[j] = 1;
                                    
                                    [sound absorption_sound];
                                    
                                }
                                
                            }else if(skyblue_judge[j] < 0 ){//スカイブルー_青の状態
                                if(colorJudge[i] == 2){//緑が当たったら消える
                                    comboCount ++;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:5];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    
                                    [self score_update];
                                }
                            }else if(skyblue_judge[j] > 0 ){//スカイブルー_緑の状態
                                if(colorJudge[i] == 1){//青が当たったら消える
                                    comboCount ++;
                                    
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:5];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    [self score_update];
                                }
                            }
                            
                            
                        }else if (colorJudge2[j] == 6){//パープル
                            
                            if(purple_judge[j] == 0){//紫の状態
                                if(colorJudge[i] == 1){//青があたったら
                                    imageV2[j].image = ball_purple_red;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    
                                    [sound absorption_sound];
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    
                                    purple_judge[j] = -1;
                                }else if (colorJudge[i] == 4){//赤が当たったら
                                    imageV2[j].image = ball_purple_blue;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:4];//エフェクト
                                    [sound absorption_sound];
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    purple_judge[j] = 1;
                                }
                                
                            }else if(purple_judge[j] < 0 ){//紫_青の状態
                                if(colorJudge[i] == 4){//赤が当たったら消える
                                    comboCount ++;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:4];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:6];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    [self score_update];
                                }
                            }else if(purple_judge[j] > 0 ){//紫_赤の状態
                                if(colorJudge[i] == 1){//青が当たったら消える
                                    comboCount ++;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:6];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    
                                    [self score_update];
                                }
                            }
                            
                        }else if (colorJudge2[j] == 7){//ブラウン
                            
                            if(brawn_judge[j] == 0){//紫の状態
                                if(colorJudge[i] == 1){//青があたったら
                                    imageV2[j].image = ball_brawn_orange;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    [sound absorption_sound];
                                    
                                    
                                    brawn_judge[j] = -1;
                                }else if (colorJudge[i] == 3){//オレンジが当たったら
                                    imageV2[j].image = ball_brawn_blue;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:3];//エフェクト
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    [sound absorption_sound];
                                    
                                    brawn_judge[j] = 1;
                                }
                                
                            }else if(brawn_judge[j] < 0 ){//ブラウン_青の状態
                                if(colorJudge[i] == 3){//オレンジが当たったら消える
                                    comboCount ++;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:3];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:7];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    [self score_update];
                                }
                            }else if(brawn_judge[j] > 0 ){//ブラウン_オレンジの状態
                                if(colorJudge[i] == 1){//青が当たったら消える
                                    comboCount ++;
                                    
                                    [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                    [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:7];//エフェクト
                                    [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                    ballX2[j] = storageX2;//一旦すべて-600に配置される
                                    ballY2[j] = storageY2;//一旦すべて600に配置される
                                    
                                    ballX[i] = storageX;
                                    ballY[i] = storageY;
                                    isFire[i] = false;
                                    
                                    if(comboCount >= 6){
                                        [sound collision2_sound];
                                    }else{
                                        [sound collision_sound];
                                    }
                                    
                                    
                                    [self score_update];
                                }
                            }
                            
                        }else if(colorJudge2[j] == 11){//number_ball_blueの時
                            
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
                                        [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        [self score_update];
                                        break;
                                        
                                }
                                
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                                
                            }
                        }else if(colorJudge2[j] == 12){//number_ball_greenの時
                            
                            if(colorJudge[i] == 2){
                                
                                switch (green_number_judge[j]) {
                                    case 0:
                                        imageV2[j].image = ball_green_one;
                                        green_number_judge[j] ++;
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [sound absorption_sound];
                                        break;
                                    case 1:
                                        comboCount ++;
                                        
                                        [self effect:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:2];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        [self score_update];
                                        
                                        
                                        break;
                                        
                                }
                                
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                                
                            }
                        }else if(colorJudge2[j] == 13){//number_ball_orangeの時
                            
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
                                        [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:3];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        [self score_update];
                                        
                                        
                                        break;
                                        
                                }
                                
                                ballX[i] = storageX;
                                ballY[i] = storageY;
                                isFire[i] = false;
                                
                            }
                        }else if(colorJudge2[j] == 14){//number_ball_blue_fiveの時
                            
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
                                        [self effect_hard:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:1];//エフェクト
                                        [self combo:ballX2[j] int:ballY2[j]+HEIGHT*0.05 int:tempSize2[j] int:colorJudge[i]];//コンボ処理
                                        
                                        ballX2[j] = storageX2;//一旦すべて-600に配置される
                                        ballY2[j] = storageY2;//一旦すべて600に配置される
                                        if(comboCount >= 6){
                                            [sound collision2_sound];
                                        }else{
                                            [sound collision_sound];
                                        }
                                        [self score_update];
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


//得点の更新
-(void)score_update{
    
    totalScore  += score;
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    delegate.totalScore_del = [NSString stringWithFormat:@"%d",totalScore];//合計得点をデリゲードに渡す

    [self scoreCount];
    
    if(totalScore > highScore){//最高スコアが更新されたら
        
        highScore = totalScore;
        [self scoreCount2];
        delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
        delegate.NewRecord= @"YES";//記録が更新されたか否か
        ud = [NSUserDefaults standardUserDefaults];  // 取得
        if([delegate.mode isEqualToString:@"easy"]){
            [ud setInteger:highScore forKey:@"highScore_easy"];
        }else if([delegate.mode isEqualToString:@"normal"]){
            [ud setInteger:highScore forKey:@"highScore_normal"];
        }else if([delegate.mode isEqualToString:@"hard"]){
            [ud setInteger:highScore forKey:@"highScore_hard"];
        }
        [ud synchronize];//userDefaultsへの反映
    }
}



-(void)effect:(int)xPos int:(int)yPos int:(int)size int:(int)color{
    
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(10, 10);
    CGAffineTransform t2 = CGAffineTransformScale(t1,12.0, 12.0);
    
    //NSLog(@"xPos : %d, yPos : %d, size : %d,color :% d",xPos,yPos,size,color);
    
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

-(void)effect_hard:(int)xPos int:(int)yPos int:(int)size int:(int)color{
    
    
    CGAffineTransform t1 = CGAffineTransformMakeTranslation(10, 10);
    CGAffineTransform t2 = CGAffineTransformScale(t1,20.0, 20.0);
    CGAffineTransform t3 = CGAffineTransformRotate(t2, 90);
    
    
    [UIView animateWithDuration:1.0f
                          delay:0.2f
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
                             case 5:
                                 effectImageV.image = effect_skyblue;
                                 break;
                             case 6:
                                 effectImageV.image = effect_purple;
                                 break;
                             case 7:
                                 effectImageV.image = effect_brawn;
                                 break;
                         }
                         effectImageV.transform = t3;
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
                             score = 200;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 5;//チャージが5たまります
                                 [self chargeMake];
                             }
                         }else if (comboCount ==3){
                             comboV.image = combo2;
                             score = 300;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 5;//チャージが5たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount ==4){
                             comboV.image = combo3;
                             score = 400;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount ==5){
                             comboV.image = combo4;
                             score = 700;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                         }else if(comboCount >= 6){
                             comboV.image = comboMax;
                             score = 1000;
                             if(color !=5){//金色ボール以外だと
                                 chargeCount += 6;//チャージが6たまります
                                 [self chargeMake];
                             }
                             
                         }else{
                             comboV.image = nil;
                             score = 100;
                         }
                         
                         
                         comboV.transform = t2;
                         [self.view addSubview:comboV];
                         comboV.alpha = 0.0;
                     }
                     completion:^(BOOL finished){//処理が終わったら
                         comboV = nil;
                     }];
}

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
            goldenFrameV.frame = CGRectMake(-WIDTH*0.04, HEIGHT*0.89, WIDTH*1.08, HEIGHT*0.16);
            [self.view addSubview:goldenFrameV];
            
            //点滅アニメーション
            [UIView animateWithDuration:0.2f
                                  delay:0.5f
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


-(void)scoreCount{
    
    int tempScore_100000;//あまり
    int tempScore_10000;//あまり
    int tempScore_1000;//あまり
    int tempScore_100;//あまり
    int tempScore_10;//あまり
    
    int limit;
    int temp = totalScore;
    double between = WIDTH * 0.052;
    
    if(totalScore <1000){//3桁（2桁はあり得ない）
        
        for(int i=0;i<3;i++){
            scoreView[i].frame =CGRectMake(WIDTH * 0.33 -(i*between), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit = 3;
    }else if (totalScore <10000){//4桁
        for(int i=0;i<4;i++){
            scoreView[i].frame =CGRectMake(WIDTH * 0.36 -(i*between), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit =4;
    }else if (totalScore <100000){//5桁
        for(int i=0;i<5;i++){
            scoreView[i].frame =CGRectMake(WIDTH * 0.39 -(i*between), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit =5;
    }else{//6桁
        for(int i=0;i<6;i++){
            scoreView[i].frame =CGRectMake(WIDTH * 0.41 -(i*between), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit =6;
    }
    

    tempScore_100000 = temp / 100000;//(100000の位)
    temp %= 100000;//100000で割ったあまり
    tempScore_10000 = temp / 10000;//(10000の位)
    temp %= 10000;//10000で割ったあまり
    tempScore_1000 = temp / 1000;//1000の位
    temp %= 1000;//1000で割ったあまり
    tempScore_100 = temp / 100;//100の位
    temp %= 100;//100で割ったあまり
    tempScore_10 = temp / 10;//10の位
    scoreView[0].image = zero_white;//1の位
    
    [self ScoreJudge:tempScore_100000 int:5];
    [self ScoreJudge:tempScore_10000 int:4];
    [self ScoreJudge:tempScore_1000 int:3];
    [self ScoreJudge:tempScore_100 int:2];
    [self ScoreJudge:tempScore_10 int:1];
    
    for(int i=0;i<limit;i++){
        [self.view  addSubview:scoreView[i]];
    }
}

-(void)ScoreJudge:(int)a int:(int)tempId{
    
    switch (a) {
        case 0:
            scoreView[tempId].image = zero_white;
            break;
        case 1:
            scoreView[tempId].image = one_white;
            break;
        case 2:
            scoreView[tempId].image = two_white;
            break;
        case 3:
            scoreView[tempId].image = three_white;
            break;
        case 4:
            scoreView[tempId].image = four_white;
            break;
        case 5:
            scoreView[tempId].image = five_white;
            break;
        case 6:
            scoreView[tempId].image = six_white;
            break;
        case 7:
            scoreView[tempId].image = seven_white;
            break;
            
        case 8:
            scoreView[tempId].image = eight_white;
            break;
            
        default:
            scoreView[tempId].image = nine_white;
            break;
    }
    
}

-(void)scoreCount2{
    
    int tempScore_100000;//あまり
    int tempScore_10000;//あまり
    int tempScore_1000;//あまり
    int tempScore_100;//あまり
    int tempScore_10;//あまり
    
    int limit;
    
    int temp = (int)highScore;//ユーザデフォルトからの値, highScoreを取得
    double between = WIDTH * 0.052;
    
    //最初の時は0を表示
    if(temp == 0){
        scoreView2[0].frame = CGRectMake(WIDTH*0.74, HEIGHT*0.058,WIDTH*0.08, HEIGHT*0.06);
        limit = 0;
    }else if(temp <1000){//3桁（2桁はあり得ない）
        
        for(int i=0;i<3;i++){
            scoreView2[i].frame =CGRectMake(WIDTH*0.78-(between*i), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit = 3;
    }else if (temp <10000){//4桁
        for(int i=0;i<4;i++){
            scoreView2[i].frame =CGRectMake(WIDTH*0.82-(between*i), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit =4;
    }else if (temp <100000){//5桁
        for(int i=0;i<5;i++){
            scoreView2[i].frame =CGRectMake(WIDTH*0.84-(between*i),HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        limit =5;
    }else{//6桁
        for(int i=0;i<6;i++){
            scoreView2[i].frame =CGRectMake(WIDTH*0.87-(between*i), HEIGHT*0.058, WIDTH*0.08, HEIGHT*0.06);
        }
        
        limit =6;
    }
    
    
    //NSLog(@"limit : %d",limit);
    tempScore_100000 = temp / 100000;//(100000の位)
    temp %= 100000;//100000で割ったあまり
    tempScore_10000 = temp / 10000;//(10000の位)
    temp %= 10000;//10000で割ったあまり
    tempScore_1000 = temp / 1000;//1000の位
    temp %= 1000;//1000で割ったあまり
    tempScore_100 = temp / 100;//100の位
    temp %= 100;//100で割ったあまり
    tempScore_10 = temp / 10;//10の位
    scoreView2[0].image = zero_red;//1の位
    
    [self ScoreJudge2:tempScore_100000 int:5];
    [self ScoreJudge2:tempScore_10000 int:4];
    [self ScoreJudge2:tempScore_1000 int:3];
    [self ScoreJudge2:tempScore_100 int:2];
    [self ScoreJudge2:tempScore_10 int:1];
    
    for(int i=0;i<limit;i++){
        [self.view  addSubview:scoreView2[i]];
    }
}

-(void)ScoreJudge2:(int)a int:(int)tempId{
    
    
    switch (a) {
        case 0:
            scoreView2[tempId].image = zero_red;
            break;
        case 1:
            scoreView2[tempId].image = one_red;
            break;
        case 2:
            scoreView2[tempId].image = two_red;
            break;
        case 3:
            scoreView2[tempId].image = three_red;
            break;
        case 4:
            scoreView2[tempId].image = four_red;
            break;
        case 5:
            scoreView2[tempId].image = five_red;
            break;
        case 6:
            scoreView2[tempId].image = six_red;
            break;
        case 7:
            scoreView2[tempId].image = seven_red;
            break;
            
        case 8:
            scoreView2[tempId].image = eight_red;
            break;
            
        default:
            scoreView2[tempId].image = nine_red;
            break;
    }
    
}




@end

