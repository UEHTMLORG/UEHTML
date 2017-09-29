//
//  ATQEditPhotoViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/29.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol  IsSecretDelegate <NSObject>
-(void)passValue:(BOOL)isSecret ;
@end
@interface ATQEditPhotoViewController : ATQBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *secretBtn;
@property (strong,nonatomic) UIImage *image;
@property(weak,nonatomic) id <IsSecretDelegate> isSecretdelegate;
@end
