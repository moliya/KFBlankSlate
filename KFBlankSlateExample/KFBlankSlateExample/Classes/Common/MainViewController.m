//
//  MainViewController.m
//  KFBlankSlateExample
//
//  Created by Carefree on 2018/8/18.
//  Copyright © 2018年 Carefree. All rights reserved.
//

#import "MainViewController.h"
#import "GeneralController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *identifier = @"general";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择展示的效果" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:({
        [UIAlertAction actionWithTitle:@"加载中效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:identifier sender:@(KFDisplayModeLoading)];
        }];
    })];
    [alert addAction:({
        [UIAlertAction actionWithTitle:@"空数据效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:identifier sender:@(KFDisplayModeEmpty)];
        }];
    })];
    [alert addAction:({
        [UIAlertAction actionWithTitle:@"加载成功效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:identifier sender:@(KFDisplayModeSuccess)];
        }];
    })];
    [alert addAction:({
        [UIAlertAction actionWithTitle:@"加载失败效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self performSegueWithIdentifier:identifier sender:@(KFDisplayModeFail)];
        }];
    })];
    [alert addAction:({
        [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    })];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return NO;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GeneralController *generalVC = [segue destinationViewController];
    generalVC.mode = [sender integerValue];
}


@end
