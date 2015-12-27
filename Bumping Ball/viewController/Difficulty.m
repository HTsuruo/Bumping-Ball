//
//  Difficulty.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/09/16.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "Difficulty.h"
#import "ViewController.h"
#import "AppDelegate.h"


AppDelegate * delegate;

@implementation Difficulty

int often;
float alpha;
NSString * oftenS;
NSString * alphaS;
const float iPad_num = 1.8;

//3.5インチの時の難易度
-(NSArray *)dif_3_5{
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    int totalScore = [delegate.totalScore_del intValue];//デリゲードから合計得点をもらう
    
    
    //[vc ballProduce:ボールの生成頻度:プラスされる速度]の形
    
    if(totalScore <500){
        often = 200;
        alpha = 0;
    }else if(totalScore < 1000) {//スコアが500を超えたら
        often = 150;
        alpha = 0.2;
    }else if(totalScore < 5000) {//スコアが1000を超えたら
        often = 100;
        alpha = 0.2;
    }else if(totalScore < 10000){//スコアが5000を超えたら(横に動き始める)
        often = 90;
        alpha = 0.2;
    }else if(totalScore < 25000){//スコアが10000を超えたら
        often = 80;
        alpha = 0.4;
    }else if(totalScore < 50000){//スコアが25000を超えたら
        often = 60;
        alpha = 0.6;
    }else if(totalScore < 70000){//スコアが50000を超えたら
        often = 50;
        alpha = 0.8;
    }else if(totalScore < 90000){//スコアが60000を超えたら
        often = 40;
        alpha = 1.1;
    }else if(totalScore < 100000){//スコアが80000を超えたら
        often = 40;
        alpha = 1.2;
    }else if(totalScore < 150000){//スコアが100000を超えたら
        often = 40;
        alpha = 1.3;
    }else if(totalScore < 200000){//スコアが150000を超えたら
        often = 40;
        alpha = 1.5;
    }else if(totalScore < 250000){//スコアが200000を超えたら
        often = 30;
        alpha = 1.7;
    }else if(totalScore < 300000){//スコアが250000を超えたら
        often = 30;
        alpha = 1.8;
    }else if(totalScore < 400000){//スコアが300000を超えたら
        often = 30;
        alpha = 2.0;
    }else if(totalScore < 500000){//スコアが400000を超えたら
        often = 30;
        alpha = 2.2;
    }else if(totalScore < 1000000){//スコアが500000を超えたら(500000超えたら神)
        often = 25;
        alpha = 2.3;
    }else{//totalScoreが999999を超えたら終了
        //終了の合図
        often = 0;
        alpha = 0;
    }
    
    oftenS = [NSString stringWithFormat:@"%d",often];
    alphaS = [NSString stringWithFormat:@"%f",alpha];
    
    array = [[NSArray alloc]initWithObjects:oftenS,alphaS, nil];
    
    return array;
}

//4インチの時の難易度
-(NSArray * )dif_4{
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    int totalScore = [delegate.totalScore_del intValue];//デリゲードから合計得点をもらう
    
    
    if(totalScore <500){
        often = 200;
        alpha = 0;
    }else if(totalScore < 1000) {//スコアが500を超えたら
        often = 150;
        alpha = 0.2;
    }else if(totalScore < 5000) {//スコアが1000を超えたら
        often = 100;
        alpha = 0.2;
    }else if(totalScore < 10000){//スコアが5000を超えたら(横に動き始める)
        often = 90;
        alpha = 0.4;
    }else if(totalScore < 25000){//スコアが10000を超えたら
        often = 80;
        alpha = 0.6;
    }else if(totalScore < 50000){//スコアが25000を超えたら
        often = 60;
        alpha = 0.8;
    }else if(totalScore < 70000){//スコアが50000を超えたら
        often = 50;
        alpha = 1.0;
    }else if(totalScore < 90000){//スコアが60000を超えたら
        often = 40;
        alpha = 1.2;
    }else if(totalScore < 100000){//スコアが80000を超えたら
        often = 40;
        alpha = 1.4;
    }else if(totalScore < 150000){//スコアが100000を超えたら
        often = 40;
        alpha = 1.5;
    }else if(totalScore < 200000){//スコアが150000を超えたら
        often = 40;
        alpha = 1.7;
    }else if(totalScore < 250000){//スコアが200000を超えたら
        often = 30;
        alpha = 1.9;
    }else if(totalScore < 300000){//スコアが250000を超えたら
        often = 30;
        alpha = 2.0;
    }else if(totalScore < 400000){//スコアが300000を超えたら
        often = 30;
        alpha = 2.2;
    }else if(totalScore < 500000){//スコアが400000を超えたら
        often = 30;
        alpha = 2.4;
    }else if(totalScore < 1000000){//スコアが500000を超えたら(500000超えたら神)
        often = 25;
        alpha = 2.5;
    }else{//totalScoreが999999を超えたら終了
        //終了の合図
        often = 0;
        alpha = 0;
    }
    
    oftenS = [NSString stringWithFormat:@"%d",often];
    alphaS = [NSString stringWithFormat:@"%f",alpha];
    
    array = [[NSArray alloc]initWithObjects:oftenS,alphaS, nil];
    
    return array;
}

