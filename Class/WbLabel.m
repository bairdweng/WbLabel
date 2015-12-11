//
//  WbLabel.m
//  WbLabel
//
//  Created by Baird-weng on 15/12/10.
//  Copyright © 2015年 Baird-weng. All rights reserved.
//

#import "WbLabel.h"
@implementation WbLabel
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (int i = 0; i<[self.AttributedstrArray count]; i++) {
        CGRect rect = [self CalculateTheLayout:i];
        WBModel *model = self.AttributedstrArray[i];
        [self DrawingBorder:rect borderWide:model.borderWide borderColor:model.borderColor];
        [self drawbordText:model.Textfont rect:rect Text:model.Title textColor:model
         .TextColor];
    }
}
-(void)DrawingBorder:(CGRect)rect borderWide:(CGFloat)Wide borderColor:(UIColor *)Color{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetStrokeColorWithColor(context, Color.CGColor);
    CGContextSetLineWidth(context, Wide);
    UIBezierPath *paths = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:2];
    CGContextAddPath(context, paths.CGPath);
    CGContextStrokePath(context);    
}
-(void)drawbordText:(UIFont *)Font rect:(CGRect)rect Text:(NSString *)String textColor:(UIColor *)TextColor{
    CGRect rrect = CGRectMake(rect.origin.x+2.5, rect.origin.y+2.5, rect.size.width-5, rect.size.height-5);
    [String drawInRect:rrect withAttributes:@{NSFontAttributeName:Font,NSForegroundColorAttributeName:TextColor}];
    
}
//计算
-(CGRect)CalculateTheLayout:(NSInteger)Index{
    CGRect rect;
    if (Index == 0){
        WBModel *model = self.AttributedstrArray[Index];
        NSString *String = model.Title;
        UIFont *Font = model.Textfont;
        CGSize Size = [self GetboundRectWithBorderSize:String TextFont:Font];
        rect = CGRectMake(self.EdgeInsets.left, self.EdgeInsets.top, Size.width, Size.height);
    }
    else{
        //跟上一个对比
        CGRect lastrect = [self CalculateTheLayout:Index-1];
        WBModel *model = self.AttributedstrArray[Index];
        NSString *String = model.Title;
        UIFont *Font = model.Textfont;
        CGSize Size = [self GetboundRectWithBorderSize:String TextFont:Font];
        //判断是否需要换行
        CGFloat tX = lastrect.origin.x+lastrect.size.width+self.EdgeInsets.right+self.EdgeInsets.left+Size.width+self.EdgeInsets.right;
        //超过边界需要换行。
        if (tX>self.frame.size.width){
            rect = CGRectMake(self.EdgeInsets.left, lastrect.origin.y+lastrect.size.height+self.EdgeInsets.bottom+self.EdgeInsets.top, Size.width, Size.height);
        }
        else{
            rect = CGRectMake(lastrect.origin.x+lastrect.size.width+self.EdgeInsets.right+self.EdgeInsets.left, lastrect.origin.y, Size.width, Size.height);
        }
    }
    return rect;
}

//计算文字高度。
-(CGSize)GetboundRectWithSize:(NSString *)Text TextFont:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [Text boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)
                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                    attributes:attributes
                                       context:nil];
    return rect.size;
}



//计算边框的size。
-(CGSize)GetboundRectWithBorderSize:(NSString *)Text TextFont:(UIFont *)font{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [Text boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:attributes
                                     context:nil];
    
    return CGSizeMake(rect.size.width+5, rect.size.height+5);
}



-(CGSize)intrinsicContentSize{
    if ([self.AttributedstrArray count]>0) {
        CGRect rect = [self CalculateTheLayout:[self.AttributedstrArray count]-1];
        return CGSizeMake(self.frame.size.width, rect.origin.y+rect.size.height+self.EdgeInsets.bottom);
    }
    else{
        return self.frame.size;
    }
}

@end
