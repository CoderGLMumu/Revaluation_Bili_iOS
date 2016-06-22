//
//  MyFlowLayout.m
//  MyLayout
//
//  Created by apple on 15/10/31.
//  Copyright (c) 2015年 欧阳大哥. All rights reserved.
//

#import "MyFlowLayout.h"
#import "MyLayoutInner.h"

IB_DESIGNABLE
@implementation MyFlowLayout

-(id)initWithOrientation:(MyLayoutViewOrientation)orientation arrangedCount:(NSInteger)arrangedCount
{
    self = [super init];
    if (self != nil)
    {
        self.myCurrentSizeClass.orientation = orientation;
        self.myCurrentSizeClass.arrangedCount = arrangedCount;
    }
    
    return self;
}


+(id)flowLayoutWithOrientation:(MyLayoutViewOrientation)orientation arrangedCount:(NSInteger)arrangedCount
{
    MyFlowLayout *layout = [[[self class] alloc] initWithOrientation:orientation arrangedCount:arrangedCount];
    return layout;
}

-(void)setOrientation:(MyLayoutViewOrientation)orientation
{
     MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.orientation != orientation)
    {
        lsc.orientation = orientation;
        [self setNeedsLayout];
    }
}

-(MyLayoutViewOrientation)orientation
{
    return self.myCurrentSizeClass.orientation;
}

-(void)setArrangedCount:(NSInteger)arrangedCount
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.arrangedCount != arrangedCount)
    {
        lsc.arrangedCount = arrangedCount;
        [self setNeedsLayout];
    }
}

-(NSInteger)arrangedCount
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    return lsc.arrangedCount;
}


-(void)setAverageArrange:(BOOL)averageArrange
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;

    if (lsc.averageArrange != averageArrange)
    {
        lsc.averageArrange = averageArrange;
        [self setNeedsLayout];
    }
}

-(BOOL)averageArrange
{
    return self.myCurrentSizeClass.averageArrange;
}

-(void)setGravity:(MyMarginGravity)gravity
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.gravity != gravity)
    {
        lsc.gravity = gravity;
        [self setNeedsLayout];
    }
}

-(MyMarginGravity)gravity
{
    return self.myCurrentSizeClass.gravity;
}

-(void)setArrangedGravity:(MyMarginGravity)arrangedGravity
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.arrangedGravity != arrangedGravity)
    {
        lsc.arrangedGravity = arrangedGravity;
        [self setNeedsLayout];
    }
}

-(MyMarginGravity)arrangedGravity
{
    return self.myCurrentSizeClass.arrangedGravity;
}

-(void)setSubviewHorzMargin:(CGFloat)subviewHorzMargin
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;

    if (lsc.subviewHorzMargin != subviewHorzMargin)
    {
        lsc.subviewHorzMargin = subviewHorzMargin;
        [self setNeedsLayout];
    }
}

-(CGFloat)subviewHorzMargin
{
    return self.myCurrentSizeClass.subviewHorzMargin;
}

-(void)setSubviewVertMargin:(CGFloat)subviewVertMargin
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.subviewVertMargin != subviewVertMargin)
    {
        lsc.subviewVertMargin = subviewVertMargin;
        [self setNeedsLayout];
    }
}

-(CGFloat)subviewVertMargin
{
    return self.myCurrentSizeClass.subviewVertMargin;
}

-(CGFloat)subviewMargin
{
    return self.myCurrentSizeClass.subviewMargin;
}

-(void)setSubviewMargin:(CGFloat)subviewMargin
{
    MyFlowLayout *lsc = self.myCurrentSizeClass;
    if (lsc.subviewMargin != subviewMargin)
    {
        lsc.subviewMargin = subviewMargin;
        [self setNeedsLayout];
    }
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview != nil)
    {
        //不支持放在UITableView和UICollectionView下,因为有肯能是tableheaderView或者section下。
        if ([newSuperview isKindOfClass:[UIScrollView class]] && ![newSuperview isKindOfClass:[UITableView class]] && ![newSuperview isKindOfClass:[UICollectionView class]])
            self.adjustScrollViewContentSize = YES;
    }

    
}