//iPadの時の難易度
-(NSArray * )dif_iPad{
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    int totalScore = [delegate.totalScore_del intValue];//デリゲードから合計得点をもらう
    
    if(totalScore <500){
        often = 200;
        alpha = 0;
    }else if(totalScore < 1000) {//スコアが500を超えたら
        often = 150;
        alpha = 0.2*iPad_num;
    }else if(totalScore < 5000) {//スコアが1000を超えたら
        often = 100;
        alpha = 0.2*iPad_num;
    }else if(totalScore < 10000){//スコアが5000を超えたら(横に動き始める)
        often = 90;
        alpha = 0.4*iPad_num;
    }else if(totalScore < 25000){//スコアが10000を超えたら
        often = 80;
        alpha = 0.6*iPad_num;
    }else if(totalScore < 50000){//スコアが25000を超えたら
        often = 60;
        alpha = 0.8*iPad_num;
    }else if(totalScore < 70000){//スコアが50000を超えたら
        often = 50;
        alpha = 1.0*iPad_num;
    }else if(totalScore < 90000){//スコアが60000を超えたら
        often = 40;
        alpha = 1.2*iPad_num;
    }else if(totalScore < 100000){//スコアが80000を超えたら
        often = 40;
        alpha = 1.4*iPad_num;
    }else if(totalScore < 150000){//スコアが100000を超えたら
        often = 40;
        alpha = 1.5*iPad_num;
    }else if(totalScore < 200000){//スコアが150000を超えたら
        often = 40;
        alpha = 1.7*iPad_num;
    }else if(totalScore < 250000){//スコアが200000を超えたら
        often = 30;
        alpha = 1.9*iPad_num;
    }else if(totalScore < 300000){//スコアが250000を超えたら
        often = 30;
        alpha = 2.0*iPad_num;
    }else if(totalScore < 400000){//スコアが300000を超えたら
        often = 30;
        alpha = 2.2*iPad_num;
    }else if(totalScore < 500000){//スコアが400000を超えたら
        often = 30;
        alpha = 2.4*iPad_num;
    }else if(totalScore < 1000000){//スコアが500000を超えたら(500000超えたら神)
        often = 25;
        alpha = 2.5*iPad_num;
    }else{//totalScoreが999999を超えたら終了
        //終了の合図
        often = 0;
        alpha = 0;
    }
    
  
    
    oftenS = [NSString stringWithFormat:@"%d",often];
    alphaS = [NSString stringWithFormat:@"%f",alpha];
    
    array = [[NSArray alloc]initWithObjects:oftenS,alphaS, nil];
    
    return array;

}

//対戦モードのときの難易度
-(NSArray * )battleMode{
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    int totalTime = [delegate.totalTime intValue];//デリゲードから合計得点をもらう
    
    if(totalTime  == 1){
        often = 150;
        alpha = 0;
    }else if(totalTime == 3000) {
        often = 120;
        alpha = 0.2;
    }else if(totalTime == 6000){
        often = 100;
        alpha = 0.4;
    }else if(totalTime == 9000){
        often = 90;
        alpha = 0.6;
    }else if(totalTime == 12000){
        often = 80;
        alpha = 0.6;
    }else if(totalTime == 15000){
        often = 70;
        alpha = 0.6;
    }else if(totalTime == 18000){
        often = 70;
        alpha = 0.8;
    }else if(totalTime == 24000){
        often = 60;
        alpha = 0.8;
    }else if(totalTime == 30000){
        often = 60;
        alpha = 1.0;
    }else{
        often = 50;
        alpha = 1.0;
    }
    
    
    
    oftenS = [NSString stringWithFormat:@"%d",often];
    alphaS = [NSString stringWithFormat:@"%f",alpha];
    
    array = [[NSArray alloc]initWithObjects:oftenS,alphaS, nil];
    
    return array;
    
}

//対戦モードのときの難易度(iPad)
-(NSArray * )battleMode_iPad{
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文
    int totalTime = [delegate.totalTime intValue];//デリゲードから合計得点をもらう
    
    if(totalTime  == 1){
        often = 150;
        alpha = 0;
    }else if(totalTime == 3000) {
        often = 120;
        alpha = 0.2*iPad_num;
    }else if(totalTime == 6000){
        often = 100;
        alpha = 0.4*iPad_num;
    }else if(totalTime == 9000){
        often = 80;
        alpha = 0.4*iPad_num;
    }else if(totalTime == 12000){
        often = 80;
        alpha = 0.6*iPad_num;
    }else if(totalTime == 15000){
        often = 70;
        alpha = 0.6*iPad_num;
    }else if(totalTime == 18000){
        often = 70;
        alpha = 0.8*iPad_num;
    }else if(totalTime == 24000){
        often = 60;
        alpha = 0.8*iPad_num;
    }else if(totalTime == 30000){
        often = 60;
        alpha = 1.0*iPad_num;
    }else{
        often = 50;
        alpha = 1.0*iPad_num;
    }
    
    oftenS = [NSString stringWithFormat:@"%d",often];
    alphaS = [NSString stringWithFormat:@"%f",alpha];
    
    array = [[NSArray alloc]initWithObjects:oftenS,alphaS, nil];
    
    return array;
    
}





@end
