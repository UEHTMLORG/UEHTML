//
//  ATQRenzhengViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol FaceDetectorDelegate <NSObject>

-(void)sendFaceImage:(UIImage *)faceImage; //上传图片成功
-(void)sendFaceImageError; //上传图片失败

@end
@interface ATQRenzhengViewController : ATQBaseViewController
@property (assign,nonatomic) id<FaceDetectorDelegate> faceDelegate;
@end
