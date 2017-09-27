//
//  ATQPlaceholderTextView.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPlaceholderTextView.h"
#import "Masonry.h"
@interface ATQPlaceholderTextView()<UITextViewDelegate>
@end
@implementation ATQPlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    float left=5,top=2,hegiht=30;
    
    self.placeholderColor = [UIColor lightGrayColor];
    //    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
    //                                                               , self.frame.size.width, hegiht)];
    _PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectZero];
    _PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    _PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:_PlaceholderLabel];
    _PlaceholderLabel.text = self.placeholder;
    [_PlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(left);
        make.top.equalTo(self).offset(top);
        make.right.equalTo(self).offset(-5);
        make.height.mas_equalTo(hegiht);
    }];
    
}

-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    else
        _PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _PlaceholderLabel.hidden=YES;
    }
    else{
        _PlaceholderLabel.hidden=NO;
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_PlaceholderLabel removeFromSuperview];
}

@end
