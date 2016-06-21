//
//  TagViewController.m
//  Bili
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "GLTagViewController.h"

#import "GLTagButtonBlueCell.h"
#import "GLTagButtonGreenCell.h"
#import "GLTagButtonYellowCell.h"

@interface GLTagViewController () <UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** BlueCellItem */
@property (nonatomic, strong) NSMutableArray *BlueCellItem_arr;

/** GreenCellItem */
@property (nonatomic, strong) NSMutableArray *GreenCellItem_arr;

/** YellowCellItem */
@property (nonatomic, strong) NSMutableArray *YellowCellItem_arr;

/** scrollView中的按钮数组 */
@property (nonatomic, strong) NSMutableArray *button_arr;

@end

@implementation GLTagViewController

static NSString * const ID_Yellow = @"ID_Yellow";

static NSString * const ID_Green = @"ID_Green";

static NSString * const ID_Blue = @"ID_Blue";

static NSInteger const ButtonH = 45;

- (NSMutableArray *)button_arr
{
    if (_button_arr == nil) {
        _button_arr = [NSMutableArray array];
        
        for (int i = 0; i < 10; ++i) {
            UIButton *btn = [[UIButton alloc]init];
            [_button_arr addObject:btn];
        }
    }
    return _button_arr;
}

- (NSMutableArray *)BlueCellItem_arr
{
    if (_BlueCellItem_arr == nil) {
        _BlueCellItem_arr = [NSMutableArray array];
        
        [_BlueCellItem_arr addObjectsFromArray:@[@"手办模型",@"舞蹈MMD",@"原创音乐",@"动漫杂谈",@"架子鼓",@"LOVE 呵呵哒后面 是啥",@"技术宅",@"德玛西亚",@"搞不懂是啥",@"动漫i++",@"ABCDEFG",@"AAAA"]];
        
    }
    return _BlueCellItem_arr;
}

- (NSMutableArray *)YellowCellItem_arr
{
//    @[@"手办模型",@"舞蹈MMD",@"原创音乐",@"动漫杂谈",@"架子鼓",@"LOVE 呵呵哒后面 是啥",@"技术宅",@"德玛西亚",@"搞不懂是啥",@"动漫i++",@"ABCDEFG",@"AAAA"]
    if (_YellowCellItem_arr == nil) {
        _YellowCellItem_arr = [NSMutableArray array];
        [_YellowCellItem_arr addObjectsFromArray:@[@"音MAD",@"ACG配音",@"手书",@"DIY",@"静止系MAD呵呵哒",@"洛天依",@"都是音乐向",@"AAAAA",@"BBBBBBBBB",@"CCCCCCC",@"ABCDEFG",@"AAAA"]];
    }
    return _YellowCellItem_arr;
}

- (NSMutableArray *)GreenCellItem_arr
{
    if (_GreenCellItem_arr == nil) {
        _GreenCellItem_arr = [NSMutableArray array];
        [_GreenCellItem_arr addObjectsFromArray:@[@"金坷垃",@"MINECAAABC",@"梁非凡",@"坦克世界",@"VOCALLLL",@"言和",@"剧情MMD",@"AMV",@"搞教程",@"剑网三",@"ABCDEFG",@"AAAA"]];
    }
    return _GreenCellItem_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = GLRandomColor;

    self.view.frame = [UIScreen mainScreen].bounds;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLTagButtonBlueCell"bundle:nil] forCellReuseIdentifier:ID_Blue];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLTagButtonGreenCell"bundle:nil] forCellReuseIdentifier:ID_Green];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLTagButtonYellowCell"bundle:nil] forCellReuseIdentifier:ID_Yellow];
    self.tableView.delegate = self;
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 设置 Cell...
    
    if (indexPath.row == 0) {
        
        GLTagButtonYellowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_Yellow];
        
        cell.item = self.YellowCellItem_arr;
        
        return cell;
    }else if(indexPath.row == 1){

        GLTagButtonGreenCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_Green];
        
        cell.item = self.GreenCellItem_arr;
        
        return cell;

    }else {

        GLTagButtonBlueCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_Blue];
        
        cell.item = self.BlueCellItem_arr;
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2) {
        return ButtonH * 3;
    }else{
        return ButtonH * 2;
    }

}



@end
