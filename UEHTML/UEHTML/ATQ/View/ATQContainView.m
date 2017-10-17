//
//  ATQContainView.m
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQContainView.h"
@interface ATQContainView()
@property (nonatomic,strong)NSMutableArray *cusImageViewArray;
@property (nonatomic,strong)UIImageView *imageView;
@end
@implementation ATQContainView

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
-(void)setModel:(ATQPYQModel *)model
{
    _model = model;
    self.cusImageViewArray = [NSMutableArray array];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(model.picNameArray.count > 0)
    {
        float heightAndWidth = (ScreenWidth - 80 - 10)/3;
        [model.picNameArray enumerateObjectsUsingBlock:^(NSString *  imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake((idx%3) * (heightAndWidth+5), (idx/3)* (heightAndWidth+5), heightAndWidth, heightAndWidth);
            imageView.image = [UIImage imageNamed:imageName];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
            [self.cusImageViewArray addObject:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
        }];
    }
    
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *view = (UIImageView *)tap.view;
    if([_delegate respondsToSelector:@selector(didClickImageViewWithCurrentImageView:imageViewArray:imageSuperView:)])
    {
        [_delegate didClickImageViewWithCurrentImageView:view imageViewArray:self.cusImageViewArray imageSuperView:self];
    }
}

@end
