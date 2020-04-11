

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) id popDelegate;
@end
@implementation BaseNavigationController

+ (instancetype)shareWithRootVC:(UIViewController *)rootVC{
    BaseNavigationController *n = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
    return n;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak BaseNavigationController *weakSelf = self;
 
    
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        {
            
            self.interactivePopGestureRecognizer.delegate = weakSelf;
            
            
            self.delegate = weakSelf;
        }
    
     
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
   
       [super pushViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = !_noSwip;
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:YES];
}

#pragma mark UINavigationControllerDelegate



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.childViewControllers count] == 1) {
        return NO;
    }
    return YES;
}

// 我们差不多能猜到是因为手势冲突导致的，那我们就先让 ViewController 同时接受多个手势吧。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
//运行试一试，两个问题同时解决，不过又发现了新问题，手指在滑动的时候，被 pop 的 ViewController 中的 UIScrollView 会跟着一起滚动，这个效果看起来就很怪（知乎日报现在就是这样的效果），而且也不是原始的滑动返回应有的效果，那么就让我们继续用代码来解决吧
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}
@end
