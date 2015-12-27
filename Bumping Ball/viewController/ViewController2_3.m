//

//  ViewController2_3.m

//  Ball

//

//  Created by Tsuru on 2014/06/26.

//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.

//



#import "ViewController2_3.h"

#import <AudioToolbox/AudioToolbox.h>



SystemSoundID button_sound;//ボタンを押したときの効果音



@interface ViewController2_3()



@end



@implementation ViewController2_3



/*
 
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 
 {
 
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 
 if (self) {
 
 // Custom initialization
 
 }
 
 return self;
 
 }*/



- (void)viewDidLoad

{
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
    
    //button効果音ファイル読み込み
    
    NSString * path= [[NSBundle mainBundle] pathForResource:@"button" ofType:@"mp3"];
    
    NSURL * url = [NSURL fileURLWithPath:path];
    
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &button_sound);
    
    
    
    UIImage * back = [UIImage imageNamed:@"background1_2.png"];
    
    backGroundV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    backGroundV.image = back;
    
    [self.view addSubview:backGroundV];
    
    
    
    //--------------------------------------主な３つのボタン--------------------------------------//
    
    UIImage * rePlay = [UIImage imageNamed:@"rePlay.png"];//画像の取得
    
    UIImage * timeChange = [UIImage imageNamed:@"timeChange.png"];//画像の取得
    
    UIImage * exit = [UIImage imageNamed:@"exit1_2.png"];//画像の取得
    
    
    
    for(int i=0;i<3;i++){
        
        btn[i] =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
        
        btn[i].frame =CGRectMake(10,230+(100*i),300,100);//位置と大きさ
        
        
        
        switch (i) {
                
            case 0:
                
                [btn[0] setBackgroundImage:rePlay forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[0] addTarget:self action:@selector(btn0) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            case 1:
                
                [btn[1] setBackgroundImage:timeChange forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[1] addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
                
                break;
                
            default:
                
                [btn[2] setBackgroundImage:exit forState:UIControlStateNormal];  // 画像をセットする
                
                [btn[2] addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
                
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



-(void)btn0{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    UIViewController * vc2_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2_2"];
    
    [self presentViewController:vc2_2 animated:YES completion:nil];
    
    
    
}



-(void)btn1{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    UIViewController * vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc2"];
    
    [self presentViewController:vc2 animated:YES completion:nil];
    
    
    
}



-(void)btn2{
    
    
    
    AudioServicesPlaySystemSound(button_sound);
    
    
    
    UIViewController * vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc0"];
    
    [self presentViewController:vc0 animated:YES completion:nil];
    
}



@end

