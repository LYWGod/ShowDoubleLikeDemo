//
//  DoubleLikeView.h
//  ShowDoubleLikeDemo
//
//  Created by git on 2021/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoubleLikeView : NSObject


/// 连击点赞，向上飘放大消失动画
/// @param touches 点击的位置
/// @param event 事件
- (void)createAnimationWithTouch:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

/// 连击点赞，向上飘放大消失动画
/// @param point 点击位置
/// @param superView 父容器
- (void)createAnimationWith:(CGPoint)point withSuperView:(UIView *)superView;


/// 连击点赞，原地放大消失动画
/// @param newPoint 新位置
/// @param oldPoint 老位置
/// @param superView 父容器
- (void)showDoubleClickLikeViewAnimPint:(CGPoint)newPoint withOldPoint:(CGPoint)oldPoint withSuperView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