- (void)calcVertLayoutGravity:(CGFloat)selfWidth rowMaxHeight:(CGFloat)rowMaxHeight rowMaxWidth:(CGFloat)rowMaxWidth mg:(MyMarginGravity)mg amg:(MyMarginGravity)amg sbs:(NSArray *)sbs startIndex:(NSInteger)startIndex count:(NSInteger)count
{
    
    UIEdgeInsets padding = self.padding;
    CGFloat addXPos = 0;
    if (!self.averageArrange || self.arrangedCount == 0)
    {
        switch (mg) {
            case MyMarginGravity_Horz_Center:
            {
                addXPos = (selfWidth - padding.left - padding.right - rowMaxWidth) / 2;
            }
                break;
            case MyMarginGravity_Horz_Right:
            {
                addXPos = selfWidth - padding.left - padding.right - rowMaxWidth; //因为具有不考虑左边距，而原来的位置增加了左边距，因此
            }
                break;
            default:
                break;
        }
    }
    
    
    //将整行的位置进行调整。
    for (NSInteger j = startIndex - count; j < startIndex; j++)
    {
        UIView *sbv = sbs[j];
        
        if (self.IntelligentBorderLine != nil)
        {
            if ([sbv isKindOfClass:[MyBaseLayout class]])
            {
                MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                if (!sbvl.notUseIntelligentBorderLine)
                {
                    sbvl.leftBorderLine = nil;
                    sbvl.topBorderLine = nil;
                    sbvl.rightBorderLine = nil;
                    sbvl.bottomBorderLine = nil;
                    
                    if (j != startIndex - count)
                    {
                        sbvl.leftBorderLine = self.IntelligentBorderLine;
                    }
                    
                    if (startIndex - count != 0)
                    {
                        sbvl.topBorderLine = self.IntelligentBorderLine;
                    }
                    
                    
                }
            }
        }
        
        if ((amg != MyMarginGravity_None && amg != MyMarginGravity_Vert_Top) || addXPos != 0)
        {
            
            sbv.absPos.leftPos += addXPos;
            
            switch (amg) {
                case MyMarginGravity_Vert_Center:
                {
                    sbv.absPos.topPos += (rowMaxHeight - sbv.topPos.margin - sbv.bottomPos.margin - sbv.absPos.height) / 2;
                    
                }
                    break;
                case MyMarginGravity_Vert_Bottom:
                {
                    sbv.absPos.topPos += rowMaxHeight - sbv.topPos.margin - sbv.bottomPos.margin - sbv.absPos.height;
                }
                    break;
                case MyMarginGravity_Vert_Fill:
                {
                    sbv.absPos.height = [sbv.heightDime validMeasure:rowMaxHeight - sbv.topPos.margin - sbv.bottomPos.margin] ;
                }
                    break;
                default:
                    break;
            }
        }
    }

}

