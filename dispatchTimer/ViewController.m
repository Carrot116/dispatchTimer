//
//  ViewController.m
//  dispatchTimer
//
//  Created by carrot on 16/3/4.
//  Copyright © 2016年 carrot. All rights reserved.
//

#import "ViewController.h"

#import "MHDataModel.h"

@interface ViewController ()
@property (strong, nonatomic) dispatch_queue_t queue;
@property (strong, nonatomic) dispatch_queue_t checkQueue;
@property (strong, nonatomic) dispatch_source_t timer;
@property (copy, nonatomic) dispatch_block_t timerBlock;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (assign, nonatomic) int count;
- (IBAction)onClickStart:(id)sender;
- (IBAction)onClickPause:(id)sender;

@property (strong, nonatomic) MHDataModel* data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (MHDataModel*)data{
    if (_data == nil) {
        _data = [MHDataModel dataModel];
    }
    return _data;
}

- (dispatch_queue_t)queue{
    if (_queue == nil) {
        _queue = dispatch_queue_create("com.carrot.vip.dispatchTimer", DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}

- (dispatch_queue_t)checkQueue{
    if (_checkQueue == nil) {
        _checkQueue = dispatch_queue_create("com.carrot.vip.dispatchCheckTimer", DISPATCH_QUEUE_SERIAL);
    }
    return _checkQueue;
}

- (dispatch_source_t)timer{
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.checkQueue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),10.0*NSEC_PER_SEC, 10.0 *NSEC_PER_SEC); //每秒执行
        __weak ViewController* weakSelf = self;
        dispatch_source_set_event_handler(_timer, ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            dispatch_async(strongSelf.queue, ^{
                dispatch_source_cancel(strongSelf.timer);

                strongSelf.timerLabel.text = [NSString stringWithFormat:@"计时器:%d", [strongSelf.data dataCount]];
                [strongSelf.data clearData];
                static int count = 0;
                NSLog(@"shujugeshu --- %d %d",[strongSelf.data dataCount], ++count);

                dispatch_resume(strongSelf.timer);
            });
        });
    }
    return _timer;
}

- (dispatch_block_t)timerBlock{
//    __weak ViewController *weakSelf = self;
//    if (_timerBlock == nil) {
//        _timerBlock = ^{
//            __strong __typeof(weakSelf)strongSelf = weakSelf;
//            strongSelf.timerLabel.text = [NSString stringWithFormat:@"计时器:%d", [strongSelf.data dataCount]];
//            [strongSelf.data clearData];
//            static int count = 0;
//            NSLog(@"shujugeshu --- %d %d",[strongSelf.data dataCount], ++count);
//
//            dispatch_resume(strongSelf.timer);
//        };
//    }
    if (_timerBlock == nil) {
        _timerBlock = ^{
            self.timerLabel.text = [NSString stringWithFormat:@"计时器:%d", [self.data dataCount]];
            [self.data clearData];
            static int count = 0;
            NSLog(@"shujugeshu --- %d %d",[self.data dataCount], ++count);

            dispatch_resume(self.timer);
        };
    }
    return _timerBlock;
}

- (IBAction)onClickStart:(id)sender {
    dispatch_resume(self.timer);
}

- (IBAction)onClickPause:(id)sender {
//    dispatch_source_cancel(self.timer);
//    self.count = 0;
//    self.timerLabel.text = @"清除计数器";
    static int count = 0;
    NSString* strData = [NSString stringWithFormat:@"count = %d",count ++];
    [self.data addData:strData];
}

//- (void)start{
//    __weak ViewController* weakSelf = self;
//    dispatch_source_set_event_handler(self.timer, ^{
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        strongSelf.timerBlock();
//    });
//}

- (void)pause{

}

//- (void)startTime{
//    __block int timeout=30; //倒计时时间
//
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout == 0){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                [self.timerButton setTitle:@"发送验证码" forState:UIControlStateNormal];
//                self.timerButton.userInteractionEnabled = YES;
//            });
//        }else{
//            //            int minutes = timeout / 60;
//            int seconds = timeout % 60;
//            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
//                [self.timerButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                self.timerButton.userInteractionEnabled = NO;
//
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
