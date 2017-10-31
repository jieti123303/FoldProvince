//
//  DYCityTableViewCell.m
//  帝友系统V5
//
//  Created by wang on 15/7/31.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

#import "DYCityTableViewCell.h"
#import "DYView+DYExtension.h"

@implementation DYCityTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpViews];
    }
    return self;
}


-(void)setUpViews{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 20)];
    label.centerY = self.centerY;
    [self.contentView addSubview:label];
    self.cityLabel = label;
    
}



@end
