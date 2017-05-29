//
//  ViewController.m
//  WSPieChartControl
//
//  Created by Dotsquares on 3/29/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *chartData;
    NSMutableArray *chartTitleArray;
    NSMutableArray *chartColorArray;
    NSMutableArray *chartImageArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    chartData=[[NSMutableArray alloc] initWithObjects:@"10",@"25",@"35",@"10",@"20", nil];
    chartTitleArray=[[NSMutableArray alloc] initWithObjects:@"Car",@"Bike",@"Truck",@"Train",@"Plane", nil];
    chartColorArray=[[NSMutableArray alloc] initWithObjects:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.3],[UIColor greenColor],[UIColor yellowColor],[UIColor blueColor],[UIColor purpleColor], nil];
    chartImageArray=[[NSMutableArray alloc] initWithObjects:@"car.jpg",@"bike.jpg",@"truck.jpg",@"train.jpg",@"plane.jpg", nil];
    _chartView.delegate=self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma WSPieChartViewDelegate Methods

-(NSInteger)numberOfDataInChart{
    return chartData.count;
}

-(CGFloat)valueForDataInChartForIndex:(int)index{
    return [[chartData objectAtIndex:index] floatValue];
}

-(UIColor *)colorForDataInChartForIndex:(int)index{
    return [chartColorArray objectAtIndex:index];
}

-(UIColor *)colorForTitleViewInChartForIndex:(int)index{
    return [UIColor cyanColor];
}

-(NSString *)titleForDataInChartForIndex:(int)index{
    return [NSString stringWithFormat:@"%@ \r %@",[chartTitleArray objectAtIndex:index],[chartData objectAtIndex:index]];
}

//-(UIImage *)dataImageForDataInChartForIndex:(int)index{
//    return [UIImage imageNamed:[chartImageArray objectAtIndex:index]];
//}

//-(NSDictionary *)titleAttributesForDataInChartForIndex:(int)index{
//    return @{ NSFontAttributeName: [UIFont fontWithName:@"Arial" size:10.0],
//              NSForegroundColorAttributeName: [UIColor blackColor]};
//}

-(UIImage *)titleImageForDataInChartForIndex:(int)index{
    return [UIImage imageNamed:[chartImageArray objectAtIndex:index]];
}

//-(CGFloat)titleViewRadiousForDataInChartForIndex:(int)index{
//    return 20;
//}


@end