-(CGRect)layoutSubviewsForVertFloat:(CGRect)selfRect
{
    NSMutableArray *sbs = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (UIView *sbv in self.subviews)
    {
        if (sbv.useFrame || ( sbv.isHidden && self.hideSubviewReLayout) || sbv.absPos.sizeClass.isHidden)
            continue;
        
        [sbs addObject:sbv];
    }
    
    
    UIEdgeInsets padding = self.padding;
    CGFloat xPos = padding.left;
    CGFloat yPos = padding.top;
    CGFloat rowMaxHeight = 0;  //某一行的最高值。
    CGFloat rowMaxWidth = 0;   //某一行的最宽值
    
    MyMarginGravity mgvert = self.gravity & MyMarginGravity_Horz_Mask;
    MyMarginGravity mghorz = self.gravity & MyMarginGravity_Vert_Mask;
    MyMarginGravity amgvert = self.arrangedGravity & MyMarginGravity_Horz_Mask;
    
    NSInteger arrangedIndex = 0;
    NSInteger i = 0;
    for (; i < sbs.count; i++)
    {
        UIView *sbv = sbs[i];
        
        CGFloat topMargin = sbv.topPos.margin;
        CGFloat leftMargin = sbv.leftPos.margin;
        CGFloat bottomMargin = sbv.bottomPos.margin;
        CGFloat rightMargin = sbv.rightPos.margin;
        CGRect rect = sbv.absPos.frame;
        
        //控制最大最小尺寸
        rect.size.height = [sbv.heightDime validMeasure:rect.size.height];
        rect.size.width  = [sbv.widthDime validMeasure:rect.size.width];
        
        if (sbv.widthDime.dimeNumVal != nil)
            rect.size.width = sbv.widthDime.measure;
        
        if (sbv.heightDime.dimeNumVal != nil)
            rect.size.height = sbv.heightDime.measure;
        
        if (sbv.widthDime.dimeRelaVal == self.widthDime && !self.wrapContentWidth)
            rect.size.width = [sbv.widthDime validMeasure:(selfRect.size.width - padding.left - padding.right) * sbv.widthDime.mutilVal + sbv.widthDime.addVal];
        
        if (sbv.heightDime.dimeRelaVal == self.heightDime && !self.wrapContentHeight)
            rect.size.height = [sbv.heightDime validMeasure:(selfRect.size.height - padding.top - padding.bottom) * sbv.heightDime.mutilVal + sbv.heightDime.addVal];

        
        if (sbv.heightDime.dimeRelaVal == sbv.widthDime)
            rect.size.height = [sbv.heightDime validMeasure:rect.size.width * sbv.heightDime.mutilVal + sbv.heightDime.addVal];
        
        
        //如果高度是浮动的则需要调整高度。
        if (sbv.isFlexedHeight)
        {
            CGSize sz = [sbv sizeThatFits:CGSizeMake(rect.size.width, 0)];
            rect.size.height = [sbv.heightDime validMeasure:sz.height];
        }
        
        //计算xPos的值加上leftMargin + rect.size.width + rightMargin + self.subviewHorzMargin 的值要小于整体的宽度。
        CGFloat place = xPos + leftMargin + rect.size.width + rightMargin;
        if (arrangedIndex != 0)
            place += self.subviewHorzMargin;
        place += padding.right;
        
        //sbv所占据的宽度要超过了视图的整体宽度，因此需要换行。但是如果arrangedIndex为0的话表示这个控件的整行的宽度和布局视图保持一致。
        if (place > selfRect.size.width)
        {
            xPos = padding.left;
            yPos += self.subviewVertMargin;
            yPos += rowMaxHeight;


            //计算每行的gravity情况。
            [self calcVertLayoutGravity:selfRect.size.width rowMaxHeight:rowMaxHeight rowMaxWidth:rowMaxWidth mg:mghorz amg:amgvert sbs:sbs startIndex:i count:arrangedIndex];

            //计算单独的sbv的宽度是否大于整体的宽度。如果大于则缩小宽度。
            if (leftMargin + rightMargin + rect.size.width > selfRect.size.width - padding.left - padding.right)
            {
                rect.size.width = [sbv.widthDime validMeasure:selfRect.size.width - padding.left - padding.right - leftMargin - rightMargin ];
                
                if (sbv.isFlexedHeight)
                {
                    CGSize sz = [sbv sizeThatFits:CGSizeMake(rect.size.width, 0)];
                    rect.size.height = [sbv.heightDime validMeasure:sz.height];
                }
            }
            
            rowMaxHeight = 0;
            rowMaxWidth = 0;
            arrangedIndex = 0;
            
        }
        
        if (arrangedIndex != 0)
            xPos += self.subviewHorzMargin;
        
        
        rect.origin.x = xPos + leftMargin;
        rect.origin.y = yPos + topMargin;
        xPos += leftMargin + rect.size.width + rightMargin;
        
        if (rowMaxHeight < topMargin + bottomMargin + rect.size.height)
            rowMaxHeight = topMargin + bottomMargin + rect.size.height;
        
        if (rowMaxWidth < (xPos - padding.left))
            rowMaxWidth = (xPos - padding.left);

      

        sbv.absPos.frame = rect;
        
        arrangedIndex++;

        

    }
    
    //最后一行
    [self calcVertLayoutGravity:selfRect.size.width rowMaxHeight:rowMaxHeight rowMaxWidth:rowMaxWidth mg:mghorz amg:amgvert sbs:sbs startIndex:i count:arrangedIndex];

    
    if (self.wrapContentHeight)
        selfRect.size.height = yPos + padding.bottom + rowMaxHeight;
    else
    {
        CGFloat addYPos = 0;
        if (mgvert == MyMarginGravity_Vert_Center)
        {
            addYPos = (selfRect.size.height - padding.bottom - rowMaxHeight - yPos) / 2;
        }
        else if (mgvert == MyMarginGravity_Vert_Bottom)
        {
            addYPos = selfRect.size.height - padding.bottom - rowMaxHeight - yPos;
        }
        
        if (addYPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.absPos.topPos += addYPos;
            }
        }
        
    }
    
    
    return selfRect;
    
}


