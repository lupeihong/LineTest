//
//  BFLineChart.m
//  SpeakingYzt
//
//  Created by luph on 15/8/10.
//  Copyright (c) 2015年 luph. All rights reserved.
//

#import "BFLineChart.h"

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//释放对象的宏定义
#define BRELEASE(obj){}        if(obj)[obj release];obj=nil;

@implementation BFLineChart


@synthesize maxY;
@synthesize xyLineWith;
@synthesize lineWith;

@synthesize labelColor;
@synthesize lineColor;
@synthesize polylineColor;
@synthesize backgroundLineColor;

@synthesize xTitleList;
@synthesize xValueList;
@synthesize yTitleList;
@synthesize yValueList;

- (void)dealloc{
    
    self.labelColor=nil;
    self.lineColor=nil;
    self.polylineColor=nil;
    self.backgroundLineColor=nil;
    
    self.xTitleList=nil;
    self.xValueList=nil;
    self.yTitleList=nil;
    self.yValueList=nil;
    
    BRELEASE(xLabelList);
    BRELEASE(chartView);
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        xLableHeight=30;
        
        self.maxY=100.0f;
        self.xyLineWith=0.5f;
        self.lineWith=1.0f;
        
        self.labelColor=Color(51, 51, 51, 1);
        self.lineColor=Color(235, 235, 235, 1);
        self.polylineColor=Color(203, 204, 20, 1);
        self.backgroundLineColor=Color(203, 204, 20, 0.1);
        
        self.xTitleList=@[];
        self.xValueList=@[];
        self.yTitleList=@[];
        self.yValueList=@[];
        
        chartView=[[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:chartView];
        
    }
    return self;
}



- (void)loadChart{
    
    [chartView removeFromSuperview];
    BRELEASE(chartView);
    chartView=[[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:chartView];
    BRELEASE(xLabelList);
    
    if (self.xTitleList.count>0 && self.xTitleList!=nil) {
        //绘制xy轴
        [self drawXYLine];
        
        
        //添加y轴 标签
        [self drawYLabel];
        
        
        //添加X轴 标签
        [self drawXLabel];
        
        
        
        //绘制折线
        [self drawPolyline];
        
        
        //绘制折线背景
        [self drawBackgroud];
    }else{
        //没数据的情况
        
        xLableWidth=self.frame.size.width/7;
        
        [self drawLineWithStart:CGPointMake(0, self.frame.size.height-xLableHeight) end:CGPointMake(self.frame.size.width, self.frame.size.height-xLableHeight)];
        [self drawLineWithStart:CGPointMake(xLableWidth*0.5, 0) end:CGPointMake(xLableWidth*0.5, self.frame.size.height-xLableHeight)];
        
        //添加y轴 标签
        [self drawYLabel];
        
    }
    
    
    
    
}


//绘制xy轴
- (void)drawXYLine{
    xLableWidth=self.frame.size.width/xTitleList.count;
    
    
    [self drawLineWithStart:CGPointMake(0, self.frame.size.height-xLableHeight) end:CGPointMake(self.frame.size.width, self.frame.size.height-xLableHeight)];
    [self drawLineWithStart:CGPointMake(xLableWidth*0.5, 0) end:CGPointMake(xLableWidth*0.5, self.frame.size.height-xLableHeight)];
}

//绘制Y轴标签
- (void)drawYLabel{
    for (NSInteger i=0;i<yTitleList.count;i++) {
        NSString *yText=yTitleList[i];
        CGFloat lableValue=[yValueList[i] floatValue];
        
        CGFloat lableY=(maxY-lableValue)/maxY*(self.frame.size.height-xLableHeight);
        
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, xLableWidth, xLableHeight)];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=labelColor;
        titleLabel.font=[UIFont systemFontOfSize:12];
        titleLabel.text=yText;
        [titleLabel sizeToFit];
        titleLabel.center=CGPointMake(xLableWidth*0.5-titleLabel.frame.size.width*0.5-8, lableY);
        [chartView addSubview:titleLabel];
        [titleLabel release];
        
        [self drawDashLineWithStart:CGPointMake(xLableWidth*0.5, lableY) end:CGPointMake(self.frame.size.width-xLableWidth*0.5, lableY)];
    }
}

//绘制X轴标签
- (void)drawXLabel{
    xLabelList=[NSMutableArray new];
    for (NSInteger i=0;i<xTitleList.count;i++) {
        NSString *xText=xTitleList[i];
        
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(xLableWidth*i, self.frame.size.height-xLableHeight, xLableWidth, xLableHeight)];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor=labelColor;
        titleLabel.font=[UIFont systemFontOfSize:11];
        titleLabel.text=xText;
        titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [chartView addSubview:titleLabel];
        
        [xLabelList addObject:titleLabel];
        
        [titleLabel release];
        
    }
}


