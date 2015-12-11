//
//  WBModel.h
//  WbLabel
//
//  Created by Baird-weng on 15/12/11.
//  Copyright © 2015年 Baird-weng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WBModel : NSObject
@property(nonatomic,strong)NSString *Title;
@property(nonatomic,strong)UIColor *TextColor;
@property(nonatomic,strong)UIFont *Textfont;
@property(nonatomic,strong)UIColor *borderColor;
@property(nonatomic,assign)CGFloat borderWide;
@property(nonatomic,assign)UIEdgeInsets borderEdge;
@end
