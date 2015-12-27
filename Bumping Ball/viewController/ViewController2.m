//

//  ViewController2.m

//  Ball

//

//  Created by Tsuru on 2014/06/23.

//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.

//



#import "ViewController2.h"

#import <AudioToolbox/AudioToolbox.h>



AppDelegate * delegate;



SystemSoundID button_sound;//ボタンを押したときの効果音



@interface ViewController2 ()



@end



@implementation ViewController2



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
    }
    
    return self;
    
}



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    
    delegate.timeSecond =0;//制限時間の初期化
    
    
    
    //button効果音ファイル読み込み
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"button" ofType:@"mp3"];
    
    NSURL * url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &button_sound);
    
    
    
    
    
    UIImage * back = [UIImage imageNamed:@"background2_1.png"];
    
    backgroundV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    backgroundV.image = back;
    
    [self.view addSubview:backgroundV];
    
    
    
    
    
    UIImage * backImage = [UIImage imageNamed:@"backImage.png"];//画像の取得
    
    backBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    
    backBtn.frame =CGRectMake(10,20,50,50);//位置と大きさ
    
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];  // 画像をセットする
    
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backBtn];
    
    
    
    //--------------------------------------主な4つのボタン--------------------------------------//
    
    UIImage * sec_60 = [UIImage imageNamed:@"60sec.png"];//画像の取得
    
    UIImage * sec_40 = [UIImage imageNamed:@"40sec.png"];//画像の取得
    
    UIImage * sec_30 = [UIImage imageNamed:@"30sec.png"];//画像の取得
    
    UIImage * sec_10 = [UIImage imageNamed:@"10sec.png"];//画像の取得
    
    
    
    for(int i=0;i<4;i++){
        
        btn[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        
        btn[i].frame =CGRectMake(40,50+(120*i),250,100);//位置と大きさ
        
        
        
        switch (i) {
                
            case 0:
                
                [btn[0] setBackgroundImage:sec_60 forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[0] addTarget:self action:@selector(btn0) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            case 1:
                
                [btn[1] setBackgroundImage:sec_40 forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[1] addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            case 2:
                
                [btn[2] setBackgroundImage:sec_30 forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[2] addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            default:
                
                [btn[3] setBackgroundImage:sec_10 forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[3] addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
        }
        
        [self.view addSubview:btn[i]];
        
    }
    
    
    
}



- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



/*
 
 #pragma mark - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 
 {
 
 // Get the new view controller using [segue destinationViewController].
 
 // Pass the selected object to the new view controller.
 
 }
 
 */



-(void)backBtn{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    
    [self presentViewController:vc0 animated:YES completion:nil];
    
    
    
}



-(void)btn0{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    
    delegate.timeSecond = @"59";
    
    
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
}



-(void)btn1{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    
    delegate.timeSecond = @"39";
    
    
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
    
    
}





-(void)btn2{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    
    delegate.timeSecond = @"29";
    
    
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
    
    
}





-(void)btn3{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];//呪文（コンストラクタみたいなもん？）
    
    delegate.timeSecond = @"9";
    
    
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
}



@end