-(CGRect)layoutSubviewsForVert:(CGRect)selfRect
{
    
    NSMutableArray *sbs = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (UIView *sbv in self.subviews)
    {
        if (sbv.useFrame || ( sbv.isHidden && self.hideSubviewReLayout) || sbv.absPos.sizeClass.isHidden)
            continue;
        
        [sbs addObject:sbv];
    }
    
    UIEdgeInsets padding = self.padding;
    NSInteger arrangedCount = self.arrangedCount;
    CGFloat xPos = padding.left;
    CGFloat yPos = padding.top;
    CGFloat rowMaxHeight = 0;  //某一行的最高值。
    CGFloat rowMaxWidth = 0;   //某一行的最宽值
    CGFloat maxWidth = padding.left;  //全部行的最宽值
    MyMarginGravity mgvert = self.gravity & MyMarginGravity_Horz_Mask;
    MyMarginGravity mghorz = self.gravity & MyMarginGravity_Vert_Mask;
    MyMarginGravity amgvert = self.arrangedGravity & MyMarginGravity_Horz_Mask;
    
    CGFloat averageWidth = (selfRect.size.width - padding.left - padding.right - (arrangedCount - 1) * self.subviewHorzMargin) / arrangedCount;
    
    NSInteger arrangedIndex = 0;
    NSInteger i = 0;
    for (; i < sbs.count; i++)
    {
        UIView *sbv = sbs[i];
        
        //新的一行
        if (arrangedIndex >=  arrangedCount)
        {
            arrangedIndex = 0;
            xPos = padding.left;
            yPos += rowMaxHeight;
            yPos += self.subviewVertMargin;
            
            //计算每行的gravity情况。
            [self calcVertLayoutGravity:selfRect.size.width rowMaxHeight:rowMaxHeight rowMaxWidth:rowMaxWidth mg:mghorz amg:amgvert sbs:sbs startIndex:i count:arrangedCount];
            rowMaxHeight = 0;
            rowMaxWidth = 0;
            
        }
        
        CGFloat topMargin = sbv.topPos.margin;
        CGFloat leftMargin = sbv.leftPos.margin;
        CGFloat bottomMargin = sbv.bottomPos.margin;
        CGFloat rightMargin = sbv.rightPos.margin;
        CGRect rect = sbv.absPos.frame;
    
        //控制最大最小尺寸
        rect.size.height = [sbv.heightDime validMeasure:rect.size.height];
        rect.size.width  = [sbv.widthDime validMeasure:rect.size.width];
    
        BOOL isFlexedHeight = sbv.isFlexedHeight && !sbv.heightDime.isMatchParent;
        
        if (self.averageArrange)
            rect.size.width = [sbv.widthDime validMeasure:averageWidth - leftMargin - rightMargin];
        
        if (sbv.widthDime.dimeNumVal != nil && !self.averageArrange)
            rect.size.width = sbv.widthDime.measure;
        
        if (sbv.heightDime.dimeNumVal != nil)
            rect.size.height = sbv.heightDime.measure;
        
        if (sbv.widthDime.dimeRelaVal == self.widthDime && !self.wrapContentWidth)
            rect.size.width = [sbv.widthDime validMeasure:(selfRect.size.width - padding.left - padding.right) * sbv.widthDime.mutilVal + sbv.widthDime.addVal];
        
        if (sbv.heightDime.dimeRelaVal == self.heightDime && !self.wrapContentHeight)
            rect.size.height = [sbv.heightDime validMeasure:(selfRect.size.height - padding.top - padding.bottom) * sbv.heightDime.mutilVal + sbv.heightDime.addVal];

        
        if (sbv.heightDime.dimeRelaVal == sbv.widthDime)
            rect.size.height = [sbv.heightDime validMeasure:rect.size.width * sbv.heightDime.mutilVal + sbv.heightDime.addVal];
        
        //如果高度是浮动的则需要调整高度。
        if (isFlexedHeight)
        {
            CGSize sz = [sbv sizeThatFits:CGSizeMake(rect.size.width, 0)];
            rect.size.height = [sbv.heightDime validMeasure:sz.height];
        }

        
        rect.origin.x = xPos + leftMargin;
        rect.origin.y = yPos + topMargin;
        xPos += leftMargin + rect.size.width + rightMargin;
        
        if (arrangedIndex != (arrangedCount - 1))
            xPos += self.subviewHorzMargin;

        
        if (rowMaxHeight < topMargin + bottomMargin + rect.size.height)
            rowMaxHeight = topMargin + bottomMargin + rect.size.height;
        
        if (rowMaxWidth < (xPos - padding.left))
            rowMaxWidth = (xPos - padding.left);
        
        if (maxWidth < xPos)
            maxWidth = xPos;
        
        
        
        sbv.absPos.frame = rect;
        
        arrangedIndex++;
        
    }
    
    //最后一行
    [self calcVertLayoutGravity:selfRect.size.width rowMaxHeight:rowMaxHeight rowMaxWidth:rowMaxWidth mg:mghorz amg:amgvert sbs:sbs startIndex:i count:arrangedIndex];

    if (self.wrapContentHeight)
        selfRect.size.height = yPos + padding.bottom + rowMaxHeight;
    else
    {
        CGFloat addYPos = 0;
        if (mgvert == MyMarginGravity_Vert_Center)
        {
            addYPos = (selfRect.size.height - padding.bottom - rowMaxHeight - yPos) / 2;
        }
        else if (mgvert == MyMarginGravity_Vert_Bottom)
        {
            addYPos = selfRect.size.height - padding.bottom - rowMaxHeight - yPos;
        }
        
        if (addYPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.absPos.topPos += addYPos;
            }
        }

    }
    
    if (self.wrapContentWidth && !self.averageArrange)
        selfRect.size.width = maxWidth + padding.right;
    
    
    return selfRect;
}



