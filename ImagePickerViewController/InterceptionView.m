//
//  InterceptionView.m
//  ImagePickerViewController
//
//  Created by 魏琦 on 16/8/8.
//  Copyright © 2016年 com.drcacom.com. All rights reserved.
//

#import "InterceptionView.h"
#import "WQmacro.h"
@interface InterceptionView ()
@property (nonatomic, strong) CAShapeLayer* shapeLayer;
@property(nonatomic,assign)CGPoint cuttentPoint;
@end

@implementation InterceptionView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIPinchGestureRecognizer * gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImage:)];
        
        // 为imageView添加手势处理器
        
        [self addGestureRecognizer:gesture];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}

/**捏合手势*/
-(void)scaleImage:(UIPinchGestureRecognizer *)pin
{
    
    //    CGFloat scale;
    switch (pin.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat scale = pin.scale;
            self.myBlockScale(scale);
            pin.scale = 1.0;//每次回到初始值
        }
            break;
            
        default:
            break;
    }
}
//  移动手势
-(void)pan:(UIPanGestureRecognizer *)pan
{
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.cuttentPoint = [pan locationInView:self];
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [pan locationInView:self];
            
            self.myBlockPan(changePoint.x-self.cuttentPoint.x,changePoint.y-self.cuttentPoint.y);
            
            self.cuttentPoint = changePoint;// 每次回到初始值
        }
            break;
            
            
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);
    CGContextSetLineWidth(contextRef, 3);
    UIBezierPath *pickingFieldPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y-((SCREEEN_WIDTH-200)/2)) radius:SCREEEN_WIDTH-250 startAngle:0 endAngle:2*M_PI clockwise:YES];
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    [bezierPathRect appendPath:pickingFieldPath];
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    CGContextSetLineWidth(contextRef, 4);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
    [pickingFieldPath stroke];
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
}


@end
