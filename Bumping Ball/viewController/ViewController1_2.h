//
//  ViewController1_2.h
//  Ball
//
//  Created by Tsuru on 2014/06/25.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Social/Social.h>//SNSのためのライブラリ
#import "NADView.h"//広告のためのライブラリ
#import "Sound.h"

@interface ViewController1_2 : UIViewController<NADViewDelegate> {
    
    
    UIButton * btn[2];//もう一度、終了、する3つのボタン
    UIImageView * backGroundV;//背景の設
    UILabel * scoreLabel;//scoreを表示するラベル
    UIButton * snsB[2];//twitterとfacebookのアイコン
    
    SLComposeViewController * cvc;//twitter
    SLComposeViewController * cvc2;//facebook
    
    UIImageView * NewRecordV;
    
    UIImage * twitterImage;
    UIImage * facebookImage;

    NSString * str1;//snsにつなぐ時の文字１
    NSString* str2;//snsにつなぐ時の文字2
    NSString * str;//文字列を連結する
    
    UIAlertView * av;//投稿完了の通知通知
    UIAlertView * av2;//投稿完了の通知通知
    UIAlertView * av3;//投稿完了の通知通知
    
    UIAlertView * av_review;//レビューアラーと
    
    //スコアを表示するための準備
    UIImageView * scoreView[7];
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
    
    //広告関連
    NADView *nadview;
    
    Sound * sound;
    
    NSTimer * tm;

}





@end