- (void)calcHorzLayoutGravity:(CGFloat)selfHeight colMaxWidth:(CGFloat)colMaxWidth colMaxHeight:(CGFloat)colMaxHeight mg:(MyMarginGravity)mg  amg:(MyMarginGravity)amg sbs:(NSArray *)sbs startIndex:(NSInteger)startIndex count:(NSInteger)count
{
    
    CGFloat addYPos = 0;
    UIEdgeInsets padding = self.padding;
    if (!self.averageArrange)
    {
        switch (mg) {
            case MyMarginGravity_Vert_Center:
            {
                addYPos = (selfHeight - padding.top - padding.bottom - colMaxHeight) / 2;
            }
                break;
            case MyMarginGravity_Vert_Bottom:
            {
                addYPos = selfHeight - padding.top - padding.bottom - colMaxHeight;
            }
                break;
            default:
                break;
        }
    }
    

    
    
    //将整行的位置进行调整。
    for (NSInteger j = startIndex - count; j < startIndex; j++)
    {
        UIView *sbv = sbs[j];
        
        if (self.IntelligentBorderLine != nil)
        {
            if ([sbv isKindOfClass:[MyBaseLayout class]])
            {
                MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
                if (!sbvl.notUseIntelligentBorderLine)
                {
                    sbvl.leftBorderLine = nil;
                    sbvl.topBorderLine = nil;
                    sbvl.rightBorderLine = nil;
                    sbvl.bottomBorderLine = nil;
                    
                    if (j != startIndex - count)
                    {
                        sbvl.topBorderLine = self.IntelligentBorderLine;
                    }
                    
                    if (startIndex - count != 0)
                    {
                        sbvl.leftBorderLine = self.IntelligentBorderLine;
                    }
                    
                    
                }
            }
        }
        
        
        if ((amg != MyMarginGravity_None && amg != MyMarginGravity_Horz_Left) || addYPos != 0)
        {
            sbv.absPos.topPos += addYPos;
            
            switch (amg) {
                case MyMarginGravity_Horz_Center:
                {
                    sbv.absPos.leftPos += (colMaxWidth - sbv.leftPos.margin - sbv.rightPos.margin - sbv.absPos.width) / 2;
                    
                }
                    break;
                case MyMarginGravity_Horz_Right:
                {
                    sbv.absPos.leftPos += colMaxWidth - sbv.leftPos.margin - sbv.rightPos.margin - sbv.absPos.width;
                }
                    break;
                case MyMarginGravity_Horz_Fill:
                {
                    sbv.absPos.width = [sbv.widthDime validMeasure:colMaxWidth - sbv.leftPos.margin - sbv.rightPos.margin];
                }
                    break;
                default:
                    break;
            }
        }
    }
}


