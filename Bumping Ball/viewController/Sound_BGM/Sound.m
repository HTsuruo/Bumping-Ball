//
//  Sound.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/08/29.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "Sound.h"
#import <AVFoundation/AVFoundation.h>

@implementation Sound


//効果音の宣言
AVAudioPlayer * countDown_sound;//カウントダウンの効果音
AVAudioPlayer * go_sound;//goの効果音
AVAudioPlayer * bigger_sound;//biggerの効果音
AVAudioPlayer * release_sound;//指を離したときの効果音
AVAudioPlayer * button_sound;//ボタンを押したときの効果音
AVAudioPlayer * collision_sound;//消滅したときの効果音
AVAudioPlayer * collision2_sound;//消滅したときの効果音
AVAudioPlayer * launch_sound;//発射した時の効果音
AVAudioPlayer * launch2_sound;//発射した時の効果音2(金ボール)
AVAudioPlayer * absorption_sound;//ボールが吸収されるおと
AVAudioPlayer * life_disapper_sound;//ボールが吸収されるおと
AVAudioPlayer * smaller_sound;//ボールが吸収されるおと
AVAudioPlayer * event_sound;
AVAudioPlayer * rivalBall_launch_sound;

/*---------------------------------効果音メソッド--------------------------------------*/

//countDownの読み込み

-(void)countDown_sound{
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"countDown"] withExtension:@"mp3"];
    countDown_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    countDown_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [countDown_sound play];
}

//goの読み込み
-(void)go_sound{
    NSURL * url_1 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"go"] withExtension:@"mp3"];
    go_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url_1 error:nil];
    go_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [go_sound play];
}

//biggerのよみこみ
-(void)bigger_sound{
    NSURL * url2 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"bigger2"] withExtension:@"mp3"];
    bigger_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url2 error:nil];
    bigger_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [bigger_sound play];
}
//biggerの停止(音がのびてうざいので)
-(void)bigger_sound_stop{
    [bigger_sound stop];
}

//releaseの読み込み
-(void)release_sound{
    NSURL * url3 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"release"] withExtension:@"mp3"];
    release_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url3 error:nil];
    release_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [release_sound play];
}

//buttonの読み込み
-(void)button_sound{
    NSURL * url4 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"button"] withExtension:@"mp3"];
    button_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url4 error:nil];
    button_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [button_sound play];
}

//collisionの読み込み
-(void)collision_sound{
    NSURL * url5 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"collision"] withExtension:@"mp3"];
    collision_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url5 error:nil];
    collision_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [collision_sound play];
}

//collision2の読み込み
-(void)collision2_sound{
    NSURL * url5_2 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"collision2"] withExtension:@"mp3"];
    collision2_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url5_2 error:nil];
    collision2_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [collision2_sound play];
}

//launchの読み込み
-(void)launch_sound{
    NSURL * url6 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"launch"] withExtension:@"mp3"];
    launch_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url6 error:nil];
    launch_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [launch_sound play];
}

//launch2効果音ファイル読み込み
-(void)launch2_sound{
    NSURL * url7 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"launch2"] withExtension:@"mp3"];
    launch2_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url7 error:nil];
    launch2_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [launch2_sound play];
}
//absorption効果音ファイル読み込み
-(void)absorption_sound{
    NSURL * url7 = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"absorption"] withExtension:@"mp3"];
    absorption_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url7 error:nil];
    absorption_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [absorption_sound play];
}

//life_disapper効果音ファイル読み込み
-(void)life_disapper_sound{
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"life_disapper"] withExtension:@"mp3"];
    absorption_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    absorption_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [absorption_sound play];
}


//smaller_sound効果音ファイル読み込み
-(void)smaller_sound{
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"smaller"] withExtension:@"mp3"];
    smaller_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    smaller_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [smaller_sound play];
}
//smallerの停止(音がのびてうざいので)
-(void)smaller_sound_stop{
    [smaller_sound stop];
}

//reverse or speedUP
-(void)event_sound{
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"event"] withExtension:@"mp3"];
    event_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    event_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [event_sound play];
}

//rivalBall
-(void)rivalBall_launch_sound{
    NSURL * url = [[NSBundle mainBundle] URLForResource: [NSString stringWithFormat:@"rivalBall_launch"] withExtension:@"mp3"];
    rivalBall_launch_sound = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    rivalBall_launch_sound.volume = 1.0f;//音量設定(0.0~1.0)*/
    [rivalBall_launch_sound play];
}


@end
