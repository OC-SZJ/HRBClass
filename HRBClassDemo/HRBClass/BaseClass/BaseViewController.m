

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "IQKeyboardManager.h"
#import "Tool.h"

@interface BaseViewController ()

@property (nonatomic, strong, readonly) NSArray * textViewArray;

@property (nonatomic, strong) UIView * keyBoard_v;

@property (nonatomic, assign) CGRect  tabbarRec;

@end

@implementation BaseViewController
{
    void(^_rightEvent)(id me,UITabBarItem *item);
}

BOOL StrEQ(NSString *key,NSString *keys){
    return [keys isEqualToString:key];
}


NSString *GetClassStr(NSArray <NSArray <NSString *> *> * arr , NSIndexPath *indexPath){
    NSArray *arrA = nil;
    if (indexPath.section >= arr.count) {
        arrA = arr.lastObject;
        
    }else{
        arrA = arr[indexPath.section];
    }
    
    
    if (indexPath.row >= arrA.count)
        return arrA[0];
    return arrA[indexPath.row];
}

NSArray <NSString *> * CellArr(NSArray <NSArray <NSString *> *> * arr){
    NSMutableArray *cellArr = [NSMutableArray array];
    [arr enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![cellArr containsObject:obj]) {
                [cellArr addObject:obj];
            }
        }];
    }];
    return cellArr;
}


-(void)viewDidDisappear:(BOOL)animated{
    
    [self.view endEditing:YES];
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hidNav animated:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:LC_CURRENTVC object:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)dealloc{
    
}

+ (instancetype)hidNavNew{
    BaseViewController *vc = self.new;
    vc.hidNav = YES;
    return vc;
}

+ (BaseNavigationController *)shareForPresent{
    BaseNavigationController *nav = [BaseNavigationController shareWithRootVC:[self new]];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backUpRootView)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.view frameSelf];
    [self handle:self];
    [self getData];
    [self getOhter];
    
}

- (void)handle:(__kindof BaseViewController *)oj{}
- (void)getData{
    LC_WEAK_SELF
    BOOL n = NO;
    BaseParams *p = BaseParams.new;
    if (self.autoPost){
        n = YES;
        self.autoPost(p,self);
    }
    if (self.autoUIDPost) {
        n = YES;
        p.params[@"id"] = UID();
        self.autoUIDPost(p, self);
    }
    if (!n) return;
    if (!p.api) p.api = [p.modelClass api];
    [LCNetWorkTool post:p.api parameters:p.params reqSuccess:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
        [dic success:^{
            BaseModel *model =  [p.modelClass modelWithDictionary:dic];
            if (p.result) p.result(model,weakSelf);
        }faild:^{
            if (DEBUG) {
                printf("\n类: <%p %s:(%d) >\n方法: %s \n%s\n", weakSelf, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic,params,urlStr] UTF8String]);
            }
        }];
    } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
        
    }];
}

- (void)getOhter{
    LC_WEAK_SELF
    self.otherPost = ^(__unsafe_unretained Class modelClass, NSString *api, NSDictionary *params, void (^result)(id data, id oj)) {
        if (api == nil) api = [modelClass api];
        
        [LCNetWorkTool post:api parameters:params reqSuccess:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
            [dic success:^{
                BaseModel *model =  [modelClass modelWithDictionary:dic];
                if (result) result(model,weakSelf);
            }faild:^{
                if (DEBUG) {
                    printf("\n类: <%p %s:(%d) >\n方法: %s \n%s\n", weakSelf, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic,params,urlStr] UTF8String]);
                }
            }];
        } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
            
        }];
    };
    self.uidPost = ^(__unsafe_unretained Class modelClass, void (^result)(id data, id oj)) {
        weakSelf.otherPost(modelClass, [modelClass api], @{@"uid":UID()}, result);
    };
    self.nilApiPost = ^(__unsafe_unretained Class modelClass, NSDictionary *params, void (^result)(id data, id oj)) {
        weakSelf.otherPost(modelClass, [modelClass api], params, result);
    };
    self.resultPost = ^(NSString *api,NSDictionary *params, void (^result)(BOOL success, id oj)) {
        [LCNetWorkTool post:api parameters:params reqSuccess:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
            if (result) {
                [dic success:^{
                    result(YES,weakSelf);
                }faild:^{
                    result(NO,weakSelf);
                }];
            }
        } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
            
        }];
    };
}
- (void)getCurrentTimeNotication:(NSNotification *)notication{};

-(void)repeatGetData{
    [self getData];
}

- (IBAction)backUpRootView
{
    [self popWithData:nil];
}

- (void)popToIndex:(NSInteger)index{
    [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:YES];
}

-(void)doLoadFinish{
    if (_loadFinish) {
        _loadFinish(self);
    }
}

-(void)doLoadFinishWithRelease{
    if (_loadFinish) {
        _loadFinish(self);
        _loadFinish = nil;
    }
}

- (void)popWithData:(id )data{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.refreshPopVC) {
        self.refreshPopVC(data);
    }
}

- (void)addRightBarItemWithData:(id)data withEvent:(void(^)(id thisObject,UITabBarItem *item))event{
    if ([data isKindOfClass:[UIImage class]]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[data imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:data style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    }
    
    _rightEvent = event;
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}
- (void)rightAction:(UITabBarItem *)item{
    _rightEvent(self,item);
}

- (void)addLeftBarItemWithData:(id)data withSEL:(SEL)sel{
    if ([data isKindOfClass:[UIImage class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[data imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:sel];
    }else{
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:data style:UIBarButtonItemStylePlain target:self action:sel];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
}

- (void)pushVC:(BaseViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:vc.hidNav animated:NO];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setButtonState:(UIButton *)button{
    [self.view layoutIfNeeded];
    button.backgroundColor = UIColorHex(@"D70D02");
    button.layer.cornerRadius = button.height / 2;
    button.layer.shadowColor = UIColorHex(@"D70D02").CGColor;
    button.layer.shadowOpacity = 0.5;
    button.layer.shadowRadius = 5.f;
    button.layer.shadowOffset = CGSizeMake(0,3);
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
