//
//  ViewController2_2.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/09/26.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "ViewController2_2.h"
#import "AppDelegate.h"
#import "Sound.h"
#import <AVFoundation/AVFoundation.h>

AppDelegate * delegate;

AVAudioPlayer * result_sound;//ボタンを押したときの効果音

@interface ViewController2_2 ()

@end

@implementation ViewController2_2

float WIDTH;
float HEIGHT;

NSInteger total_win;
NSInteger total_lost;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取
    
    sound = [[Sound alloc]init];
    
    
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
    
    for(int i=0;i<4;i++){
    scoreView[i][0] = [[UIImageView alloc]init];//win
    scoreView[i][1] = [[UIImageView alloc]init];//lost
    }
    
    //ハイスコアを取得
    ud = [NSUserDefaults standardUserDefaults];     //ユーザデフォルトのインスタンスを作成
    total_win = [ud integerForKey:@"total_win"];
    total_lost = [ud integerForKey:@"total_lost"];
    
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"result"] withExtension:@"mp3"];
    result_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    result_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [result_sound play];
    
    UIImage * background;
    
    if([delegate.win_lost_bluetooth isEqualToString:@"win"]){//winなら
        background = [UIImage imageNamed:@"background2_2_win.png"];
        total_win ++;
    }else{//lostなら
        background = [UIImage imageNamed:@"background2_2_lost.png"];
        total_lost ++;
    }
    
    UIImageView * backgroundV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroundV.image = background;
    [self.view addSubview:backgroundV];
    
    UIImage * again = [UIImage imageNamed:@"again.png"];
    UIImage * home = [UIImage imageNamed:@"home.png"];
    
    for(int i=0;i<2;i++){
        
        btn[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        // 機種の取得
        NSString *modelname = [ [ UIDevice currentDevice] model];
        
        if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
        btn[i].frame =CGRectMake(WIDTH*0.14+(WIDTH*0.4*i),HEIGHT*0.7,WIDTH*0.3,WIDTH*0.3);//位置と大きさ
        }else{
        btn[i].frame =CGRectMake(WIDTH*0.14+(WIDTH*0.4*i),HEIGHT*0.65,WIDTH*0.3,WIDTH*0.3);//位置と大きさ
        }
        
        switch (i) {
                
            case 0:
                [btn[0] setBackgroundImage:again forState:UIControlStateNormal];  // 画像をセットする
                [btn[0] addTarget:self action:@selector(againButton) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            case 1:
                [btn[1] setBackgroundImage:home forState:UIControlStateNormal];  // 画像をセットする
                [btn[1] addTarget:self action:@selector(homeButton) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
        
        [self.view addSubview:btn[i]];
    }
    
    [self scoreCount:(int)total_win int: 0];
    [self scoreCount:(int)total_lost int: 1];
    [ud setInteger:(int)total_win forKey:@"total_win"];
    [ud setInteger:(int)total_lost forKey:@"total_lost"];
    [ud synchronize];//userDefaultsへの反映
    
}

-(void)againButton{
    
    [sound button_sound];
    
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    // iPadかどうか判断する
    if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
    UIViewController * vc2_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_1"];
    vc2_1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc2_1 animated:YES completion:nil];
    
    }else{
        UIViewController * vc2_1_iPad = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_1_iPad"];
        vc2_1_iPad.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc2_1_iPad animated:YES completion:nil];
    }
}

-(void)homeButton{
    
    [sound button_sound];
    
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
    vc0.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc0 animated:YES completion:nil];
    
}

-(void)scoreCount:(int) temp int:(int)j{
    
    int tempScore_1000;//あまり
    int tempScore_100;//あまり
    int tempScore_10;//あまり
    int tempScore_1;//あまり
    
    int limit;
    
    double between = WIDTH * 0.15;
    
    float scoreHeight;
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外
    scoreHeight = HEIGHT*0.33+(HEIGHT*0.2*j);
    }else{
        scoreHeight = HEIGHT*0.3+(HEIGHT*0.2*j);
    }
    
    if(temp <10){//1桁
        
        for(int i=0;i<1;i++){
            scoreView[i][j].frame =CGRectMake(WIDTH * 0.55 -(i*between), scoreHeight, WIDTH*0.25, WIDTH*0.25);
        }
        limit = 1;
    }
    else if(temp <100){//2桁
        
        for(int i=0;i<2;i++){
            scoreView[i][j].frame =CGRectMake(WIDTH * 0.65 -(i*between), scoreHeight, WIDTH*0.25,WIDTH*0.25);
        }
        limit = 2;
    }
    else if(temp <1000){//3桁
        
        for(int i=0;i<3;i++){
            scoreView[i][j].frame =CGRectMake(WIDTH * 0.7 -(i*between), scoreHeight, WIDTH*0.25,WIDTH*0.25);
        }
        
        limit = 3;
    }else{//4桁
        between = WIDTH * 0.1;
        for(int i=0;i<4;i++){
            scoreView[i][j].frame =CGRectMake(WIDTH * 0.75 -(i*between), HEIGHT*0.35+(HEIGHT*j*0.22),WIDTH*0.16,WIDTH*0.16);
        }
        
        limit = 4;
    }
    
    tempScore_1000 = temp / 1000;//1000の位
    temp %= 1000;//1000で割ったあまり
    tempScore_100 = temp / 100;//100の位
    temp %= 100;//100で割ったあまり
    tempScore_10 = temp / 10;//10の位
    temp %= 10;//10で割ったあまり
    tempScore_1 = temp;//1の位
    
    [self ScoreJudge:tempScore_1000 int:3 int:j];
    [self ScoreJudge:tempScore_100 int:2 int:j];
    [self ScoreJudge:tempScore_10 int:1 int:j];
    [self ScoreJudge:tempScore_1 int:0 int:j];
    
    for(int i=0;i<limit;i++){
        [self.view  addSubview:scoreView[i][j]];
    }
}

-(void)ScoreJudge:(int)a int:(int)tempId int:(int) j{
    
    switch (a) {
        case 0:
            scoreView[tempId][j].image = zero_white;
            break;
        case 1:
            scoreView[tempId][j].image = one_white;
            break;
        case 2:
            scoreView[tempId][j].image = two_white;
            break;
        case 3:
            scoreView[tempId][j].image = three_white;
            break;
        case 4:
            scoreView[tempId][j].image = four_white;
            break;
        case 5:
            scoreView[tempId][j].image = five_white;
            break;
        case 6:
            scoreView[tempId][j].image = six_white;
            break;
        case 7:
            scoreView[tempId][j].image = seven_white;
            break;
            
        case 8:
            scoreView[tempId][j].image = eight_white;
            break;
            
        case 9:
            scoreView[tempId][j].image = nine_white;
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
