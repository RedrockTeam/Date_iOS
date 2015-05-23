//
//  HeaderViewCellTableViewCell.m
//  date_iOS
//
//  Created by BooleanMac on 15/5/22.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "HeaderViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"

@interface HeaderViewCell()

@property (weak, nonatomic) NSArray *banners;
@end

@implementation HeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark Banners

-(void)loadBanners:(NSArray *)banners{
    
    if(banners == nil){
        banners = self.banners;
    }
    
    UIScrollView *scroll = self.scroll;
    
    int i = 0;
    int width = scroll.frame.size.width;
    int height = scroll.frame.size.height;
    
    for (NSString *banner in banners) {
        NSString *url = [banner valueForKey:@"src"];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * width, 0, width, height)];
        [imageView setImageWithURLRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString: url]]
                         placeholderImage:[UIImage imageNamed:@"未标题-2"]
                                  success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      imageView.image = image;
                                      NSLog(@"Load Image Succeed!");
                                  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      NSLog(@"Load Image Error: %@", error);
                                  }];
        [scroll addSubview:imageView];
        i++;
    }
    
    [scroll setContentSize:CGSizeMake(width * i, height)];
    self.pageControl.numberOfPages = i;
}

-(void)getBanners{
    self.pageControl.numberOfPages = 1;
    
    NSString *url = @"http://106.184.7.12:8002/index.php/api/public/banner";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if([[[responseObject objectForKey:@"status"]stringValue] isEqual: @"200"]){
                 responseObject = [responseObject objectForKey:@"data"];
                 self.banners = responseObject;
                 [self loadBanners:responseObject];
             }else{
                 NSLog(@"Get Banners Error:%@ =======> %@",
                       [responseObject objectForKey:@"status"],
                       [responseObject objectForKey:@"info"]);
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Get Banners Error: %@", error);
         }];
}

@end
