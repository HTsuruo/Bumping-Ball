//
//  ViewController0.h
//  Ball
//
//  Created by Tsuru on 2014/06/19.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <GameKit/GameKit.h>
#import "Sound.h"

@interface ViewController0 :UIViewController<GKMatchDelegate,GKMatchmakerViewControllerDelegate>{
    
    UIButton * btn[3];//一人とbluetooth play network play
    UIButton * btn2;//モード変更ボタン
    UIButton * btn3[2];//ルールボタンとランキングボタン
    
    //背景を決めるボタン
    UIButton * backBtn[5];

    UIImageView * imageBack;//背景ビュー
    UIImage * back;//背景
    
    NSTimer * tm;//選択のタイマー
    
    UIImageView * imageV;
    UIImage * image;
    
    //背景のアイコンの画像
    UIImage * theme1;
    UIImage * theme2;
    UIImage * theme3;
    UIImage * theme4;
    UIImage * theme5;
    
    //背景の画像
    UIImage * background;
    UIImage * background2;
    UIImage * background3;
    UIImage * background4;
    UIImage * background5;
        
    Sound * sound;
    
    //モード変更ボタン
    UIImage * easy;
    UIImage * normal;
    UIImage * hard;
    
    GKMatch * currentMatch;
    
    UIImageView * checkV;
    UIImage *check;
    
}



@end




