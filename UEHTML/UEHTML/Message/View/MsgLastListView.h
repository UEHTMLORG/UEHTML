//
//  MsgLastListView.h
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgLastCollectionViewCell.h"

@interface MsgLastListView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property (strong, nonatomic) IBOutlet UIButton *moreButton;

@property (strong, nonatomic) UICollectionView *collectionView;

- (void)setCollectionViews;

@end
