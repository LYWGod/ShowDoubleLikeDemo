//
//  DoubleLikeView.m
//  ShowDoubleLikeDemo
//
//  Created by git on 2021/9/4.
//

#import "DoubleLikeView.h"

// 屏幕宽高
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
// 适配比例
#define ADAPTATIONRATIO     SCREEN_WIDTH / 750.0f

@implementation DoubleLikeView


- (void)createAnimationWithTouch:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    UITouch *touch = [touches anyObject];
    if (touch.tapCount <= 1.0f) return;
    
    CGPoint point = [touch locationInView:touch.view];
    
    [self setupAnimationWith:point withSuperView:touch.view];

}

- (void)createAnimationWith:(CGPoint)point withSuperView:(UIView *)superView {
    
    [self setupAnimationWith:point withSuperView:superView];
}

- (void)setupAnimationWith:(CGPoint)point withSuperView:(UIView *)superView
{
    UIImage *image = [UIImage imageNamed:@"icon_home_like_after"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ADAPTATIONRATIO * 160.0f, ADAPTATIONRATIO * 160.0f)];
    imgView.image = image;
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.center = point;
    
    // 随机左右显示
    int leftOrRight = arc4random() % 2;
    leftOrRight = leftOrRight ? leftOrRight : -1;
    imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI / 9.0f * leftOrRight);
    [superView addSubview:imgView];
    
    // 出现的时候回弹一下
    __block UIImageView *blockImgV = imgView;
    __block UIImage *blockImage = image;
    
    [UIView animateWithDuration:0.1 animations:^{
        blockImgV.transform = CGAffineTransformScale(blockImgV.transform, 1.2f, 1.2f);
    } completion:^(BOOL finished) {
        blockImgV.transform = CGAffineTransformScale(blockImgV.transform, 0.8f, 0.8f);
        
        // 向上飘，放大，透明
        [self performSelector:@selector(animationToTop:) withObject:@[blockImgV, blockImage] afterDelay:0.3f];
    }];
}

- (void)animationToTop:(NSArray *)imgObjects {
    if (imgObjects && imgObjects.count > 0) {
        __block UIImageView *imgView = (UIImageView *)imgObjects.firstObject;
        __block UIImage *image = (UIImage *)imgObjects.lastObject;
        [UIView animateWithDuration:1.0f animations:^{
            CGRect imgViewFrame = imgView.frame;
            imgViewFrame.origin.y -= 100.0f;
            imgView.frame = imgViewFrame;
            imgView.transform = CGAffineTransformScale(imgView.transform, 1.8f, 1.8f);
            imgView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [imgView removeFromSuperview];
            imgView = nil;
            image = nil;
        }];
    }
}


- (void)showDoubleClickLikeViewAnimPint:(CGPoint)newPoint withOldPoint:(CGPoint)oldPoint withSuperView:(UIView *)superView {
    {
        UIImageView *likeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_home_like_after"]];
        CGFloat k = ((oldPoint.y - newPoint.y)/(oldPoint.x - newPoint.x));
        k = fabs(k) < 0.5 ? k : (k > 0 ? 0.5f : -0.5f);
        CGFloat angle = M_PI_4 * -k;
        likeImageView.frame = CGRectMake(newPoint.x, newPoint.y, 80, 80);
        likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 0.8f, 1.8f);
        [superView addSubview:likeImageView];
        [UIView animateWithDuration:0.2f
                              delay:0.0f
             usingSpringWithDamping:0.5f
              initialSpringVelocity:1.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 1.0f, 1.0f);
        }
                         completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f
                                  delay:0.5f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                likeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(angle), 3.0f, 3.0f);
                likeImageView.alpha = 0.0f;
            }
                             completion:^(BOOL finished) {
                [likeImageView removeFromSuperview];
            }];
        }];
    }
}

@end
