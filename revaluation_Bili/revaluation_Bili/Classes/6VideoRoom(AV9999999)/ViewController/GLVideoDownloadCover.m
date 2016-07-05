//
//  GLVideoDownloadCover.m
//  revaluation_Bili
//
//  Created by mac on 16/6/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GLVideoDownloadCover.h"

@interface GLVideoDownloadCover ()
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIView *panelView;

@property (weak, nonatomic) IBOutlet UILabel *SystemFreeSizeLabel;

@end

@implementation GLVideoDownloadCover

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
}

- (IBAction)hidePanel:(UIButton *)sender {
    
    self.hidden = YES;
    
}

- (void)awakeFromNib
{
    self.panelView.layer.cornerRadius = 5;
    self.panelView.clipsToBounds = YES;
    self.numLabel.layer.cornerRadius = self.numLabel.glw_width * 0.5;
    self.numLabel.clipsToBounds = YES;
    self.SystemFreeSizeLabel.text = [self getAvailableDiskSize];
}

-(NSString *)getAvailableDiskSize
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    /** 剩余空间： */
    [fattributes objectForKey:NSFileSystemFreeSize];

    NSString *SystemFreeSize = fattributes[@"NSFileSystemFreeSize"];
    
    if (SystemFreeSize.floatValue >= 1024*1024*1024)
    {
        return [NSString stringWithFormat:@"%.1fGB",SystemFreeSize.floatValue/(1024*1024*1024.00)];
    }
    
    return [NSString stringWithFormat:@"%.1fMB",SystemFreeSize.floatValue/(1024*1024.00)];

}

- (IBAction)DownMClick:(UIButton *)sender {
    self.DownMClick();
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
