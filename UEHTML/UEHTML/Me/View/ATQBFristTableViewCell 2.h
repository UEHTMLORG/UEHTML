//
//  ATQBFristTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^vipmyAccountBlock)();
typedef void(^vipmyAlbumBlock)();
typedef void(^vipspreadBlock)();
typedef void(^vipmyBusinessBlock)();
@interface ATQBFristTableViewCell : UITableViewCell
@property(copy,nonatomic)vipmyAccountBlock vipmyaccountblock;
@property(copy,nonatomic)vipmyAlbumBlock vipmyalbumblock;
@property(copy,nonatomic)vipspreadBlock vipspreadblock;
@property(copy,nonatomic)vipmyBusinessBlock vipmybusinessblock;

@end
