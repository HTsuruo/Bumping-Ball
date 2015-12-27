//
//  ViewController3_1.h
//  BampingBalls
//
//  Created by Tsuru on 2014/07/25.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "NADView.h"//nend広告のためのライブラリ
#import "GADBannerView.h"//admob

@interface ViewController3_1 : UIViewController{
    
    UIButton * backBtn;
    UIButton * batsuBtn;
    UIImageView * backgroundV;
    UIImageView * background_tempV;
    
    UIButton * btn[5];//mainButton
    
    //モード
    UIImageView * modeV;
    UIButton * helpBtn[3];
    
    //コンボスコア
    UIImageView * comboScoreV;
    
    Sound * sound;
    
    //広告関連
    NADView *nadview;
    
    GADBannerView * bannerView;
}

@end
