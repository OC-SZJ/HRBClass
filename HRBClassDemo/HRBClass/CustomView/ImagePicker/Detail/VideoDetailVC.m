//
//  VideoDetailVC.m
//  Test
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "VideoDetailVC.h"
#import <AVFoundation/AVFoundation.h>
@interface VideoDetailVC ()
@property (weak, nonatomic) IBOutlet UIView *nav_v;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nav_h;

@property (weak, nonatomic) IBOutlet UIView *tab_v;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tab_h;

@property (weak, nonatomic) IBOutlet UIImageView *play_img;

@property (nonatomic,strong) AVPlayer *avplayer;
@end

@implementation VideoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.nav_h.constant = X_NAV(64);
    self.tab_h.constant = X_TABBAR(49);
    
    // Do any additional setup after loading the view from its nib.
    
      //读取本地视频路径

           //为即将播放的视频内容进行建模
           AVPlayerItem *avplayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.model.videoUrl]];
           //创建监听（这是一种KOV的监听模式）
           [avplayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
           //给播放器赋值要播放的对象模型
           _avplayer = [AVPlayer playerWithPlayerItem:avplayerItem];
           //指定显示的Layer
           AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_avplayer];
            layer.frame = YYScreenBounds();
    
    [self.view.layer insertSublayer:layer atIndex:0];
    __weak typeof(self) WeakSelf = self;
       [_avplayer addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC)
                                                  queue:NULL
                                             usingBlock:^(CMTime time) {
                                                 //进度 当前时间/总时间
                                                 CGFloat progress = CMTimeGetSeconds(WeakSelf.avplayer.currentItem.currentTime) / CMTimeGetSeconds(WeakSelf.avplayer.currentItem.duration);
    //在这里截取播放进度并处理
                                                 if (progress == 1.0f) {
                                                   //播放百分比为1表示已经播放完毕
                                                  WeakSelf.nav_v.hidden = WeakSelf.tab_v.hidden = WeakSelf.play_img.hidden = NO;
                                                     [avplayerItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
                                                         
                                                     }];
                                                 }
                                             }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (_avplayer.rate == 0.f) {
         [_avplayer play];
        self.nav_v.hidden = self.tab_v.hidden = self.play_img.hidden = YES;
    }else{
       self.nav_v.hidden = self.tab_v.hidden = self.play_img.hidden = NO;
        [_avplayer pause];
    }
   
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    AVPlayerItem *item = object;
    //判断监听对象的状态
    if ([keyPath isEqualToString:@"status"]) {
    
        if (item.status == AVPlayerItemStatusReadyToPlay) {//准备好的
            [_avplayer play];
            [_avplayer pause];
        } else if(item.status ==AVPlayerItemStatusUnknown){//未知的状态
           NSLog(@"AVPlayerItemStatusUnknown");
        }else if(item.status ==AVPlayerItemStatusFailed){//有错误的
            NSLog(@"AVPlayerItemStatusFailed");
        }
        
    }
    
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)selectThis:(id)sender {
    if (self.isThis) {
        self.isThis();
        
    }
}

@end
