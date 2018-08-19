//
//  GeneralController.m
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "GeneralController.h"
#import "GeneralViewModel.h"
#import <KFBlankSlate/KFBlankSlate.h>
#import <MJRefresh/MJRefresh.h>
#import "WebViewController.h"

@interface GeneralController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray<GeneralModel *> *list;
@property (nonatomic, strong) GeneralViewModel      *viewModel;
@property (nonatomic, assign) NSInteger             page;

@end

@implementation GeneralController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}

#pragma mark - Lazyloading
- (NSMutableArray<GeneralModel *> *)list {
    if (_list) {
        return _list;
    }
    
    _list = [NSMutableArray array];
    
    return _list;
}

- (GeneralViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[GeneralViewModel alloc] init];
    
    return _viewModel;
}

#pragma mark - Private
- (void)setupUI {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //设置tableView的header和footer
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self pullToRefresh];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self pullToLoading];
    }];
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    //首次进入先隐藏footer
    self.tableView.mj_footer.hidden = YES;
    
    //设置空白页
    [self setupBlankSlate];
}

/**********************************/
- (void)setupBlankSlate {
    //设置空白状态配置
    KFBlankSlateGeneralHandler *handler = [[KFBlankSlateGeneralHandler alloc] init];
    //设置统一的背景色（加载中、无数据、加载错误）
    [handler setBackgroundColor:[UIColor colorWithRed:225/255.0 green:255/255.0 blue:250/255.0 alpha:1] forState:KFDataLoadStateLoading | KFDataLoadStateEmpty | KFDataLoadStateFailed];
    //加载状态配置
    UIView *customView = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading"]];
    imageView.frame = CGRectMake(0, 0, 48, 48);
    [handler setCustomView:customView forState:KFDataLoadStateLoading];
    //无数据状态配置
    [handler setTitle:@"数据为空" forState:KFDataLoadStateEmpty];
    [handler setDescription:@"糟糕！这里什么都没有~" forState:KFDataLoadStateEmpty];
    [handler setImage:[UIImage imageNamed:@"empty"] forState:KFDataLoadStateEmpty];
    //加载错误状态配置
    [handler setImage:[UIImage imageNamed:@"error"] forState:KFDataLoadStateFailed];
    [handler setAttributedButtonTitle:({
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"重新载入"];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, string.length)];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, string.length)];
        
        string;
    }) controlState:UIControlStateNormal forState:KFDataLoadStateFailed];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
    UIImage *bgImage = [UIImage imageNamed:@"button_background"];
    bgImage = [[bgImage resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
    [handler setButtonBackgroundImage:bgImage controlState:UIControlStateNormal forState:KFDataLoadStateFailed];
    [handler setButtonBackgroundImage:bgImage controlState:UIControlStateHighlighted forState:KFDataLoadStateFailed];
    //点击按钮回调
    [handler setTapButtonHandler:^(UIButton *button) {
        [self loadData];
    }];
    //禁止滚动
    handler.scrollable = NO;
    
    self.tableView.kf_handler = handler;
}
/**********************************/

- (void)loadData {
    //显示加载状态页
    if (self.mode == KFDisplayModeLoading) {
        self.tableView.kf_handler.state = KFDataLoadStateLoading;
        return;
    }
    //显示空数据页
    if (self.mode == KFDisplayModeEmpty) {
        self.tableView.kf_handler.state = KFDataLoadStateLoading;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.kf_handler.state = KFDataLoadStateEmpty;
        });
        return;
    }
    //显示加载错误页
    if (self.mode == KFDisplayModeFail) {
        self.tableView.kf_handler.state = KFDataLoadStateLoading;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tableView.kf_handler.state = KFDataLoadStateFailed;
        });
        return;
    }
    //显示正常加载页
    if (self.mode == KFDisplayModeSuccess) {
        self.tableView.kf_handler.state = KFDataLoadStateLoading;
        [self pullToRefresh];
    }
}

//下拉刷新
- (void)pullToRefresh {
    self.page = 1;
    //请求数据
    [self.viewModel queryListWithPage:self.page success:^{
        [self.list removeAllObjects];
        
        //插入数据
        [self.list addObjectsFromArray:self.viewModel.list];
        
        if (self.viewModel.list.count == 0) {
            //无数据的情况
            //置为空数据状态
            self.tableView.kf_handler.state = KFDataLoadStateEmpty;
            //隐藏footer
            self.tableView.mj_footer.hidden = YES;
        } else {
            //有数据的情况
            //置为闲置状态
            self.tableView.kf_handler.state = KFDataLoadStateIdle;
            //设置footer显示状态
            self.tableView.mj_footer.hidden = self.list.count < 10;
            //刷新tableView
            [self.tableView reloadData];
        }
        
        //如果是刷新状态则停止刷新
        if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        if (self.list.count == 0) {
            self.tableView.kf_handler.state = KFDataLoadStateFailed;
        }
        //如果是刷新状态则停止刷新
        if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

//上拉加载
- (void)pullToLoading {
    self.page ++;
    [self.viewModel queryListWithPage:self.page success:^{
        //插入数据
        [self.list addObjectsFromArray:self.viewModel.list];
        
        if (self.viewModel.list.count == 0) {
            //显示已全部加载
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            //刷新tableView
            [self.tableView reloadData];
        }
        //停止加载状态
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        //停止加载状态
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simple" forIndexPath:indexPath];
    
    GeneralModel *model = self.list[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.attributedText = ({
        NSString *text = [NSString stringWithFormat:@"%@<%@>", model.desc, model.who];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(model.desc.length, model.who.length + 2)];
        
        attributedString;
    });
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.url = self.list[indexPath.row].url;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
