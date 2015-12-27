//
//  ViewController3_1.m
//  BampingBalls
//
//  Created by Tsuru on 2014/07/25.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController3_1.h"
#import "Sound.h"
#import "AppDelegate.h"

AppDelegate * delegate;


@interface ViewController3_1 ()

@end

@implementation ViewController3_1

double WIDTH;
double HEIGHT;

CGRect hideRect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*------------------------------------------広告関連----------------------------------------*/
-(void)viewWillAppear:(BOOL)animated{
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];

    
    // 各言語の結果に対して処理を記述
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合(nend)
        
        // iPadかどうか判断する
        if ( ![modelname hasPrefix:@"iPad"] ) {//iphoneの時
        // NADView の作成
        nadview = [[NADView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-NAD_ADVIEW_SIZE_320x50.height,  NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
        // apiKey, spotID をセットする
        [nadview setNendID:@"71da0d3bccbdf5363d814de6917dc9fe68672bf8" spotID:@"209240"];
        }else{//iPadの時
        
        nadview = [[NADView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-90,  728,  90)];
        [nadview setNendID:@"e620ef4ac9ffc5d97f87a009d275c544f5ed794f" spotID:@"209857"];
        }
        
        
        // デリゲートオブジェクトの指定
        [nadview setDelegate:self];
        // 広告のロードを開始
        [nadview load];
        [self.view addSubview:nadview] ;
        
    } else {
        
        // iPadかどうか判断する
        if ( ![modelname hasPrefix:@"iPad"] ) {//iphoneの時
        // 3.インスタンスを生成
        bannerView = [[GADBannerView alloc]
                      initWithFrame:CGRectMake(0.0,
                                               self.view.frame.size.height - GAD_SIZE_320x50.height,
                                               GAD_SIZE_320x50.width,
                                               GAD_SIZE_320x50.height)];
        }else{
            bannerView = [[GADBannerView alloc]
                          initWithFrame:CGRectMake(0.0,
                                                   self.view.frame.size.height - GAD_SIZE_728x90.height,
                                                   GAD_SIZE_728x90.width,
                                                   GAD_SIZE_728x90.height)];
        
        }
        // 4.広告のユニット ID を設定
        bannerView.adUnitID = @"ca-app-pub-3081716991868318/8874615387";
        //  NSLog(@"iPhone,Admob");
        
        // 5.rootViewCpntroller を設定する
        bannerView.rootViewController = self;
        
        // 6.ビューを UI に追加
        [self.view addSubview:bannerView];
        
        // 7.広告と一緒にビューを読み込む
        [bannerView loadRequest:[GADRequest request]];
        
        // 開発段階では必ずテスト モードを使用
        // ---- AdMob test --->
        GADRequest *request = [GADRequest request];
        
        request.testDevices = [NSArray arrayWithObjects:
                               // シミュレータ
                               // GAD_SIMULATOR_ID,
                               // iOS 端末をテスト: TEST_DEVICE_ID
                               @"ffce5f772ced30da554bf13cb445fcf6c9ea6c53",
                               nil];
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*view3_1の初回起動か否かを判別*/
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"firstLaunch"];
    [ud synchronize];//userDefaultsへの反映*/
    
    WIDTH = self.view.frame.size.width;//画面の幅を取得
    HEIGHT = self.view.frame.size.height;//画面の幅を取得
    
    hideRect = CGRectMake(WIDTH, HEIGHT, 0, 0);
    
    backgroundV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT-50)];
    UIImage * background;
    
    // 各言語の結果に対して処理を記述
    background = [UIImage imageNamed:@"background3_1.png"];//画像の取得
    backgroundV.image = background;
    [self.view addSubview:backgroundV];
    
    //temp
    background_tempV = [[UIImageView alloc] init];
    UIImage * background_temp = [UIImage imageNamed:@"temp.png"];
    background_tempV.image = background_temp;
    
    //コンボスコア
    UIImage * comboScore = [UIImage imageNamed:@"combo_score_table.png"];
    comboScoreV = [[UIImageView alloc]init];
    comboScoreV.image = comboScore;
    
    //mode画面
    UIImage * mode = [UIImage imageNamed:@"please_select_mode.png"];
    modeV = [[UIImageView alloc]init];
    modeV.image = mode;
    
    //×ボタン
    UIImage * batsuImage = [UIImage imageNamed:@"batsu.png"];//画像の取得
    batsuBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    [batsuBtn setBackgroundImage:batsuImage forState:UIControlStateNormal];  // 画像をセットする
    [batsuBtn addTarget:self action:@selector(batsuBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIImage * backImage = [UIImage imageNamed:@"backImage.png"];//画像の取得
    backBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    backBtn.frame =CGRectMake(10,15,HEIGHT*0.08,HEIGHT*0.08);//位置と大きさ
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];  // 画像をセットする
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIImage * howImage = [UIImage imageNamed:@"how_to_play.png"];
    UIImage * goldenBallImage = [UIImage imageNamed:@"golden_ball.png"];
    UIImage * modeImage = [UIImage imageNamed:@"mode.png"];
    UIImage * comboScoreImage = [UIImage imageNamed:@"combo_score.png"];
    UIImage * bluetoothImage = [UIImage imageNamed:@"bluetooth_play_3_1.png"];
    
    for(int i=0;i<5;i++){
        btn[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn[i].frame =CGRectMake(WIDTH*0.2,HEIGHT*0.15+(HEIGHT*0.15*i),WIDTH*0.6,WIDTH*0.2);//位置と大きさ
        switch (i) {
            case 0:
                [btn[i] setBackgroundImage:howImage forState:UIControlStateNormal];  // 画像をセットする
                [btn[i] addTarget:self action:@selector(button0) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 1:
                [btn[i] setBackgroundImage:goldenBallImage forState:UIControlStateNormal];  // 画像をセットする
                [btn[i] addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 2:
                [btn[i] setBackgroundImage:modeImage forState:UIControlStateNormal];  // 画像をセットする
                [btn[i] addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                
                [btn[i] setBackgroundImage:comboScoreImage forState:UIControlStateNormal];  // 画像をセットする
                [btn[i] addTarget:self action:@selector(button3) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 4:
                [btn[i] setBackgroundImage:bluetoothImage forState:UIControlStateNormal];  // 画像をセットする
                [btn[i] addTarget:self action:@selector(button4) forControlEvents:UIControlEventTouchUpInside];
                break;
                
                
        }
        [self.view addSubview:btn[i]];
    }
    
    sound = [[Sound alloc]init];
    
    UIImage * easy = [UIImage imageNamed:@"easy.png"];
    UIImage * normal = [UIImage imageNamed:@"normal.png"];
    UIImage * hard = [UIImage imageNamed:@"hard.png"];
    
    for(int i=0;i<3;i++){
        helpBtn[i] = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        switch (i) {
            case 0:
                [helpBtn[i] setBackgroundImage:easy forState:UIControlStateNormal];
                [helpBtn[i] addTarget:self action:@selector(easyBtn) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                [helpBtn[i] setBackgroundImage:normal forState:UIControlStateNormal];
                [helpBtn[i] addTarget:self action:@selector(normalBtn) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [helpBtn[i] setBackgroundImage:hard forState:UIControlStateNormal];
                [helpBtn[i] addTarget:self action:@selector(hardBtn) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
    }
    
    
}


//how to play ボタン
-(void)button0{
    
    //AudioServicesPlaySystemSound(button_sound);
    [sound button_sound];
    
    UIViewController * rule = [self.storyboard instantiateViewControllerWithIdentifier:@"rule"];
    rule.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:rule animated:YES completion:nil];
    
}

//golden ball ボタン
-(void)button1{
    
    //AudioServicesPlaySystemSound(button_sound);
    [sound button_sound];
    
    UIViewController * golden_ball = [self.storyboard instantiateViewControllerWithIdentifier:@"golden_ball"];
    golden_ball.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:golden_ball animated:YES completion:nil];
    
}

//modeボタン
-(void)button2{
    [sound button_sound];
    
    background_tempV.frame = self.view.bounds;
    batsuBtn.frame =CGRectMake(WIDTH*0.05, HEIGHT*0.3,WIDTH*0.1,WIDTH*0.1);//位置と大きさ
    modeV.frame = CGRectMake(WIDTH*0.05, HEIGHT*0.3, WIDTH*0.9, WIDTH*0.4);
    for(int i=0;i<3;i++){
        helpBtn[i].frame =CGRectMake(WIDTH*0.05+(WIDTH*0.3*i),HEIGHT*0.4,WIDTH*0.3,WIDTH*0.2);//位置と大きさ
    }
    
    [self.view addSubview:background_tempV];
    [self.view addSubview:modeV];
    for(int i=0;i<3;i++){
        [self.view addSubview:helpBtn[i]];
    }
    [self.view addSubview:batsuBtn];
    
}

//comboscoreボタン
-(void)button3{
    [sound button_sound];
    
    background_tempV.frame = self.view.bounds;
    comboScoreV.frame = CGRectMake(WIDTH*0.13, HEIGHT*0.3, WIDTH*0.75, WIDTH*0.6);
    batsuBtn.frame =CGRectMake(WIDTH*0.13, HEIGHT*0.3,WIDTH*0.1,WIDTH*0.1);//位置と大きさ
    [self.view addSubview:background_tempV];
    [self.view addSubview:comboScoreV];
    [self.view addSubview:batsuBtn];
}

//bluetoothボタン
-(void)button4{
    [sound button_sound];
    UIViewController * bluetooth_help = [self.storyboard instantiateViewControllerWithIdentifier:@"bluetooth_help"];
    bluetooth_help.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:bluetooth_help animated:YES completion:nil];
    
    
}
//×ボタンが押された時
-(void)batsuBtn{
    [sound button_sound];
    
    background_tempV.frame = hideRect;
    comboScoreV.frame = hideRect;
    batsuBtn.frame = hideRect;
    
    modeV.frame = hideRect;
    for(int i=0;i<3;i++){
        helpBtn[i].frame = hideRect;
    }
    
    [self.view addSubview:background_tempV];
    [self.view addSubview:comboScoreV];
    [self.view addSubview:batsuBtn];
    [self.view addSubview:modeV];
    for(int i=0;i<3;i++){
        [self.view addSubview:helpBtn[i]];
    }
    
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

-(void)easyBtn{
    [sound button_sound];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.help_mode = @"help_easy";
    
    UIViewController * help_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"help_detail"];
    help_detail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: help_detail animated:YES completion:nil];
    
    
}

-(void)normalBtn{
    [sound button_sound];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.help_mode = @"help_normal";
    
    UIViewController * help_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"help_detail"];
    help_detail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: help_detail animated:YES completion:nil];
    
}

-(void)hardBtn{
    [sound button_sound];
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.help_mode = @"help_hard";
    
    UIViewController * help_detail = [self.storyboard instantiateViewControllerWithIdentifier:@"help_detail"];
    help_detail.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController: help_detail animated:YES completion:nil];
}

-(void)backBtn{
    // AudioServicesPlaySystemSound(button_sound);
    [sound button_sound];
    
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    vc0.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc0 animated:YES completion:nil];
    
}


@end
