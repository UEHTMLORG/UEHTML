//
//  ZLLuYinManager.h
//  UEHTML
//
//  Created by apple on 2017/11/19.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ZLLuYinManager : NSObject<AVAudioRecorderDelegate>

/** 录音对象*/
@property(nonatomic ,strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, copy) NSString *cafPathStr;
@property (nonatomic, strong) NSTimer *timer1;
@property (nonatomic, assign) int countNum;

+ (ZLLuYinManager *)shareInstance;

/** 开始录音 */
- (void)startRecord;
/** 暂停录音 */
- (void)pauseRecord;
/** 结束录音 */
- (void)stopRecord;

@end
