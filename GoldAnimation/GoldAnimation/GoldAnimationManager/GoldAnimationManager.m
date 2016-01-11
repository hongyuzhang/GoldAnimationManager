//
//  GoldAnimationManager.m
//  GoldAnimation
//
//  Created by Justin on 16/1/11.
//  Copyright © 2016年 MySelf. All rights reserved.
//

#import "GoldAnimationManager.h"
#define GOLDCOUNT       12
#define ANGLE           (2 * M_PI)
#define GOLDDURATION    1.0
@interface GoldAnimationManager ()

    // 存储金币的缓存
@property (strong, nonatomic) NSMutableArray<CALayer *> *goldLayers;

@end

@implementation GoldAnimationManager


+(instancetype)sharedManager{
    static id _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GoldAnimationManager alloc] init];
    });

    return _instance;
}


    // 执行获取金币动画入口
-(void)performGoldAnimationFromView:(UIView *)fromView ToView:(UIView *)toView BackView:(UIView *)backView{

    for (int i = 0; i < GOLDCOUNT; i++) {
        NSArray *animationViews = @[fromView,toView,backView];
        [self performSelector:@selector(initGoldWithCount:) withObject:animationViews afterDelay:0.01 * GOLDCOUNT];
    }
}


    // 初始化金币
-(void)initGoldWithCount:(NSArray *)animationViews{

    UIView *fromView            =   animationViews.firstObject;
    UIView *toView              =   animationViews[1];
    UIView *backView            =   animationViews.lastObject;

    CGPoint startPoint          =   fromView.center;
    CGPoint endPoint            =   toView.center;

    CALayer *goldLayer          =   [CALayer layer];
    goldLayer.frame             =   CGRectMake(startPoint.x, startPoint.y, 18, 18);
    goldLayer.cornerRadius      =   CGRectGetWidth(goldLayer.frame)/2.f;

#pragma mark 更换图片
    goldLayer.backgroundColor   =   [UIColor colorWithPatternImage:[UIImage imageNamed:@"it_square_coin_big"]].CGColor;


    [backView.layer addSublayer:goldLayer];
    [self.goldLayers addObject:goldLayer];
    [self performGoldAnimationWithLayer:goldLayer fromPoint:startPoint toPoint:endPoint];
}


    // 执行动画
-(void)performGoldAnimationWithLayer:(CALayer *)layer fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint{

    CGMutablePathRef path               =   CGPathCreateMutable();
    CGPoint controlPoint                =  [self getRandomControlPointWithStartPoint:startPoint endPoint:endPoint];
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddQuadCurveToPoint(path, NULL, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);

    CAKeyframeAnimation *keyAnimation   =   [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path                   =   path;

    CABasicAnimation* rotationAnimation =   [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.toValue           =   [NSNumber numberWithFloat:ANGLE];

    CAKeyframeAnimation *scaleAnimation =   [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CGFloat from3DScale                 =   1 + arc4random() % 10 *0.1;
    CGFloat to3DScale                   =   from3DScale * 0.3;
    scaleAnimation.values               =   @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(from3DScale, from3DScale, from3DScale)],
                                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(to3DScale, to3DScale, to3DScale)]];
    scaleAnimation.timingFunctions      =   @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration               =   GOLDDURATION;
    group.fillMode               =   kCAFillModeForwards;
    group.removedOnCompletion    =   NO;
    group.delegate               =   self;
    group.animations = @[keyAnimation,
                         scaleAnimation,
                         rotationAnimation];
    [layer addAnimation:group forKey:nil];

}


    // 获取随机的控制点
-(CGPoint)getRandomControlPointWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{

    CGPoint controlPoint    =   CGPointZero;
    double resultH = fabs(endPoint.y - startPoint.y);
    double resultW = fabs(endPoint.x - startPoint.x);

    CGFloat tempH;
    CGFloat tempW;

    if (resultH < 100) {
        tempH  = 30 + arc4random() % 10;
    }else{
        tempH  = arc4random() % (int)resultH * 0.4;
    }

    if (resultW < 100) {
        tempW = 30 + arc4random() % 10;
    }else{
        tempW = arc4random() % (int)resultW * 0.4;
    }

    controlPoint.x          =   startPoint.x + (arc4random() % 2 ? tempW : -tempW);
    controlPoint.y          =   startPoint.y + (arc4random() % 2 ? tempH : -tempH);
    return controlPoint;
}


    // 动画结束后移除金币，释放缓存
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    [self.goldLayers[0] removeFromSuperlayer];
    [self.goldLayers removeObjectAtIndex:0];

}


-(NSMutableArray<CALayer *> *)goldLayers{
    if (!_goldLayers) {
        _goldLayers = [NSMutableArray array];
    }
    return _goldLayers;
}

@end
