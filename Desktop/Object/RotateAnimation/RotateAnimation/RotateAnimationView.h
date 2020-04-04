//
//  RotateAnimationView.h
//  RotateAnimation
//
//  Created by 张奥 on 2020/4/4.
//  Copyright © 2020 张奥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotateAnimationView : UIView

/**
 init

 @param frame 视图坐标
 @param pathWidth 轨道的宽度
 @param markWidth 小图标的宽度
 @param animationTime 每次执行动画的时间
 @return
 */
-(instancetype)initWithFrame:(CGRect)frame pathWidth:(CGFloat)pathWidth markWidth:(CGFloat)markWidth animationTime:(CGFloat)animationTime;
//小图标的宽度
@property (nonatomic, assign) CGFloat markWidth;
//轨道的宽度
@property (nonatomic, assign) CGFloat pathWidth;
//每次执行动画的时间
@property (nonatomic, assign) CGFloat animationTime;
//开始动画
-(void)doAnimationProgeress:(CGFloat)progress;
@end

NS_ASSUME_NONNULL_END
