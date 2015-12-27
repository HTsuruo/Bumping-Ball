//
//  ViewController.h
//  Ball
//
//  Created by Tsuru on 2014/06/06.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Sound.h"
#import "BGM.h"
#import "Difficulty.h"

#define NUM 15 //自分が一度に画面に表示できる最大個数
#define NUM2 10 //CPUが一度に画面に表示できる最大個数

@interface ViewController : UIViewController{
    
    UIImageView * imageV[NUM];
    UIImageView * imageV2[NUM2];
    
    
    NSTimer * tm;
    NSTimer * tmSize;
    NSTimer * CPUtm;
    
    //背景
    UIImageView * imageBack;
    
    //ボールの画像取得
    UIImage * ball_blue;
    UIImage * ball_green;
    UIImage * ball_orange;
    UIImage * ball_red;
    UIImage * ball_gold;
    UIImage * ball_purple;
    UIImage * ball_skyblue;
    UIImage * ball_purple_red;
    UIImage * ball_purple_blue;
    UIImage * ball_skyblue_green;
    UIImage * ball_skyblue_blue;
    UIImage * ball_brawn;
    UIImage * ball_brawn_orange;
    UIImage * ball_brawn_blue;
    UIImage * ball_blue_five;
    UIImage * ball_blue_four;
    UIImage * ball_blue_three;
    UIImage * ball_blue_two;
    UIImage * ball_blue_one;
    UIImage * ball_green_two;
    UIImage * ball_green_one;
    UIImage * ball_orange_two;
    UIImage * ball_orange_one;
    
    
    //ボールのエフェクト画像
    UIImage * effect_blue;
    UIImage * effect_green;
    UIImage * effect_orange;
    UIImage * effect_red;
    UIImage* effect_gold;
    UIImage* effect_skyblue;
    UIImage* effect_purple;
    UIImage* effect_brawn;
    
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
    
    //エフェクトを表示するためのビュー
    UIImageView * effectImageV;
    
    UILabel * label;
    
    UIButton * stopButton;//stopBtton;
    
    UIButton * restartBtn;//再開ボタン
    UIButton * exitBtn;//終了ボタン
    UIImageView * stopMenuV;//ストップメニューのイメージビュー
    
    UIImageView * CountDownV;//カウントダウンのイメージビュー
    NSTimer * countDownT;//カウントダウンタイマー
    UIImage * three;
    UIImage * two;
    UIImage* one;
    UIImage * go;
    
    UIImageView * scoreV;//スコアのビュー
    UILabel * scoreLabel;//スコア表示するラベル
    
    //矩形の調整のためのイメージビュー
    UIImageView * newImageV[NUM];
    UIImageView * newImageV2[NUM2];
    
    //ハイスコアを表示するため
    UIImageView * HighScoreV;
    UILabel * HighScoreLabel;
    NSUserDefaults * ud;
    
    //コンボのための表示
    UIImageView * comboV;
    UIImage * combo1;
    UIImage * combo2;
    UIImage * combo3;
    UIImage * combo4;
    UIImage * comboMax;
  
    
    //スコアを表示するための準備
    UIImageView * scoreView[7];
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
    
    //ハイスコアを表示するための準備
    UIImageView * scoreView2[7];
    UIImage * zero_red;
    UIImage * one_red;
    UIImage * two_red;
    UIImage * three_red;
    UIImage * four_red;
    UIImage * five_red;
    UIImage * six_red;
    UIImage * seven_red;
    UIImage * eight_red;
    UIImage * nine_red;

    //UIImageView *reverseV;
    
    Sound * sound;
    BGM * bgm;
    
    /*----Diddicultyクラスのための変数宣言---*/
    Difficulty * difficulty;
    NSArray * array;
 
}

@end
