//
//  AppDelegate.h
//  Ball
//
//  Created by Tsuru on 2014/06/06.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIImage * themeImage;//背景画像

@property (strong, nonatomic) NSString * themeName;//背景画像を選択した際の番号

@property (strong, nonatomic) NSString *  timeSecond;

@property (strong, nonatomic) NSString *  ScoreS;

@property (strong, nonatomic) NSString *  totalScore_del;//難易度設定の為に合計得点をデリゲードに渡す


@property (strong, nonatomic) NSString * NewRecord;//"YES"か"NO"で判断する

@property (strong, nonatomic) NSString * mode;//modeの保持

@property (strong, nonatomic) NSString * help_mode;//help画面におけるmodeの保持

@property (strong, nonatomic) NSString * win_lost_bluetooth;//bluetoothにおけるwinまたはlost

@property (strong, nonatomic) NSString * totalTime;//対戦モードの難易度を調整するためのトータルタイム

@property (strong, nonatomic) GKMatch * myMatch;

@property (strong, nonatomic) NSString * gameCenerAvailable;

@property BOOL matchStarted;






@end
