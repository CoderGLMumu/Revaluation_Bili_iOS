//
//  GLRegardUpViewController.m
//  revaluation_Bili
//
//  Created by mac on 16/6/19.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLRegardUpViewController.h"
#import "GLRegardUpCell.h"

#import "GLLiveRoomViewController.h"

#import "GLRegardUpViewModel.h"
#import "GLRegardUpModel.h"

#import "GLDIYHeader.h"

@interface GLRegardUpViewController ()
/** lbviewModel */
@property (nonatomic, strong) GLRegardUpViewModel *viewModel;

@end

@implementation GLRegardUpViewController

- (GLRegardUpViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[GLRegardUpViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置标题
    self.title = @"我的关注";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 213;
    self.tableView.tableHeaderView.glh_height = 10;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadDataSouce];
    
    // 下拉刷新数据
    self.tableView.mj_header = [GLDIYHeader headerWithRefreshingBlock:^{
        // 发送网络请求
        [self loadDataSouce];
    }];
}

#pragma mark -  获取网络数据
- (void)loadDataSouce
{
    __weak typeof(self)weakSelf = self;
    // 发送网络请求
    [weakSelf.viewModel handleLiveViewDataSuccess:^{
//        [weakSelf setUpHeaderView];
        if (weakSelf.tableView.mj_header.isRefreshing) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        [weakSelf.tableView reloadData];
    } Failure:^{
        if (weakSelf.tableView.mj_header.isRefreshing) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.listModels.count;
}


- (GLRegardUpCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLRegardUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegardCell" forIndexPath:indexPath];
    
    cell.model = self.viewModel.listModels[indexPath.row];
    
    /** sb中也设置了cell点击不显示背景 */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 跳转LiveRoom控制器
    GLLiveRoomViewController *LiveRoomVC = [GLLiveRoomViewController new];
    GLRegardUpCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    LiveRoomVC.room_id = cell.model.roomid.stringValue;
    LiveRoomVC.face = cell.model.face;
    LiveRoomVC.online = @"拿不到数据";
    [self.navigationController pushViewController:LiveRoomVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
