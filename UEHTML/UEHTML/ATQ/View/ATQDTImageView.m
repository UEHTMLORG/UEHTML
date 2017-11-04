//
//  ATQDTImageView.m
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQDTImageView.h"
#import "ATQDTModel.h"
#import "UIImageView+WebCache.h"
@interface ATQDTImageView()
@property (nonatomic,strong)NSMutableArray *cusImageViewArray;
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation ATQDTImageView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setModel:(ATQDTModel *)model
{
    _model = model;
    self.cusImageViewArray = [NSMutableArray array];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(model.pictures.count > 0)
    {
        float heightAndWidth = (ScreenWidth - 80 - 10)/3;
        [model.pictures enumerateObjectsUsingBlock:^(NSDictionary *imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake((idx%3) * (heightAndWidth+5), (idx/3)* (heightAndWidth+5), heightAndWidth, heightAndWidth);
            [imageView sd_setImageWithURL:imageName[@"pic"] placeholderImage:[UIImage imageNamed:@""]];
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


#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

