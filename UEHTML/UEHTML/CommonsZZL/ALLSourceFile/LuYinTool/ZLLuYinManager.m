//
//  ZLLuYinManager.m
//  UEHTML
//
//  Created by apple on 2017/11/19.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLLuYinManager.h"

@implementation ZLLuYinManager

+ (ZLLuYinManager *)shareInstance{
    static ZLLuYinManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        /*
        // 0.1 创建录音文件存放路径
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.caf"];
        NSLog(@"%@", path);
        NSURL *url = [NSURL URLWithString:path];
        // 0.2 创建录音设置
        NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
        // 设置编码格式
        [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
        // 采样率
        [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];
        // 通道数
        [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
        //音频质量,采样质量
        [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
        // 1. 创建录音对象
        instance.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:nil];
        // 2. 准备录音(系统会分配一些录音资源)
        [instance.recorder prepareToRecord];
        */
    });
    return instance;
}
#pragma mark ===================录音机设置   开始==================
/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[NSURL URLWithString:self.cafPathStr];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}
/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    //LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    return recordSettings;
}

- (void)startRecordNotice{
    
     if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    
     //[self deleteOldRecordFile];  //如果不删掉，会在原文件基础上录制；虽然不会播放原来的声音，但是音频长度会是录制的最大长度。
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    
    if (![self.audioRecorder isRecording]) {//0--停止、暂停，1-录制中
        
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.countNum = 0;
        NSTimeInterval timeInterval =1 ; //0.1s
        self.timer1 = [NSTimer scheduledTimerWithTimeInterval:timeInterval  target:self selector:@selector(changeRecordTime)  userInfo:nil  repeats:YES];
        
        [self.timer1 fire];
    }
    //[self starAnimalWithTime:2.0];
}
- (void)stopRecordNotice
{
    NSLog(@"----------结束录音----------");
    
    [self.audioRecorder stop];
    [self.timer1 invalidate];
    
}

/** 删除录音 */
-(void)deleteOldRecordFileAtPath:(NSString *)pathStr{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:pathStr];
    if (!blHave) {
        NSLog(@"不存在");
        return ;
    }else {
        NSLog(@"存在");
        BOOL blDele= [fileManager removeItemAtPath:self.cafPathStr error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
    }
}
#pragma mark ===================录音机设置   结束==================
//- (void)beginRecord
//{
//    NSLog(@"开始录音");
//    [self.recorder record]; // 直接录音, 需要手动停止
//    //    [self.recorder recordForDuration:3]; // 从当前执行这行代码开始录音, 录音5秒
//    //    [recorder recordAtTime:recorder.deviceCurrentTime + 2]; // 2s, 需要手动停止
//    //    [self.recorder recordAtTime:self.recorder.deviceCurrentTime + 2 forDuration:3]; // 2s  3s
//}
//
//- (void)pauseRecord {
//    NSLog(@"暂停录音");
//    [self.recorder pause];
//}
//
//- (void)stopRecord {
//    NSLog(@"停止录音");
//    [self.recorder stop];
//}

@end
