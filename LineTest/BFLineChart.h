/*==========================================================================
 *
 * File Name: BFLineChart.h
 *      Desc: 折线图
 *      Auth: luph
 *      Date: 2015/08/11
 *      Modi: 2015/08/11
 *
 *==========================================================================*/

#import <UIKit/UIKit.h>

@interface BFLineChart : UIView
{
    
    CGFloat maxY; //Y轴最大值
    CGFloat xyLineWith;//xy轴线粗
    CGFloat lineWith; //折线粗
    UIColor *labelColor;//标签颜色
    UIColor *lineColor;//轴颜色
    UIColor *polylineColor;//折线颜色
    UIColor *backgroundLineColor;//背景颜色
    
    CGFloat xLableHeight; //x轴标签高度
    CGFloat xLableWidth;//x轴标签宽度
    
    NSArray *xTitleList; //x轴标题
    NSArray *xValueList; //x轴值
    
    NSArray *yTitleList; //y轴标题
    NSArray *yValueList; //y轴值
    
    
    NSMutableArray *xLabelList;//存放X轴标签
    UIView *chartView; //内容
    
}

@property (nonatomic,assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat xyLineWith;
@property (nonatomic,assign) CGFloat lineWith;
@property (nonatomic,retain) UIColor *labelColor;//标签颜色
@property (nonatomic,retain) UIColor *lineColor;//标签颜色
@property (nonatomic,retain) UIColor *polylineColor;//折线颜色
@property (nonatomic,retain) UIColor *backgroundLineColor;//折线区背景颜色

@property (nonatomic,retain) NSArray *xTitleList; //x轴标题
@property (nonatomic,retain) NSArray *xValueList; //x轴值
@property (nonatomic,retain) NSArray *yTitleList; //y轴标题
@property (nonatomic,retain) NSArray *yValueList; //y轴值


- (void)loadChart;

@end
