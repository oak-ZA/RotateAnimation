//
//  ZAWaveView.m
//  ProtocolTest
//
//  Created by 张奥 on 2020/4/3.
//  Copyright © 2020 张奥. All rights reserved.
//

#import "ZAWaveView.h"
@interface ZAWaveView()
@property (nonatomic,strong)NSTimer *time;
@end
@implementation ZAWaveView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.animationTime = 2;
        self.scale = 1.3;
        self.bordWidth = 1.5;
        self.startAlph = 0.8;
        self.color = [UIColor whiteColor];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//动画时间
-(void)setAnimationTime:(CGFloat)animationTime{
    _animationTime = animationTime;
}
//动画发散的大小
-(void)setScale:(CGFloat)scale{
    _scale = scale;
}
//光圈的宽度
-(void)setBordWidth:(CGFloat)bordWidth{
    _bordWidth = bordWidth;
}
//初始透明度
-(void)setStartAlph:(float)startAlph{
    _startAlph = startAlph;
}
//光圈颜色
-(void)setColor:(UIColor *)color{
    _color = color;
}

//开始水波纹动画
-(void)startWaveAnimationCircleNumber:(NSInteger)number{
    __block NSInteger index = 0;
    if (self.time) {
        [self invalidTimer];
    }
    if (number == 0) {
        number = 1;
    }
    //每一个圈需要的时间
    CGFloat time = self.animationTime / number;
    __weak typeof(self) weaKSelf = self;
    self.time = [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weaKSelf) strongSelf = weaKSelf;
        index ++;
        if (index > number) {
            [strongSelf invalidTimer];
            return ;
        }
        [strongSelf start];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
    [self.time setFireDate:[NSDate date]];
}

//停止水波纹
-(void)stopwWaveAnimation{
    [self.layer removeAllAnimations];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self invalidTimer];
}
-(void)invalidTimer{
    [self.time invalidate];
    self.time = nil;
}
-(void)start{
    //中心
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    layer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
    layer.opacity = 0.0;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //画圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    layer.path = path.CGPath;
    layer.strokeColor = [self.color colorWithAlphaComponent:self.startAlph].CGColor;
    layer.lineWidth = self.bordWidth;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:layer];
    
    //动画
    //透明度改变
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:self.startAlph];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    //圈的大小改变(发散效果)
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @1;
    scaleAnimation.toValue = @(self.scale);
    
    //圈的宽度变化
    CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    borderAnimation.fromValue = @(self.bordWidth);
    borderAnimation.toValue = @(1);
    borderAnimation.duration = 0.2;
    
    //动画组
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[opacityAnimation,scaleAnimation,borderAnimation];
    animationGroup.duration = self.animationTime;
    animationGroup.removedOnCompletion = YES;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.repeatCount = MAXFLOAT;
    [layer addAnimation:animationGroup forKey:@""];
    
}

@end