-(CGRect)layoutSubviewsForHorzFloat:(CGRect)selfRect
{
    NSMutableArray *sbs = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (UIView *sbv in self.subviews)
    {
        if (sbv.useFrame || ( sbv.isHidden && self.hideSubviewReLayout) || sbv.absPos.sizeClass.isHidden)
            continue;
        
        [sbs addObject:sbv];
    }
    
    UIEdgeInsets padding = self.padding;
    CGFloat xPos = padding.left;
    CGFloat yPos = padding.top;
    CGFloat colMaxWidth = 0;  //某一列的最宽值。
    CGFloat colMaxHeight = 0;   //某一列的最高值
    
    MyMarginGravity mgvert = self.gravity & MyMarginGravity_Horz_Mask;
    MyMarginGravity mghorz = self.gravity & MyMarginGravity_Vert_Mask;
    MyMarginGravity amghorz = self.arrangedGravity & MyMarginGravity_Vert_Mask;
    
    NSInteger arrangedIndex = 0;
    NSInteger i = 0;
    for (; i < sbs.count; i++)
    {
        UIView *sbv = sbs[i];
        
        CGFloat topMargin = sbv.topPos.margin;
        CGFloat leftMargin = sbv.leftPos.margin;
        CGFloat bottomMargin = sbv.bottomPos.margin;
        CGFloat rightMargin = sbv.rightPos.margin;
        CGRect rect = sbv.absPos.frame;
        
        //控制最大最小尺寸
        rect.size.height = [sbv.heightDime validMeasure:rect.size.height];
        rect.size.width  = [sbv.widthDime validMeasure:rect.size.width];
        
        if (sbv.widthDime.dimeNumVal != nil)
            rect.size.width = sbv.widthDime.measure;
        
        if (sbv.heightDime.dimeNumVal != nil)
            rect.size.height = sbv.heightDime.measure;
        
        if (sbv.widthDime.dimeRelaVal == self.widthDime && !self.wrapContentWidth)
            rect.size.width = [sbv.widthDime validMeasure:(selfRect.size.width - padding.left - padding.right) * sbv.widthDime.mutilVal + sbv.widthDime.addVal];
        
        if (sbv.heightDime.dimeRelaVal == self.heightDime && !self.wrapContentHeight)
            rect.size.height = [sbv.heightDime validMeasure:(selfRect.size.height - padding.top - padding.bottom) * sbv.heightDime.mutilVal + sbv.heightDime.addVal];
       
        if (sbv.widthDime.dimeRelaVal == sbv.heightDime)
            rect.size.width = [sbv.widthDime validMeasure:rect.size.height * sbv.widthDime.mutilVal + sbv.widthDime.addVal];
        
        //如果高度是浮动的则需要调整高度。
        if (sbv.isFlexedHeight)
        {
            CGSize sz = [sbv sizeThatFits:CGSizeMake(rect.size.width, 0)];
            rect.size.height = [sbv.heightDime validMeasure:sz.height];
        }
        
        //计算yPos的值加上topMargin + rect.size.height + bottomMargin + self.subviewVertMargin 的值要小于整体的宽度。
        CGFloat place = yPos + topMargin + rect.size.height + bottomMargin;
        if (arrangedIndex != 0)
            place += self.subviewVertMargin;
        place += padding.bottom;
        
        //sbv所占据的宽度要超过了视图的整体宽度，因此需要换行。但是如果arrangedIndex为0的话表示这个控件的整行的宽度和布局视图保持一致。
        if (place > selfRect.size.height)
        {
            yPos = padding.top;
            xPos += self.subviewHorzMargin;
            xPos += colMaxWidth;
            
            
            //计算每行的gravity情况。
            [self calcHorzLayoutGravity:selfRect.size.height colMaxWidth:colMaxWidth colMaxHeight:colMaxHeight mg:mgvert amg:amghorz sbs:sbs startIndex:i count:arrangedIndex];
            
            //计算单独的sbv的高度是否大于整体的高度。如果大于则缩小高度。
            if (topMargin + bottomMargin + rect.size.height > selfRect.size.height - padding.top - padding.bottom)
            {
                rect.size.height = [sbv.heightDime validMeasure:selfRect.size.height - padding.top - padding.bottom - topMargin - bottomMargin ];
            }
            
            colMaxWidth = 0;
            colMaxHeight = 0;
            arrangedIndex = 0;
            
        }
        
        if (arrangedIndex != 0)
            yPos += self.subviewVertMargin;
        
        
        rect.origin.x = xPos + leftMargin;
        rect.origin.y = yPos + topMargin;
        yPos += topMargin + rect.size.height + bottomMargin;
        
        if (colMaxWidth < leftMargin + rightMargin + rect.size.width)
            colMaxWidth = leftMargin + rightMargin + rect.size.width;
        
        if (colMaxHeight < (yPos - padding.top))
            colMaxHeight = (yPos - padding.top);
        
        
        
        sbv.absPos.frame = rect;
        
        arrangedIndex++;
        
        
        
    }
    
    //最后一行
    [self calcHorzLayoutGravity:selfRect.size.height colMaxWidth:colMaxWidth colMaxHeight:colMaxHeight mg:mgvert amg:amghorz sbs:sbs startIndex:i count:arrangedIndex];
    
    
    if (self.wrapContentWidth)
        selfRect.size.width = xPos + padding.right + colMaxWidth;
    else
    {
        CGFloat addXPos = 0;
        if (mghorz == MyMarginGravity_Horz_Center)
        {
            addXPos = (selfRect.size.width - padding.right - colMaxWidth - xPos) / 2;
        }
        else if (mghorz == MyMarginGravity_Horz_Right)
        {
            addXPos = selfRect.size.width - padding.right - colMaxWidth - xPos;
        }
        
        if (addXPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.absPos.leftPos += addXPos;
            }
        }
        
    }
    
    
    return selfRect;
}



