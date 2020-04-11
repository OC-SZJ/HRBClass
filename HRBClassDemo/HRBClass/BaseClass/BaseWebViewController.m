

#import "BaseWebViewController.h"
#import "AppDelegate.h"


@interface BaseWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navTitle;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, YYScreenWidth(), YYScreenHeight() - X_NAV(64))];
    self.webView.delegate = self;

    self.webView.backgroundColor = LC_COLOR(@"touMing");
    self.webView.opaque = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:self.webView];

}

-(void)backUpRootView{
    if (self.navigationController.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:NO completion:^{
        }];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
