//
//  LBRecommedViewController.m
//  Bili
//
//  Created by 林彬 on 16/3/31.
//  Copyright © 2016年 gl. All rights reserved.
//

//推荐
#import "LBRecommedViewController.h"
#import "LBRecommedViewModel.h"

//#import "LBHttpTool.h"
// cell的模型
#import "LBRecommedModel.h"
// cell里每个元素的模型
#import "LBBodyModel.h"
#import "LBRecommedCell.h"

@interface LBRecommedViewController ()

/** lbRecommedViewModel */
@property (nonatomic, strong) LBRecommedViewModel *lbRecommedViewModel;

@end

@implementation LBRecommedViewController

static NSString * const RecommedID = @"LBRecommedCell";

- (LBRecommedViewModel *)lbRecommedViewModel
{
    if (_lbRecommedViewModel == nil) {
        _lbRecommedViewModel = [LBRecommedViewModel viewModel];
    }
    return _lbRecommedViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 去掉Cell的间隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = LBGlobeColor;
    
    [self getNetData];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LBRecommedCell" bundle:nil] forCellReuseIdentifier:RecommedID];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// 请求网络数据
- (void)getNetData{
    
    [[LBRecommedViewModel viewModel]handleLiveViewDataSuccess:^{
        // 刷新数据
        [self.tableView reloadData];
        
    } Failure:^{
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lbRecommedViewModel.cellArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3 || indexPath.row == 8) {
        LBRecommedCell *cell = [[LBRecommedCell alloc] init];
        cell.cellItem = self.lbRecommedViewModel.cellArr[indexPath.row];
        return cell;
        
    }else if (indexPath.row == 0 ){
        
        LBRecommedCell *cell = [[NSBundle mainBundle] loadNibNamed:@"LBRecommedCell" owner:self options:nil].lastObject;
        
        cell.cellItem = self.lbRecommedViewModel.cellArr[indexPath.row];
        for (UIView *view in cell.bottomView.subviews) {
            [view removeFromSuperview];
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat buttonW = GLScreenW - 80;
        CGFloat buttonH = 40;
        CGFloat buttonX = 40;
        CGFloat buttonY = 10;
        [button setTitle:@"换一波看看" forState:UIControlStateNormal];
        [button setTitle:@"换一波看看" forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.backgroundColor = LBColor(200, 200, 200);
        [cell.bottomView addSubview:button];
        
        return cell;
        
    }else if (indexPath.row == 1){
        LBRecommedCell *cell = [[NSBundle mainBundle] loadNibNamed:@"LBRecommedCell" owner:self options:nil].lastObject;
        
        cell.cellItem = self.lbRecommedViewModel.cellArr[indexPath.row];
        for (UIView *view in cell.bottomView.subviews) {
            [view removeFromSuperview];
        }
         cell.bottomView.backgroundColor = [UIColor blueColor];
        return cell;
        
    }else if (indexPath.row == 2){
        LBRecommedCell *cell = [[NSBundle mainBundle] loadNibNamed:@"LBRecommedCell" owner:self options:nil].lastObject;
                                
        cell.cellItem = self.lbRecommedViewModel.cellArr[indexPath.row];
        for (UIView *view in cell.bottomView.subviews) {
            [view removeFromSuperview];
        }
        cell.bottomView.backgroundColor = [UIColor greenColor];
        
        return cell;
        
    }
    else {
        LBRecommedCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBRecommedCell class]) owner:self options:nil] objectAtIndex:0];
        cell.cellItem = self.lbRecommedViewModel.cellArr[indexPath.row];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.lbRecommedViewModel.cellArr[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