-(CGRect)layoutSubviewsForHorz:(CGRect)selfRect
{
    
    NSMutableArray *sbs = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for (UIView *sbv in self.subviews)
    {
        if (sbv.useFrame || (sbv.isHidden && self.hideSubviewReLayout) || sbv.absPos.sizeClass.isHidden)
            continue;
        
        [sbs addObject:sbv];
    }
    
    UIEdgeInsets padding = self.padding;
    
    NSInteger arrangedIndex = 0;
    NSInteger arrangedCount = self.arrangedCount;
    CGFloat xPos = padding.left;
    CGFloat yPos = padding.top;
    CGFloat colMaxWidth = 0;  //每列的最大宽度
    CGFloat colMaxHeight = 0; //每列的最大高度
    CGFloat maxHeight = padding.top;
    
    MyMarginGravity mgvert = self.gravity & MyMarginGravity_Horz_Mask;
    MyMarginGravity mghorz = self.gravity & MyMarginGravity_Vert_Mask;
    MyMarginGravity amghorz = self.arrangedGravity & MyMarginGravity_Vert_Mask;

    
    CGFloat averageHeight = (selfRect.size.height - padding.top - padding.bottom - (arrangedCount - 1) * self.subviewVertMargin) / arrangedCount;
    
    int i = 0;
    for (; i < sbs.count; i++)
    {
        UIView *sbv = sbs[i];
        
        if (arrangedIndex >=  arrangedCount)
        {
            arrangedIndex = 0;
            xPos += colMaxWidth;
            xPos += self.subviewHorzMargin;
            yPos = padding.top;
            
            //计算每行的gravity情况。
            [self calcHorzLayoutGravity:selfRect.size.height colMaxWidth:colMaxWidth colMaxHeight:colMaxHeight mg:mgvert amg:amghorz sbs:sbs startIndex:i count:arrangedCount];
            
            colMaxWidth = 0;
            colMaxHeight = 0;
        }
        
        CGFloat topMargin = sbv.topPos.margin;
        CGFloat leftMargin = sbv.leftPos.margin;
        CGFloat bottomMargin = sbv.bottomPos.margin;
        CGFloat rightMargin = sbv.rightPos.margin;
        CGRect rect = sbv.absPos.frame;
        
        //控制最大最小尺寸
        rect.size.height = [sbv.heightDime validMeasure:rect.size.height];
        rect.size.width  = [sbv.widthDime validMeasure:rect.size.width];

        
        BOOL isFlexedHeight = sbv.isFlexedHeight && !sbv.heightDime.isMatchParent;
        
        if (sbv.widthDime.dimeNumVal != nil)
            rect.size.width = sbv.widthDime.measure;
        
        if (sbv.heightDime.dimeNumVal != nil && !self.averageArrange)
            rect.size.height = sbv.heightDime.measure;
        
        if (sbv.widthDime.dimeRelaVal == self.widthDime && !self.wrapContentWidth)
            rect.size.width = [sbv.widthDime validMeasure:(selfRect.size.width - padding.left - padding.right) * sbv.widthDime.mutilVal + sbv.widthDime.addVal];
        
        if (sbv.heightDime.dimeRelaVal == self.heightDime && !self.wrapContentHeight)
            rect.size.height = [sbv.heightDime validMeasure:(selfRect.size.height - padding.top - padding.bottom) * sbv.heightDime.mutilVal + sbv.heightDime.addVal];
        
        //如果高度是浮动的则需要调整高度。
        if (isFlexedHeight)
        {
            CGSize sz = [sbv sizeThatFits:CGSizeMake(rect.size.width, 0)];
            rect.size.height = [sbv.heightDime validMeasure:sz.height];
        }
        
        if (self.averageArrange)
            rect.size.height = [sbv.heightDime validMeasure:averageHeight - topMargin - bottomMargin];
        
        if (sbv.widthDime.dimeRelaVal == sbv.heightDime)
            rect.size.width = [sbv.widthDime validMeasure:rect.size.height * sbv.widthDime.mutilVal + sbv.widthDime.addVal];

        
        rect.origin.y = yPos + topMargin;
        rect.origin.x = xPos + leftMargin;
        yPos += topMargin + rect.size.height + bottomMargin;
        
        if (arrangedIndex != (arrangedCount - 1))
            yPos += self.subviewVertMargin;

        
        if (colMaxWidth < leftMargin + rightMargin + rect.size.width)
            colMaxWidth = leftMargin + rightMargin + rect.size.width;
        
        if (colMaxHeight < (yPos - padding.top))
            colMaxHeight = yPos - padding.top;
        
        if (maxHeight < yPos)
            maxHeight = yPos;
        
        
        sbv.absPos.frame = rect;
        
        
        arrangedIndex++;
        
    }
    
    //最后一列
    [self calcHorzLayoutGravity:selfRect.size.height colMaxWidth:colMaxWidth colMaxHeight:colMaxHeight mg:mgvert amg:amghorz sbs:sbs startIndex:i count:arrangedIndex];

    if (self.wrapContentHeight && !self.averageArrange)
        selfRect.size.height = maxHeight + padding.bottom;
    
    if (self.wrapContentWidth)
        selfRect.size.width = xPos + padding.right + colMaxWidth;
    else
    {
     
        CGFloat addXPos = 0;
        if (mghorz == MyMarginGravity_Horz_Center)
        {
            addXPos = (selfRect.size.width - padding.right - colMaxWidth - xPos) / 2;
        }
        else if (mghorz == MyMarginGravity_Horz_Right)
        {
            addXPos = selfRect.size.width - padding.right - colMaxWidth - xPos;
        }
        
        if (addXPos != 0)
        {
            for (int i = 0; i < sbs.count; i++)
            {
                UIView *sbv = sbs[i];
                
                sbv.absPos.leftPos += addXPos;
            }
        }
    }
    
    
    
    
    return selfRect;
    
}

