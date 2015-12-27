//
//  ViewController2_2.h
//  Bumping Ball
//
//  Created by Tsuru on 2014/09/26.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"

@interface ViewController2_2 : UIViewController{
    UIButton * btn[2];
    Sound * sound;
    
    //スコアを表示するための準備
    UIImageView * scoreView[4][2];
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
    
    NSUserDefaults * ud;
}

@end
