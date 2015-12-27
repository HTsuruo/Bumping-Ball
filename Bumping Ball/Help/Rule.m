//
//  Rule.m
//  Ball
//
//  Created by Tsuru on 2014/06/23.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "Rule.h"
#import "WSCoachMarksView.h"
#import "Sound.h"

@interface Rule ()

@end

@implementation Rule

double WIDTH;
double HEIGHT;

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
    
    sound = [[Sound alloc]init];
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得
    
    
    // 機種の取得
    NSString *modelname = [ [ UIDevice currentDevice] model];
    
    backgroundV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage * background;
    
    // iPadかどうか判断する
    if ( ![modelname hasPrefix:@"iPad"] ) {//iPad以外の時
    background = [UIImage imageNamed:@"background_explanation.png"];//画像の取得
    }else{
    background = [UIImage imageNamed:@"background_explanation_iPad.png"];//画像の取得
    }
    
    backgroundV.image = background;
    [self.view sendSubviewToBack:backgroundV];//最背面へ移動
    [self.view addSubview:backgroundV];
    
    
    UIImage * backImage = [UIImage imageNamed:@"backImage.png"];//画像の取得
    backBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    backBtn.frame =CGRectMake(10,15,HEIGHT*0.08,HEIGHT*0.08);//位置と大きさ
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];  // 画像をセットする
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    NSArray * coachMarks;
    
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
        coachMarks = @[
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,0},{0,0}}], @"caption": @"How to Play"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.93},{WIDTH,HEIGHT*0.12}}], @"caption": @"ここをタップするとボールが発射されるよ"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.72,HEIGHT*0.83},{WIDTH*0.22,HEIGHT*0.123}}], @"caption": @"こんな感じ"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.93},{WIDTH,HEIGHT*0.12}}], @"caption": @"長押しするとボールが大きくなるよ"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH/2,HEIGHT*0.5},{HEIGHT*0.16,HEIGHT*0.16}}], @"caption": @"こんな感じ \n 大きくなると色も変わよ"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.156,HEIGHT*0.123},{WIDTH*0.31,HEIGHT*0.246}}], @"caption": @"落ちてくるボールと同じ色のボールをバンプさせてボールを消そう"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.031,HEIGHT*0.6},{WIDTH*0.344,HEIGHT*0.176}}], @"caption": @"金色ボールは全てのボールを消す事ができるよ"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.92},{WIDTH,HEIGHT/56}}], @"caption": @"落ちてきたボールがここに当たったらゲームオーバーだよ"}];
    }else{
        coachMarks = @[
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,0},{0,0}}], @"caption": @"How to Play"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.93},{WIDTH,HEIGHT*0.12}}], @"caption": @"Ball is launched when tauch here"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.72,HEIGHT*0.83},{WIDTH*0.22,HEIGHT*0.123}}], @"caption": @"like that"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.93},{WIDTH,HEIGHT*0.12}}], @"caption": @"ball becomes bigger when long touch"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH/2,HEIGHT*0.5},{HEIGHT*0.16,HEIGHT*0.16}}], @"caption": @"like that \n color also changes when big"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.156,HEIGHT*0.123},{WIDTH*0.31,HEIGHT*0.246}}], @"caption": @"Try to hit opposite ball "},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{WIDTH*0.031,HEIGHT*0.6},{WIDTH*0.344,HEIGHT*0.176}}], @"caption": @"Gold ball can destroy all balls"},
                       @{@"rect": [NSValue valueWithCGRect:(CGRect){{0,HEIGHT*0.92},{WIDTH,HEIGHT/56}}], @"caption": @"Game Over when opposite ball comes in here"}];
    }

    // WSCoachMarksViewオブジェクトの作成
    WSCoachMarksView * coachMarksView = [[WSCoachMarksView alloc] initWithFrame:self.view.bounds coachMarks:coachMarks];
    
    // 親ビューに追加
    [self.view addSubview:coachMarksView];
    
    // コーチマークを表示する
    [coachMarksView start];
}



-(void)backBtn{
    
    [sound button_sound];
        
    UIViewController * vc3_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc3_1"];
    vc3_1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc3_1 animated:YES completion:nil];
    
}

@end
