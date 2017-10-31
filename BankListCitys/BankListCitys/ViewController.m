//
//  ViewController.m
//  BankListCitys
//
//  Created by zhangkai on 2017/10/31.
//  Copyright © 2017年 liudejuan. All rights reserved.
//

#import "ViewController.h"
#import "DYSelectCityVC.h"

@interface ViewController ()<DYSelectCityVCDelegate>

@property (nonatomic,strong) UILabel *cityNameLabel;

@property (nonatomic,strong) UIButton *didClickBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.didClickBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.didClickBtn.frame = CGRectMake(50, 100, 100, 40);
    [self.didClickBtn setBackgroundColor:[UIColor cyanColor]];
    [self.didClickBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.didClickBtn setTitle:@"点击跳转" forState:(UIControlStateNormal)];
    [self.didClickBtn addTarget:self action:@selector(didPush:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.didClickBtn];
  
    
    //把label添加到view上
    [self.view addSubview:self.cityNameLabel];
    
}

#pragma mark - DYSelectCityVC delegate
// 选择城市代理回调
- (void)DYSelectCityVCPressFinishedButtonCityPro:(NSString *)cityPro ProvinceID:(NSString *)provinceID CityID:(NSString *)cityID {
    
    self.cityNameLabel.text = cityPro;
//    provinceIDs = provinceID;
//    cityIDs = cityID;
    
}


-(void)didPush:(UIButton *)sender{
    
    DYSelectCityVC *selectVC = [[DYSelectCityVC alloc] init];
     selectVC.delegate = self;
    [self.navigationController pushViewController:selectVC animated:YES];
    
}

-(UILabel *)cityNameLabel{
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 250, 50)];
        _cityNameLabel.textColor = [UIColor redColor];
        _cityNameLabel.backgroundColor = [UIColor cyanColor];
        _cityNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cityNameLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
