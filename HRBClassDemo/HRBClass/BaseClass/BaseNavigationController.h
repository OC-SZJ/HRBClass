

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL noSwip;


+ (instancetype)shareWithRootVC:(UIViewController *)rootVC;

@end
