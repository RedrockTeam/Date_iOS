//
//  HeaderViewCellTableViewCell.h
//  date_iOS
//
//  Created by BooleanMac on 15/5/22.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
-(void)getBanners;
@end