//绘制折线
- (void)drawPolyline{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    
    for (NSInteger i=0;i<xValueList.count;i++) {
        
        CGFloat yValue=[xValueList[i] floatValue];
        
        CGFloat pointY=(maxY-yValue)/maxY*(self.frame.size.height-xLableHeight);
        
        UILabel *xlable=xLabelList[i];
        CGFloat pointX=xlable.center.x;
        
        if (i==0) {
            [aPath moveToPoint:CGPointMake(pointX, pointY)];
            
        }else{
            [aPath addLineToPoint:CGPointMake(pointX, pointY)];
        }
        
        UIImageView *pointIcon=[[UIImageView alloc] initWithFrame:CGRectMake(pointX-9*0.5, pointY-9*0.5, 9, 9)];
        pointIcon.image=[UIImage imageNamed:@"results_tips"];
        [chartView addSubview:pointIcon];
        [pointIcon release];
        //        [aPath addArcWithCenter:CGPointMake(pointX, pointY) radius:3 startAngle:0 endAngle:2 * M_PI clockwise:YES];
        
    }
    
    
    //    [aPath closePath];//第五条线通过调用closePath方法得到的
    
    //    [aPath stroke];//Draws line 根据坐标点连线
    
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.lineWidth     = lineWith;// 线条宽度
    layer.strokeColor   = polylineColor.CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapRound;               // 边缘线的类型
    layer.path          = aPath.CGPath;                 // 从贝塞尔曲线获取到形状
    //    layer.strokeStart   = 0.0f;
    //    layer.strokeEnd     = 1;
    
    //    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //    pathAnimation.fromValue = (id)layer.path;
    //    pathAnimation.toValue = (id)[aPath CGPath];
    //    pathAnimation.duration = 30.0;
    //    pathAnimation.autoreverses = NO;
    //    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    [layer addAnimation:pathAnimation forKey:@"animationKey"];
    
    [chartView.layer addSublayer:layer];
}



//绘制折线图背景
- (void)drawBackgroud{
    UIBezierPath* bgPath = [UIBezierPath bezierPath];
    bgPath.lineCapStyle = kCGLineCapRound; //线条拐角
    bgPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    CGFloat pointX0=0;
    
    for (NSInteger i=0;i<xValueList.count;i++) {
        
        CGFloat yValue=[xValueList[i] floatValue];
        
        CGFloat pointY=(maxY-yValue)/maxY*(self.frame.size.height-xLableHeight);
        
        UILabel *xlable=xLabelList[i];
        CGFloat pointX=xlable.center.x;
        
        
        if (i==0) {
            pointX0=pointX;
            [bgPath moveToPoint:CGPointMake(pointX, pointY)];
            
        }else{
            [bgPath addLineToPoint:CGPointMake(pointX, pointY)];
        }
        
        if (i==xValueList.count-1) {
            
            [bgPath addLineToPoint:CGPointMake(pointX, self.frame.size.height-xLableHeight)];
            [bgPath addLineToPoint:CGPointMake(pointX0, self.frame.size.height-xLableHeight)];
        }
        
    }
    
    
    [bgPath closePath];//第五条线通过调用closePath方法得到的
    
    //    [aPath stroke];//Draws line 根据坐标点连线
    
    CAShapeLayer *bgLayer =[CAShapeLayer layer];
    bgLayer.frame = self.bounds;
    bgLayer.lineWidth     = 0;// 线条宽度
    bgLayer.strokeColor   = [UIColor clearColor].CGColor;   // 边缘线的颜色
    bgLayer.fillColor     = backgroundLineColor.CGColor;   // 闭环填充的颜色
    bgLayer.lineCap       = kCALineCapRound;               // 边缘线的类型
    bgLayer.path          = bgPath.CGPath;                 // 从贝塞尔曲线获取到形状
    //    layer.strokeStart   = 0.0f;
    //    layer.strokeEnd     = 1;
    
    //    CABasicAnimation * pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //    pathAnimation.fromValue = (id)layer.path;
    //    pathAnimation.toValue = (id)[aPath CGPath];
    //    pathAnimation.duration = 30.0;
    //    pathAnimation.autoreverses = NO;
    //    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    [layer addAnimation:pathAnimation forKey:@"animationKey"];
    
    [chartView.layer addSublayer:bgLayer];
}




//画实线
- (void)drawLineWithStart:(CGPoint)start end:(CGPoint)end{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    // Set the starting point of the shape.
    [aPath moveToPoint:start];
    [aPath addLineToPoint:end];
    
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.lineWidth     = xyLineWith;// 线条宽度
    layer.strokeColor   = lineColor.CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapRound;               // 边缘线的类型
    layer.path          = aPath.CGPath;
    
    [chartView.layer addSublayer:layer];
}

//画虚线
- (void)drawDashLineWithStart:(CGPoint)start end:(CGPoint)end{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    // Set the starting point of the shape.
    [aPath moveToPoint:start];
    [aPath addLineToPoint:end];
    
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.lineWidth     = xyLineWith;// 线条宽度
    layer.strokeColor   = lineColor.CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapRound;               // 边缘线的类型
    layer.path          = aPath.CGPath;
    [layer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:4],
                               [NSNumber numberWithInt:2],nil]];
    
    [chartView.layer addSublayer:layer];
}

@end
