//
//  IndexViewControllerTableViewController.m
//  date_iOS
//
//  Created by BooleanMac on 15/5/13.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexViewController.h"

@interface IndexViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *data;
@end

@implementation IndexViewController

-(void)viewWillAppear:(BOOL)animated{
    _data =
             @[
               @{
                   @"nickname":@"第一个",
                   @"avatarURL":@"http://202.202.43.41/market/public/img/home/select.png",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:1],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"1元",
                   }
               ,@{
                   @"nickname":@"第二个",
                   @"avatarURL":@"http://202.202.43.41/market/app/storage/img/goods/cj/14316730398843.jpg",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:1],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"2元",
                   }
               ,@{
                   @"nickname":@"第三个",
                   @"avatarURL":@"http://202.202.43.41/market/app/storage/img/goods/cj/14316032766928.jpg",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:1],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"3元",
                   }
               ,@{
                   @"nickname":@"第四个",
                   @"avatarURL":@"http://202.202.43.41/market/public/img/home/select.png",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:1],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"4元",
                   }
               ,@{
                   @"nickname":@"第五个",
                   @"avatarURL":@"http://202.202.43.41/market/app/storage/img/goods/cj/14316730398843.jpg",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:1],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"5元",
                   }
               ,@{
                   @"nickname":@"第六个",
                   @"avatarURL":@"http://202.202.43.41/market/app/storage/img/goods/cj/14316032766928.jpg",
                   @"subtitle":@"啊哈哈哈哈哈哈啊哈哈哈哈哈",
                   @"gender":[NSNumber numberWithInt:0],
                   @"content":@"约不约约不约约不约约不约约不约约不约约不约约不约约不约我们去约把!!!好好久没有约过了好桑心的!!!呜呜呜呜呜呜呜喵喵喵喵喵",
                   @"address":@"老校门",
                   @"date":@"今天晚上",
                   @"price":@"6元",
                   }
               ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"IdentifierViewCell";
    NSDictionary *dict = [self.data  objectAtIndex: indexPath.row];
    
    IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSURL *avatarURL = [NSURL URLWithString:[dict objectForKey:@"avatarURL"]];
        [cell.avatar setImageWithURLRequest:[[NSURLRequest alloc]initWithURL:avatarURL]
                      placeholderImage:[UIImage imageNamed:@"未标题-2"]
                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                   cell.avatar.image = image;
                               }
                               failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                   NSLog(@"Failed to load pic. And the Error Message is :\n %@", error);
                               }];
    
    //让图片变圆
    cell.avatar.layer.masksToBounds  = YES;
    cell.avatar.layer.cornerRadius = cell.avatar.frame.size.height / 2;
    
    //根据性别获取图标
    if ([dict objectForKey:@"gender"] == [NSNumber numberWithInt:0]) {
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-boy"]];
    }else{
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-girl"]];
    }
    
    //设置各种文本...
    cell.nickname.text = [dict objectForKey:@"nickname"];
    cell.subtitle.text = [dict objectForKey:@"subtitle"];
    cell.content.text = [dict objectForKey:@"content"];
    cell.address.text = [dict objectForKey:@"address"];
    cell.date.text = [dict objectForKey:@"date"];
    cell.price.text = [dict objectForKey:@"price"];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
