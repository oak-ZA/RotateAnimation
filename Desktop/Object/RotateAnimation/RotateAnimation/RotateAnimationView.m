//
//  RotateAnimationView.m
//  RotateAnimation
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "RotateAnimationView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]
@interface RotateAnimationView()

@property (nonatomic, strong)UIView *circleView;
@property (nonatomic, assign)CGFloat originalRota;
@property (nonatomic, assign)CGFloat currentRota;
@property (nonatomic,strong)CAShapeLayer *backLayer;
@property (nonatomic,strong)CAShapeLayer *progressLayer;

@property (nonatomic,assign)CGFloat originalProgress;

@end

@implementation RotateAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame pathWidth:(CGFloat)pathWidth markWidth:(CGFloat)markWidth animationTime:(CGFloat)animationTime{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.pathWidth = pathWidth;
        self.markWidth = markWidth;
        self.animationTime = animationTime;
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.originalRota = 2*M_PI;
    float centerX = self.bounds.size.width/2.0;
    float centerY = self.bounds.size.height/2.0;
    //半径
    float radius = (self.bounds.size.width-self.pathWidth)/2.0;
    //贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(1.5f*M_PI) endAngle:-0.5f*M_PI clockwise:NO];
    //背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    self.backLayer = backLayer;
    backLayer.frame = self.bounds;
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor = [UIColor whiteColor].CGColor;
    backLayer.lineWidth = self.pathWidth;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1.0;
    [self.layer addSublayer:backLayer];
    
    //进度layer
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    self.progressLayer = progressLayer;
    progressLayer.frame = self.bounds;
    progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    progressLayer.lineWidth = self.pathWidth;
    progressLayer.path = [path CGPath];
    progressLayer.lineCap = kCALineCapRound;
    progressLayer.strokeEnd = 0.0;
    [self.layer addSublayer:progressLayer];
    
    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:@[(id)[UIColorFromRGB(0XFD5B98) CGColor],(id)[UIColorFromRGB(0XF678F8) CGColor]]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:progressLayer]; //用progressLayer来截取渐变层
    [self.layer addSublayer:gradientLayer];
    
    //用于旋转图片
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.circleView = circleView;
    circleView.center = self.center;
    [self addSubview:circleView];

    UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake((circleView.frame.size.width - self.markWidth)/2.f , -(self.markWidth - self.pathWidth)/2, self.markWidth, self.markWidth)];
    smallImageView.image = [UIImage imageNamed:@"hot_min"];
    [circleView addSubview:smallImageView];
    
}

-(void)doAnimationProgeress:(CGFloat)progress{
    if (progress == self.originalProgress)return;
    //绘制渐变色
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = @(self.originalProgress);
    animation.toValue = @(progress);
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    //图片动画
    CGFloat value = value = (1 - progress)*(2*M_PI);
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.fromValue = [NSNumber numberWithFloat:self.originalRota];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:value];
    monkeyAnimation.duration = 1.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = YES;
    monkeyAnimation.removedOnCompletion = NO;
    monkeyAnimation.fillMode = kCAFillModeForwards;
    monkeyAnimation.repeatCount = 1;
    [self.circleView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    self.originalRota = value;
    self.originalProgress = progress;
}

@end
