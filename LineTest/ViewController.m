//
//  ViewController.m
//  LineTest
//
//  Created by luph on 15/8/7.
//  Copyright (c) 2015年 luph. All rights reserved.
//

#import "ViewController.h"

#import "BFLineChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    BFLineChart *lineChart=[[BFLineChart alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width-10*2, 135)];
    lineChart.yTitleList=@[@"优",@"良",@"中"];
    lineChart.yValueList=@[@85,@70,@60];
    [self.view addSubview:lineChart];
    [lineChart loadChart];
   
    
    lineChart.xTitleList=@[@"3/22",@"3/23",@"3/24",@"3/25",@"3/26",@"3/27",@"3/28"];
    lineChart.xValueList=@[@40,@100,@70,@65,@80,@40,@67];

    
    [lineChart loadChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
