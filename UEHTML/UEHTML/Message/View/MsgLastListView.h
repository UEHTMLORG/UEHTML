//
//  MsgLastListView.h
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgLastCollectionViewCell.h"

typedef void(^ClickBlock)(NSString *id,NSString *avatarString);

@interface MsgLastListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (strong, nonatomic) IBOutlet UIButton *moreButton;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *aaray;
@property (nonatomic, copy) ClickBlock  cBlock;


- (void)loadClickBlock:(ClickBlock )block;
- (void)setCollectionViews;

@end
