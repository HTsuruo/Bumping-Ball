//
//  Difficulty.h
//  Bumping Ball
//
//  Created by Tsuru on 2014/09/16.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Difficulty : NSObject{
    NSUserDefaults * ud;
    NSArray * array;
}

-(NSArray *)dif_3_5;
-(NSArray *)dif_4;
-(NSArray *)dif_iPad;

-(NSArray *)battleMode;
-(NSArray *)battleMode_iPad;

@end
