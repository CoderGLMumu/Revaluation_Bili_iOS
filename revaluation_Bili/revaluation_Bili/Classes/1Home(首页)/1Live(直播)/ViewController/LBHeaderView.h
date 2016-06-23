//
//  LBHeaderView.h
//  Bili
//
//  Created by 林彬 on 16/4/14.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBEntranceButtonItem;
@class LBLiveViewModel;

@protocol LBHeaderViewDelegate <NSObject>

- (void)middleButtonsDidClick:(UIButton *)button ClickBtnID:(int)clickBtnID ButtonItem:(LBEntranceButtonItem *)buttonItem;

@end

@interface LBHeaderView : UIView

// headerView中N个按钮的模型数组
@property (nonatomic , strong)NSArray <LBEntranceButtonItem *>*entranceButtomItems;

/** liveViewModel */
@property (nonatomic, strong) LBLiveViewModel *viewModel;

// headerView的banner模型数组
@property(nonatomic ,strong)NSArray *headerBannerArr;

@property(nonatomic, strong) void(^ClickRegardUpButton)();

@property(nonatomic, strong) void(^ClickBanner)(NSString *link);

@property (nonatomic ,weak)id <LBHeaderViewDelegate> delegate;

+(instancetype)headerViewFromNib;

//@property(nonatomic,strong) void(^block)(CGFloat);

@end
