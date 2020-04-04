//
//  ViewController.m
//  RotateAnimation
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "ViewController.h"
#import "AvartView.h"
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, assign)CGFloat rota;
@property (nonatomic, assign)CGFloat progress;
@property (nonatomic, strong)AvartView *avartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    self.progress = 0.0;
    
    AvartView *avartView = [[AvartView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.avartView = avartView;
    avartView.center = self.view.center;
    [self.view addSubview:avartView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(100,SCREEN_Height - 100, 80, 80);
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor redColor];
    addButton.layer.cornerRadius = 8.f;
    addButton.layer.masksToBounds = YES;
    [addButton addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *reButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reButton.frame = CGRectMake(200,SCREEN_Height - 100, 80, 80);
    [reButton setTitle:@"-" forState:UIControlStateNormal];
    reButton.backgroundColor = [UIColor redColor];
    reButton.layer.cornerRadius = 8.f;
    reButton.layer.masksToBounds = YES;
    [reButton addTarget:self action:@selector(clickReButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reButton];
}


-(void)clickAddButton{
    self.progress += 0.1;
    if (self.progress >= 1.0) {
        self.progress = 1.0;
    }
    if (self.progress <= 0.0) {
        self.progress = 0.0;
    }
    [self.avartView progeressChange:self.progress];
}

-(void)clickReButton{
    self.progress -= 0.1;
    if (self.progress >= 1.0) {
        self.progress = 1.0;
    }
    if (self.progress <= 0.0) {
        self.progress = 0.0;
    }
    [self.avartView progeressChange:self.progress];
}

@end
