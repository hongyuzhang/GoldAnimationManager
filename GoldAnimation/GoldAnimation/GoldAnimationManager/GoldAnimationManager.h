//
//  GoldAnimationManager.h
//  GoldAnimation
//
//  Created by Justin on 16/1/11.
//  Copyright © 2016年 MySelf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GoldAnimationManager : NSObject

    // 金币动画单例管理者
+(instancetype)sharedManager;

    // 执行获取金币动画入口
-(void)performGoldAnimationFromView:(UIView *)fromView ToView:(UIView *)toView BackView:(UIView *)backView;

@end
