//
//  WSPieChartView.m
//  WSPieChartControl
//
//  Created by Dotsquares on 3/29/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "WSPieChartView.h"

@implementation WSPieChartView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath *outerCirclePath=[UIBezierPath bezierPath];
    CGPoint centerPoint=CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radious=rect.size.width/2-4;
    [outerCirclePath addArcWithCenter:centerPoint radius:radious startAngle:0 endAngle:2*M_PI clockwise:YES];
    [[UIColor grayColor] setStroke];
    [outerCirclePath setLineWidth:2.0];
    [outerCirclePath stroke];
    
    NSInteger numberOfPath=[self.delegate numberOfDataInChart];
    CGFloat startData=0;
    CGFloat endData=0;
    for (int i=0; i<numberOfPath; i++) {
        
        if (i==0) {
            startData=0;
        }
        else{
            startData+=[self.delegate valueForDataInChartForIndex:i-1];
        }
        endData=[self.delegate valueForDataInChartForIndex:i];
        endData+=startData;
        
        CGPoint midPointArch=[self getMidPointOfArcWithStartValue:startData andEndValue:endData andCenterPoint:centerPoint andRadious:radious];
        
        UIBezierPath *dataPath=[UIBezierPath bezierPath];
        [dataPath addArcWithCenter:centerPoint radius:radious startAngle:[self calculateRadiousWithValue:startData] endAngle:[self calculateRadiousWithValue:endData] clockwise:YES];
        
        CGPoint startPoint;
        CGPoint endPoint;
        if ([self.delegate respondsToSelector:@selector(colorForDataInChartForIndex:)]) {
            [[self.delegate colorForDataInChartForIndex:i] setFill];
        }
        else{
            [[UIColor whiteColor] setFill];
        }
        
        [dataPath setLineWidth:1.0];
        endPoint=CGPathGetCurrentPoint(dataPath.CGPath);
        [dataPath addLineToPoint:centerPoint];
        [dataPath closePath];
        [dataPath fill];
        startPoint=CGPathGetCurrentPoint(dataPath.CGPath);
        
        
        CGContextSaveGState(UIGraphicsGetCurrentContext()); {
            if ([self.delegate respondsToSelector:@selector(dataImageForDataInChartForIndex:)]) {
                [dataPath addClip];
                [[self.delegate dataImageForDataInChartForIndex:i] drawInRect:dataPath.bounds];
            }

        } CGContextRestoreGState(UIGraphicsGetCurrentContext());
        
        
        CGPoint midPoint=CGPointMake((centerPoint.x+midPointArch.x)/2, (centerPoint.y+midPointArch.y)/2);
        
        
        UIBezierPath *titleViewPath=[UIBezierPath bezierPath];
        if ([self.delegate respondsToSelector:@selector(titleViewRadiousForDataInChartForIndex:)]) {
            [titleViewPath addArcWithCenter:midPoint radius:[self.delegate titleViewRadiousForDataInChartForIndex:i] startAngle:0 endAngle:M_PI*2 clockwise:YES];
        }
        else{
            [titleViewPath addArcWithCenter:midPoint radius:15 startAngle:0 endAngle:M_PI*2 clockwise:YES];
        }
        
        [titleViewPath setLineWidth:2.0];
        if ([self.delegate respondsToSelector:@selector(colorForTitleViewInChartForIndex:)]) {
            [[self.delegate colorForTitleViewInChartForIndex:i] setFill];
        }
        else{
            [[UIColor orangeColor] setFill];
        }
        
        [titleViewPath fill];
        
        CGContextSaveGState(UIGraphicsGetCurrentContext()); {
            
            if ([self.delegate respondsToSelector:@selector(titleImageForDataInChartForIndex:)]) {
                [titleViewPath addClip];
                [[self.delegate titleImageForDataInChartForIndex:i] drawInRect:titleViewPath.bounds];
            }
            
        } CGContextRestoreGState(UIGraphicsGetCurrentContext());
        
        NSString *valueString;
        if ([self.delegate respondsToSelector:@selector(titleForDataInChartForIndex:)]) {
            valueString=[NSString stringWithFormat:@"%@%%",[self.delegate titleForDataInChartForIndex:i]];
        }
        else{
            valueString=@"";
        }
        
        [self drawString:valueString withFont:[UIFont fontWithName:@"Arial" size:8.0] inRect:titleViewPath.bounds inIndex:i];
}
}

- (void) drawString: (NSString*) s
           withFont: (UIFont*) font
             inRect: (CGRect) contextRect inIndex:(int)index {
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes;
    if ([self.delegate respondsToSelector:@selector(titleAttributesForDataInChartForIndex:)]) {
        attributes = [self.delegate titleAttributesForDataInChartForIndex:index];
    }
    else{
        attributes = @{ NSFontAttributeName: font,
                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSParagraphStyleAttributeName: paragraphStyle };
    }
    
    
    CGSize size = [s sizeWithAttributes:attributes];
    
    CGRect textRect = CGRectMake(contextRect.origin.x + floorf((contextRect.size.width - size.width) / 2),
                                 contextRect.origin.y + floorf((contextRect.size.height - size.height) / 2),
                                 size.width,
                                 size.height);
    
    [s drawInRect:textRect withAttributes:attributes];
}

-(CGPoint)getMidPointOfArcWithStartValue:(float)startValue andEndValue:(float)endValue andCenterPoint:(CGPoint)centerPoint andRadious:(CGFloat)radious{
    
    UIBezierPath *new=[UIBezierPath bezierPath];
    
    
    float midValue=fabsf((endValue-startValue)/2)+startValue;
    
    
    [new addArcWithCenter:centerPoint radius:radious startAngle:[self calculateRadiousWithValue:startValue] endAngle:[self calculateRadiousWithValue:midValue] clockwise:YES];
    CGPoint endPoint=CGPointZero;
    
    endPoint=CGPathGetCurrentPoint(new.CGPath);
    return endPoint;
}

-(CGFloat)calculateRadiousWithValue:(CGFloat)value{
    CGFloat pieValue=M_PI;
    CGFloat redious=(value*2*pieValue)/100;
    return redious;
}


@end
