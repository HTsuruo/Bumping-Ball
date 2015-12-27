//
//  ViewController2_1.h
//  Bumping Ball
//
//  Created by Tsuru on 2014/08/29.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "Sound.h"
#import "BGM.h"
#import "Difficulty.h"

#define NUM 15 //自分が一度に画面に表示できる最大個数
#define NUM2 10 //CPUが一度に画面に表示できる最大個数
#define NUM3 5 //CPUが一度に画面に表示できる最大個
#define NUM4 10 //相手からきたボールが一度に画面に表示できる数

@interface ViewController2_1 : UIViewController<GKPeerPickerControllerDelegate,GKSessionDelegate>{

    NSData * sendData;
    
    //背景
    UIImageView * imageBack;
    
    //タイマー関連
    NSTimer * tm;
    NSTimer * tmSize;
    NSTimer * CPUtm;
    
    Sound *sound;
    BGM * bgm;
    
    Difficulty * difficulty;
    
    UIImageView  * life_name[2];
    
    //ストップメニュー関連
    UIButton * stopButton;//stopBtton;
    UIButton * restartBtn;//再開ボタン
    UIButton * cutBtn;//接続を切るボタン
    UIImageView * stopMenuV;//ストップメニューのイメージビュー
    UIImageView * stopMenu2V;//ストップメニューのイメージビュー
    
    //ボール関連
    //自分のボール
    UIImageView * imageV[NUM];
    UIImageView * imageV2[NUM2];
    //CPUボール
    UIImageView * newImageV[NUM];
    UIImageView * newImageV2[NUM2];
    //アイテムボール
    UIImageView * imageV3[NUM3];
    UIImageView * newImageV3[NUM3];
    
    
    
    //ボールの画像取得
    UIImage * ball_blue;
    UIImage * ball_green;
    UIImage * ball_orange;
    UIImage * ball_red;
    UIImage * ball_gold;
    
    //相手から送られてくるボール
    UIImage * ball_blue_five;
    UIImage * ball_blue_four;
    UIImage * ball_blue_three;
    UIImage * ball_blue_two;
    UIImage * ball_blue_one;
    UIImage * ball_green_three;
    UIImage * ball_green_two;
    UIImage * ball_green_one;
    UIImage * ball_orange_two;
    UIImage * ball_orange_one;
    
    //UIImage * ball_one_up;
    UIImage * ball_reverse;
    UIImage * ball_speed_up;
    
    
    //ボールのエフェクト画像
    UIImage * effect_blue;
    UIImage * effect_green;
    UIImage * effect_orange;
    UIImage * effect_red;
    UIImage* effect_gold;
    //エフェクトを表示するためのビュー
    UIImageView * effectImageV;
    
    //カウントダウン関連
    UIImageView * CountDownV;//カウントダウンのイメージビュー
    NSTimer * countDownT;//カウントダウンタイマー
    UIImage * three;
    UIImage * two;
    UIImage* one;
    UIImage * go;
    
    //コンボのための表示
    UIImageView * comboV;
    UIImage * combo1;
    UIImage * combo2;
    UIImage * combo3;
    UIImage * combo4;
    UIImage * comboMax;

    //ライフ関連
    UIImageView  * lifeV[3][2];//[ライフの数][you or rival]
   // UIImage * life_no_blue;
    UIImage * life_yes_blue;
    //UIImage * life_no_red;
    UIImage * life_yes_red;
    
    //アイテムボールの画像取得
    UIImage * itemBall_blue;
    UIImage * itemBall_green;
    UIImage * itemBall_orange;
    UIImage * itemBall_red;
    UIImage * itemBall_golden;
    
    //相手から送られてきたボールの画像取得
    UIImage * rival_ball_blue;
    UIImage * rival_ball_green;
    UIImage * rival_ball_orange;
    UIImage * rival_ball_red;
    
    //チャージ関連
    UIImageView * chargeV;
    UIImage * charge_zero;
    UIImage * charge_one;
    UIImage * charge_two;
    UIImage * charge_three;
    UIImage * charge_four;
    UIImage * charge_five;
    UIImage * charge_six;
    UIImage * charge_seven;
    UIImage * charge_comp;
    
    //金色の枠を作成
    UIImageView * goldenFrameV;
    UIImage * goldenImage;
    UIImageView  * golden_effectV;
    UIImage * golden_effect;
    
    //相手の画面に何個のボールが存在するかの表示
    UIImageView * ballTotalV;
    UIImage * zero_white;
    UIImage * one_white;
    UIImage * two_white;
    UIImage * three_white;
    UIImage * four_white;
    UIImage * five_white;
    UIImage * six_white;
    UIImage * seven_white;
    UIImage * eight_white;
    UIImage * nine_white;
    UIImage * many_white;
    
    UIImageView *eventV;
    UIImage * reverse_alert;
    UIImage * speed_up_alert;


    
}
//プロパティの作成
@property GKPeerPickerController * picker;
@property GKSession * currentSession;

@end
