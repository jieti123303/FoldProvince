//
//  DYSelectCityVC.h
//  帝友系统V5
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DYSelectCityVC;
@protocol DYSelectCityVCDelegate <NSObject>
@optional
- (void)DYSelectCityVCPressFinishedButtonCityPro:(NSString *)cityPro ProvinceID:(NSString *)provinceID CityID:(NSString *)cityID;
@end

@interface DYSelectCityVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_mArray;
    NSArray *_headerArray;
}

@property(nonatomic,assign) id <DYSelectCityVCDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *headers;
@property(nonatomic,strong)NSArray *FriendGorup;
@property(nonatomic,strong)NSDictionary *diclist;
@property (nonatomic,strong)NSString *areaString;
@end
