//
//  ATQFristTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myAccountBlock)();
typedef void(^myAlbumBlock)();
typedef void(^spreadBlock)();
@interface ATQFristTableViewCell : UITableViewCell
@property(copy,nonatomic)myAccountBlock myaccountblock;
@property(copy,nonatomic)myAlbumBlock myalbumblock;
@property(copy,nonatomic)spreadBlock spreadblock;
@end
