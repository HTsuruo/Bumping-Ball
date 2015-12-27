//
//  help_detail.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/09/07.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "help_detail.h"
#import "AppDelegate.h"

AppDelegate * delegate;

@interface help_detail ()

@end

@implementation help_detail


float WIDTH;
float HEIGHT;

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
    // Do any additional setup after loading the view from its nib.
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得
    
    sound = [[Sound alloc]init];
    
    backgroundV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    UIImage * background;
    
    delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // 各言語の結果に対して処理を記述
     if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
         if([delegate.help_mode isEqualToString:@"help_easy"]){
             background = [UIImage imageNamed:@"help_easy.png"];
         }else if([delegate.help_mode isEqualToString:@"help_normal"]){
             background = [UIImage imageNamed:@"help_normal.png"];
         }else{
             background = [UIImage imageNamed:@"help_hard.png"];
         }
     } else {//他言語の場合
         if([delegate.help_mode isEqualToString:@"help_easy"]){
             background = [UIImage imageNamed:@"help_easy_eng.png"];
         }else if([delegate.help_mode isEqualToString:@"help_normal"]){
             background = [UIImage imageNamed:@"help_normal_eng.png"];
         }else{
             background = [UIImage imageNamed:@"help_hard_eng.png"];
         }
     }


    backgroundV.image = background;
    [self.view addSubview:backgroundV];
    
    UIImage * backImage = [UIImage imageNamed:@"backImage.png"];//画像の取得
    backBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    backBtn.frame =CGRectMake(10,15,HEIGHT*0.08,HEIGHT*0.08);//位置と大きさ
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];  // 画像をセットする
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    

}


-(void)backBtn{
    // AudioServicesPlaySystemSound(button_sound);
    [sound button_sound];
    

    UIViewController * vc3_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"vc3_1"];
    vc3_1.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc3_1 animated:YES completion:nil];
      
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
