//
//  DYSelectCityVC.m
//  帝友系统V5
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 wayne. All rights reserved.
//

//思路 :
//省 ： tablwView的header, header上放button, 点击了哪个header,就让哪个section的cell的个数不为0
//市 ： 就是tableView的cell

#import "DYSelectCityVC.h"
#import "Header.h"
#import "DYCityTableViewCell.h"
#import "DYView+DYExtension.h"
#define kEpage @"10"
#define SCALE [[UIScreen mainScreen] bounds].size.width/375
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]//颜色
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DYSelectCityVC ()<UITableViewDataSource,UITableViewDelegate>
{
    int page; //页号
    NSArray *provincelist;
    NSArray *citylist;
    NSInteger sectioncount;
    BOOL touchBool;
    NSString *provicestr;
}

@property (nonatomic,strong) UITableView *tableViewInvest;

@end

@implementation DYSelectCityVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择省市";
    self.view.backgroundColor = [UIColor whiteColor];
    
    citylist = [NSArray array];
    provincelist = [NSArray array];
    
    [self.view addSubview:self.tableViewInvest];
    
    
    [self queryDataIsRefreshing];
    
}

#pragma mark -- request

- (void)queryDataIsRefreshing {
    
 self.headers = [NSMutableDictionary dictionary];
    
    //  1. 从文件中读取plist文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Arr" ofType:@"plist"];
    
    // 2. 初始化数据数组
    NSArray *cityArrs = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@", cityArrs);

    provincelist = cityArrs;
    
   [self.tableViewInvest reloadData];

}





#pragma mark -- UITableView DataSource&&Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return provincelist.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Header *header = self.headers[@(section)];
    if (touchBool == YES && header.open == YES) {
        NSDictionary *dic = provincelist[sectioncount-1];
        NSArray *groupFriends =dic[@"city_list"];//self.friends[section][@"friends"];
        if (sectioncount  == section) {
            return groupFriends.count;
        }
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DYCityTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"DYCityTableViewCell"];
    
//    if(!cell){
//        cell  =[[[NSBundle mainBundle]loadNibNamed:@"DYCityTableViewCell" owner:nil options:nil]lastObject];
//    }
    NSDictionary *dic = provincelist[indexPath.section - 1];
    citylist = dic[@"city_list"];
    NSDictionary *cityDic = citylist[indexPath.row];
    cell.cityLabel.text  = cityDic[@"name"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, 43*SCALE)];
        UILabel *remindLabel = [self createLabelWithFrame:CGRectMake(20*SCALE, 0, KScreenWidth - 20*SCALE, 43*SCALE) text:@"请选择开户行所在城市" textColor:UIColorFromRGB(0x999999) font:[UIFont systemFontOfSize:13*SCALE]];
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10*SCALE, 42*SCALE, self.view.size.width - 20*SCALE, 1)];
        back.backgroundColor = [UIColor colorWithRed:231.f/255.f green:231.f/255.f blue:231.f/255.f alpha:0.5];
        [view addSubview:back];
        [view addSubview:remindLabel];
        return view;
    }
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(10*SCALE, 42*SCALE, self.view.size.width - 20*SCALE, 1)];
    back.backgroundColor = [UIColor colorWithRed:231.f/255.f green:231.f/255.f blue:231.f/255.f alpha:0.5];
    Header *btn = self.headers[@(section)];
    if (!btn) {
        btn = [Header buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.bounds = CGRectMake(0, 0, self.view.size.width, 43*SCALE);
        NSDictionary *dic = provincelist[section - 1];
        NSString *group = dic[@"name"];
        provicestr = group;
        [btn setTitle:group forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14*SCALE];
        [btn setTitleColor:UIColorFromRGB(0x7884a0) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(expandGroup:event:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [self.headers setObject:btn forKey:@(section)];
        [btn addSubview:back];
    }
    
    
    return btn;
}
- (void)expandGroup:(Header *)header event:(UIEvent *)event {
    //[tableViewInvest reloadSections:[NSIndexSet indexSetWithIndex:sectioncount] withRowAnimation:UITableViewRowAnimationBottom];
    
    for (Header *hbtn in self.headers.allValues) {
        if (hbtn != header) {
            hbtn.open = NO;
        }
    }
    
    header.open = !header.open;
    NSLog(@"%d",header.open);
    touchBool = YES;
    sectioncount = header.tag;
    //NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.tableViewInvest reloadData];
   // [tableViewInvest reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43*SCALE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //委托代理，返回上一个界面的数据
    if ([self.delegate respondsToSelector:@selector(DYSelectCityVCPressFinishedButtonCityPro:ProvinceID:CityID:)]) {
        
        NSDictionary *dic = provincelist[indexPath.section - 1];
        NSString *provinceTitle = dic[@"name"];
        citylist = dic[@"city_list"];
        NSDictionary *cityDic = citylist[indexPath.row];
        NSString *proCity = [NSString stringWithFormat:@"%@%@",provinceTitle,cityDic[@"name"]];
        [self.delegate DYSelectCityVCPressFinishedButtonCityPro:proCity ProvinceID:cityDic[@"pid"] CityID:cityDic[@"id"]];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

//UILabel
-(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}


-(UITableView *)tableViewInvest{
    if (!_tableViewInvest) {
        
        _tableViewInvest = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)];
        
        _tableViewInvest.delegate = self;
        _tableViewInvest.dataSource = self;
        [_tableViewInvest registerClass:[DYCityTableViewCell class] forCellReuseIdentifier:@"DYCityTableViewCell"];
      //  _tableViewInvest.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            _tableViewInvest.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

    }
    
     return _tableViewInvest;
}


@end
