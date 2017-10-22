//
//  ATQFaceRZViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol FaceRZIsSuccessDelegate <NSObject>
-(void)passValue:(NSString*)SusStr;
@end
@interface ATQFaceRZViewController : ATQBaseViewController
@property(nonatomic, copy)NSString *vcStr;
@property (nonatomic,weak)id<FaceRZIsSuccessDelegate>delegate;
@end
