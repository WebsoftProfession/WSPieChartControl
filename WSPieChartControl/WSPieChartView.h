//
//  WSPieChartView.h
//  WSPieChartControl
//
//  Created by Dotsquares on 3/29/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WSPieChartViewDelegate <NSObject>

-(NSInteger)numberOfDataInChart;
-(CGFloat)valueForDataInChartForIndex:(int)index;
-(UIColor *)colorForDataInChartForIndex:(int)index;
-(UIColor *)colorForTitleViewInChartForIndex:(int)index;
-(NSString *)titleForDataInChartForIndex:(int)index;
-(UIImage *)dataImageForDataInChartForIndex:(int)index;
-(UIImage *)titleImageForDataInChartForIndex:(int)index;
-(NSDictionary *)titleAttributesForDataInChartForIndex:(int)index;
-(CGFloat)titleViewRadiousForDataInChartForIndex:(int)index;

@end

@interface WSPieChartView : UIView
@property (nonatomic,strong) id<WSPieChartViewDelegate> delegate;
@property (nonatomic,strong) UIColor *titleColor;
@end