-(CGRect)calcLayoutRect:(CGSize)size isEstimate:(BOOL)isEstimate pHasSubLayout:(BOOL*)pHasSubLayout sizeClass:(MySizeClass)sizeClass
{
    CGRect selfRect = [super calcLayoutRect:size isEstimate:isEstimate pHasSubLayout:pHasSubLayout sizeClass:sizeClass];
    
    for (UIView *sbv in self.subviews)
    {
        if (sbv.useFrame || (sbv.isHidden && self.hideSubviewReLayout) || sbv.absPos.sizeClass.isHidden)
            continue;
        
        if (!isEstimate)
        {
            sbv.absPos.frame = sbv.frame;
        }
        
        if ([sbv isKindOfClass:[MyBaseLayout class]])
        {
            if (pHasSubLayout != NULL)
                *pHasSubLayout = YES;
            
            //流式布局因为左右边距和自身的宽高没有限制所以这里不需要进行wrapContent的约束控制。
            MyBaseLayout *sbvl = (MyBaseLayout*)sbv;
            if (isEstimate)
            {
                [sbvl estimateLayoutRect:sbvl.absPos.frame.size inSizeClass:sizeClass];
                sbvl.absPos.sizeClass = [sbvl myBestSizeClass:sizeClass]; //因为estimateLayoutRect执行后会还原，所以这里要重新设置
            }
        }
    }

    
    
    if (self.orientation == MyLayoutViewOrientation_Vert)
    {
        if (self.arrangedCount == 0)
            selfRect = [self layoutSubviewsForVertFloat:selfRect];
        else
            selfRect = [self layoutSubviewsForVert:selfRect];
    }
    else
    {
        if (self.arrangedCount == 0)
            selfRect = [self layoutSubviewsForHorzFloat:selfRect];
        else
            selfRect = [self layoutSubviewsForHorz:selfRect];
    }
    
    selfRect.size.height = [self.heightDime validMeasure:selfRect.size.height];
    selfRect.size.width = [self.widthDime validMeasure:selfRect.size.width];
    
    
    return selfRect;
}

-(id)createSizeClassInstance
{
    return [MyLayoutSizeClassFlowLayout new];
}



@end
