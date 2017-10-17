//
//  ATQCommentView.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQPYQModel;
@class ATQCommentModel;
@protocol ATQCommentViewDelegate <NSObject>

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end
@interface ATQCommentView : UIView
-(id)init;
- (void)configCellWithModel:(ATQPYQModel *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) id <ATQCommentViewDelegate>delegate;
@end
