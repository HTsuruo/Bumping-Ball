//
//  BGM.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/08/29.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "BGM.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

AppDelegate * delegate;


//BGMの宣言
AVAudioPlayer * bgm;

@implementation BGM

-(void)BGM_load{
//BGM1の読み込み
NSURL * url01 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"eternal_galaxy"] withExtension:@"mp3"];

//BGM2の読み込み
NSURL * url02 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"summer"] withExtension:@"mp3"];
//BGM3の読み込み
NSURL * url03 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"waterblue"] withExtension:@"mp3"];
//BGM4の読み込み
NSURL * url04 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"dancing"] withExtension:@"mp3"];
//BGM5の読み込み
NSURL * url05 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"komorebi"] withExtension:@"mp3"];

delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
NSString * name = delegate.themeName;//背景の名前を取得します
//NSLog(@"%@",name);
if([name isEqualToString:@"sky"]){//空
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:nil];
}/*else if([name isEqualToString:@"space"]){//宇宙
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:nil];
}*/else if([name isEqualToString:@"mono"]){//モノクロ
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url04 error:nil];
}else if([name isEqualToString:@"wood"]){//木
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url05 error:nil];
}else if([name isEqualToString:@"default"]){//デフォルト
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:nil];
}else{
    bgm = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:nil];//デフォルトで宇宙
}
    
    
bgm.numberOfLoops = -1;//無限ループ
bgm.volume = 0.7f;//音量設定(0.0~1.0)
[bgm prepareToPlay];
}
 
 -(void)BGM_play{
     [bgm play];
 }

-(void)BGM_pause{
    [bgm pause];
}

-(void)BGM_stop{
     [bgm stop];
}


@end
