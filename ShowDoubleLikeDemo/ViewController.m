//
//  ViewController.m
//  ShowDoubleLikeDemo
//
//  Created by git on 2021/9/4.
//

#import "ViewController.h"
#import "DoubleLikeView.h"

@interface ViewController ()

@property (nonatomic, assign) NSTimeInterval           lastTapTime;

@property (nonatomic, assign) CGPoint                  lastTapPoint;
/** 容器 */
@property (nonatomic, strong) UIView                   *container;
/** 双击喜欢 */
@property (nonatomic, strong) DoubleLikeView          *doubleLikeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方案一
    [self setupDoubleClickShowLike];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //方案二
    [self.doubleLikeView createAnimationWithTouch:touches withEvent:event];
}




- (void)setupDoubleClickShowLike
{
    _lastTapTime = 0;
    _lastTapPoint = CGPointZero;
    
    self.container.frame = self.view.frame;
    
    [self.view addSubview:self.container];
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:singleTapGesture];
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    
        //获取点击坐标，用于设置爱心显示位置
        CGPoint point = [sender locationInView:_container];
        //获取当前时间
        NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
        //判断当前点击时间与上次点击时间的时间间隔
        if(time - _lastTapTime > 0.25f) {
            //推迟0.25秒执行单击方法  进行视频暂停方法
            [self performSelector:@selector(singleTapAction) withObject:nil afterDelay:0.25f];
        }else {
            //取消执行单击方法
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapAction) object: nil];
            //执行连击显示爱心的方法
            [self showLikeViewAnim:point oldPoint:_lastTapPoint];
        }
        //更新上一次点击位置
        _lastTapPoint = point;
        //更新上一次点击时间
        _lastTapTime =  time;
}

/// 单击屏幕暂停或播放
- (void)singleTapAction {
    
//    if (self.player.isPlaying) {
//        [self.player pausePlay];
//    }else{
//        [self.player resumePlay];
//    }
}
///连击点赞动画
- (void)showLikeViewAnim:(CGPoint)newPoint oldPoint:(CGPoint)oldPoint {
    [self.doubleLikeView createAnimationWith:newPoint withSuperView:_container];
}


- (DoubleLikeView *)doubleLikeView {
    if (!_doubleLikeView) {
        _doubleLikeView = [[DoubleLikeView alloc] init];
    }
    return _doubleLikeView;
}

- (UIView *)container
{
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}

@end
