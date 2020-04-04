//
//  AvartView.m
//  RotateAnimation
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "AvartView.h"
#import "ZAWaveView.h"
#import "RotateAnimationView.h"
@interface AvartView()
@property (nonatomic, strong)RotateAnimationView *animationView;
@property (nonatomic, strong)ZAWaveView *waveView;
@end
@implementation AvartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAvartView];
    }
    return self;
}

-(void)createAvartView{
    
    //水波纹
    ZAWaveView *waveView = [[ZAWaveView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.waveView = waveView;
    waveView.color = [UIColor whiteColor];
    waveView.center = self.center;
    [self addSubview:waveView];
    [waveView startWaveAnimationCircleNumber:3];
    
    UIImageView *avartImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.width)];
    avartImageView.center = self.center;
    avartImageView.image = [UIImage imageNamed:@"dog.png"];
    avartImageView.layer.masksToBounds = YES;
    avartImageView.layer.cornerRadius = self.bounds.size.width/2.f;
    [self addSubview:avartImageView];
    
    //旋转
    RotateAnimationView *rotateAnimationView = [[RotateAnimationView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width) pathWidth:5.f markWidth:16.f animationTime:1.f];
    self.animationView = rotateAnimationView;
    rotateAnimationView.center = self.center;
    [self addSubview:rotateAnimationView];
}

-(void)progeressChange:(CGFloat)progress{
    [self.animationView doAnimationProgeress:progress];
}

@end
