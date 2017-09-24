//
//  ATQBFristTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myAccountBlock)();
typedef void(^myAlbumBlock)();
typedef void(^spreadBlock)();
typedef void(^myBusinessBlock)();
@interface ATQBFristTableViewCell : UITableViewCell
@property(copy,nonatomic)myAccountBlock myaccountblock;
@property(copy,nonatomic)myAlbumBlock myalbumblock;
@property(copy,nonatomic)spreadBlock spreadblock;
@property(copy,nonatomic)myBusinessBlock mybusinessblock;

@end
