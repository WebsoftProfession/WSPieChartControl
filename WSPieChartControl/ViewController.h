//
//  ViewController.h
//  WSPieChartControl
//
//  Created by Dotsquares on 3/29/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPieChartView.h"

@interface ViewController : UIViewController<WSPieChartViewDelegate>
@property (weak, nonatomic) IBOutlet WSPieChartView *chartView;


@end

