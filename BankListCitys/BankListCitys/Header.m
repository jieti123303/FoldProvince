//
//  Header.m
//  QQ好友列表
//
//  Created by mj on 13-7-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Header.h"
#import "DYView+DYExtension.h"

#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define SCALE [[UIScreen mainScreen] bounds].size.width/375

@implementation Header
{
    UIImageView *IconImage;
    UILabel *customLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        IconImage=[[UIImageView alloc]init];
        IconImage.image=[UIImage imageNamed:@"箭头下"];
        IconImage.frame=CGRectMake(5, 10, 14*SCALE, 8*SCALE);
        IconImage.rightX = KScreenWidth - 20*SCALE;
        IconImage.centerY = 43*SCALE/2;
        [self addSubview:IconImage];
        

        
        //[self setImage:[UIImage imageNamed:@"箭头2.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setOpen:(BOOL)open {
    _open = open;
    [UIView beginAnimations:nil context:nil];
    IconImage.transform = CGAffineTransformMakeRotation(_open?M_PI:0);
    [UIView commitAnimations];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, 25, contentRect.size.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(20, 0, contentRect.size.width, contentRect.size.height);
}

@end
