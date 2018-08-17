//
//  SimpleController.m
//  KFBlankSlateExample
//
//  Created by carefree on 2018/8/17.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "SimpleController.h"
#import "SimpleViewModel.h"
#import <KFBlankSlate/KFBlankSlate.h>
#import <MJRefresh/MJRefresh.h>

@interface SimpleController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray<SimpleModel *> *list;
@property (nonatomic, strong) SimpleViewModel       *viewModel;
@property (nonatomic, assign) NSInteger             page;

@end

@implementation SimpleController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self pullToRefresh];
}

#pragma mark - Lazyloading
- (NSMutableArray<SimpleModel *> *)list {
    if (_list) {
        return _list;
    }
    
    _list = [NSMutableArray array];
    
    return _list;
}

- (SimpleViewModel *)viewModel {
    if (_viewModel) {
        return _viewModel;
    }
    
    _viewModel = [[SimpleViewModel alloc] init];
    
    return _viewModel;
}

#pragma mark - Private
- (void)setupUI {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //设置空白状态配置
    KFBlankSlateGeneralHandler *handler = [[KFBlankSlateGeneralHandler alloc] init];
    handler.scrollable = NO;
    self.tableView.kf_handler = handler;
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
}

//下拉刷新
- (void)pullToRefresh {
    self.page = 1;
    if (self.tableView.kf_handler.state == KFDataLoadStateReady) {
        self.tableView.kf_handler.state = KFDataLoadStateLoading;
    }
    //请求数据
    [self.viewModel querySimpleListWithPage:self.page success:^{
        [self.list removeAllObjects];
        
        if (self.viewModel.list.count == 0) {
            //无数据
            self.tableView.kf_handler.state = KFDataLoadStateEmpty;
            //隐藏footer
            self.tableView.mj_footer.hidden = YES;
        }
        //插入数据
        [self.list addObjectsFromArray:self.viewModel.list];
        //刷新tableView
        [self.tableView reloadData];
    } failure:nil];
}

//上拉加载
- (void)pullToLoading {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simple" forIndexPath:indexPath];
    
    SimpleModel *model = self.list[indexPath.row];
    cell.textLabel.attributedText = ({
        NSString *text = [NSString stringWithFormat:@"%@<%@>", model.desc, model.who];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(model.desc.length, model.who.length + 2)];
        
        attributedString;
    });
    if (model.images.count > 0) {
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
