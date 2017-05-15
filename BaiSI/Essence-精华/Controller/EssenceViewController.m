//
//  EssenceViewController.m
//  BaiSI
//
//  Created by Mac on 17/5/2.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import "EssenceViewController.h"
#import "XLsn0wLoop.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"

#import "ECell.h"
#import "CaidanV.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface EssenceViewController ()<XLsn0wLoopDelegate,JFLocationDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XLsn0wLoop *loop;
@property (strong, nonatomic) UILabel *resultLabel;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;
//城市名
@property (nonatomic,copy) NSString *city;
@property (nonatomic,strong) UIButton *but;
@property (nonatomic,strong) UIButton *btn;

@end

@implementation EssenceViewController

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

static NSString *ECELL = @"ECELL";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LCommonBgColor;
    
    //标题图片
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //右边按钮
    _btn = [[UIButton alloc] init];
    [_btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(tagClick1) forControlEvents:UIControlEventTouchUpInside];
    [_btn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:_btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //左边按钮
    UIButton *but = [[UIButton alloc] init];
    //    [but setTitle:_city forState:UIControlStateNormal];
    //    but.titleLabel.font = [UIFont systemFontOfSize:14];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (but.titleLabel.text == nil) {
        NSString *value = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentCity"];
        [but setTitle:value forState:UIControlStateNormal];
        [self viewDidAppear:YES];
    }
    but.frame = CGRectMake(0, 0, 120, 40);
    
    [but setImage:[UIImage imageNamed:@"01"] forState:UIControlStateNormal];
    
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _but = but;
    UIBarButtonItem *butItem = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = butItem;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick2)];
    
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
    [self setupTableview];
    [self viewWillAppear:YES];
}

- (void)setupTableview{

    self.tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView.tableHeaderView.height = 180;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ECell class]) bundle:nil] forCellReuseIdentifier:ECELL];
    //self.tableView.rowHeight = 120;
    [self addLoop];
    
    
}

#pragma mark UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        CaidanV *V = [[CaidanV alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width/5*2)];
        [cell addSubview:V];
        return cell;
        
    }else{
        ECell *MYCell = [tableView dequeueReusableCellWithIdentifier:ECELL];
        if (MYCell == nil) {
            MYCell = [[ECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ECELL];;
    }
        return MYCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return self.view.width/5*2;
    }else{
    
        return 120;
    }
    
}

- (void)addLoop {
    self.loop = [[XLsn0wLoop alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    [self.tableView.tableHeaderView addSubview:self.loop];
    self.loop.xlsn0wDelegate = self;
    self.loop.time = 5;
    [self.loop setPageColor:[UIColor blueColor] andCurrentPageColor:[UIColor redColor]];
    //支持gif动态图
    self.loop.imageArray = @[@"http://i3.hoopchina.com.cn/u/1212/19/386/16355386/2d4f91db_530x.gif",
                             @"http://pic2015.5442.com/2015/1118/8/18.jpg%21960.jpg",
                             @"http://tpic.home.news.cn/xhCloudNewsPic/xhpic1501/M07/1B/9C/wKhTlVeRvImESafHAAAAAGHVmt8775.gif",
                             @"http://www.pp3.cn/uploads/201606/2016060401.jpg"];
}

#pragma mark XRCarouselViewDelegate
- (void)loopView:(XLsn0wLoop *)loopView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
}
- (void)tagClick1{
    
    NSLog(@"111");
    
}
- (void)tagClick2
{
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"城市";
    __weak typeof(self) weakSelf = self;
    [cityViewController choseCityBlock:^(NSString *cityName) {
        [weakSelf.but setTitle:cityName forState:UIControlStateNormal];
        [self viewWillAppear:YES];
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
#pragma mark --- JFLocationDelegate

//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    if (![_but.titleLabel.text isEqualToString:city]) {
        //        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        //        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_but setTitle:city forState:UIControlStateNormal];
        [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
        [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
        [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
            [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
        }];
        
        //        }];
        //        [alertController addAction:cancelAction];
        //        [alertController addAction:okAction];
        //        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}
- (void)viewWillAppear:(BOOL)animated{
    _but.imageEdgeInsets = UIEdgeInsetsMake(0, _but.titleLabel.width, 0, -_but.titleLabel.width);
    _but.titleEdgeInsets = UIEdgeInsetsMake(0, -_but.imageView.width, 0, _but.imageView.width);
}

@end
