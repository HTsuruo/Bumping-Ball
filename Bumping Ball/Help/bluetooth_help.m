//
//  bluetooth_help.m
//  Bumping Ball
//
//  Created by Tsuru on 2014/10/03.
//  Copyright (c) 2014年 Hideki Tsuruoka. All rights reserved.
//

#import "bluetooth_help.h"
#import "LAWalkthroughViewController.h"

@interface bluetooth_help ()

@end

@implementation bluetooth_help

float WIDTH;
float HEIGHT;

int touchCount;

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
    
    
    WIDTH = [[UIScreen mainScreen]applicationFrame].size.width;//画面の幅を取得
    HEIGHT = [[UIScreen mainScreen]applicationFrame].size.height;//画面の幅を取得s
    
    sound = [[Sound alloc]init];
    
    //全体の背景画像を貼ります
    UIImage * background = [UIImage imageNamed:@"background_bluetooth_help.png"];
    backgroundV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backgroundV.image = background;
    [self.view addSubview:backgroundV];
    
   /*ウォークスルー*/
    // Create the walkthrough view controller
    LAWalkthroughViewController *walkthrough = LAWalkthroughViewController.new;
    walkthrough.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    walkthrough.backgroundImage = [UIImage imageNamed:@"background_bluetooth_help2"];
    
    if([NSLocalizedString(@"localizationKey", nil) isEqualToString:@"日本語"]){//日本語の場合
    // Create pages of the walkthrough
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help1.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help3.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help4.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help5.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help2.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help6.png"]];
        
    }else{
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help1_eng.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help3_eng.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help4_eng.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help5_eng.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help2_eng.png"]];
        [walkthrough addPageWithBody_image:[UIImage imageNamed:@"bluetooth_help6.png"]];
        
    }
    
    // Use the default next button
    walkthrough.nextButtonText = @"next";
    
    // Add the walkthrough view to your view controller's view
    [self addChildViewController:walkthrough];
    [self.view addSubview:walkthrough.view];
    
    UIImage * backImage = [UIImage imageNamed:@"backImage.png"];//画像の取得
    backBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];//ボタン作成
    backBtn.frame =CGRectMake(10,15,HEIGHT*0.08,HEIGHT*0.08);//位置と大きさ
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];  // 画像をセットする
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
}

-(void)backBtn{
  
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
