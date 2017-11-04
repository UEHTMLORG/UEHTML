//
//  ATQDTContentView.h
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQDTModel;
@class ATQContentModel;
@protocol ATQDTContentViewDelegate <NSObject>

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end
@interface ATQDTContentView : UIView
-(id)init;
- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) id <ATQDTContentViewDelegate>delegate;
@end
