//
//  IndexViewControllerTableViewController.m
//  date_iOS
//
//  Created by BooleanMac on 15/5/13.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "IndexViewController.h"
#import "DateDetailViewController.h"
#import "AFNetworking.h"

@interface IndexViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) Util *util;
@end

@implementation IndexViewController

-(id)dateListResponseFilterWithData:(id)data{
    data = [data valueForKey:@"data"];
    return data;
}

/**
 *  获取约会列表
 *
 *  @param uid   用户id
 *  @param token token
 */
-(void)getDateListWithUid:(NSNumber *)uid token:(NSString *)token{
    NSString *url = @"http://106.184.7.12:8002/index.php/api/date/datelist";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"uid": uid,
                                 @"token": token,
                                 @"date_type": @0,
                                 @"page": @1,
                                 @"size": @10,
                                 @"order": @1
                                 };
    [manager POST:url
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              responseObject = [self dateListResponseFilterWithData:responseObject];
              self.data = responseObject;
              [self.tableview reloadData];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error: %@", error);
          }];
}

-(void)loadBanners:(NSArray *)banners{
    
    if(banners == nil){
        banners = self.banners;
    }
    
    int i = 0;
    for (NSString *banner in banners) {
        
        i++;
    }
    
}

-(void)getBanners{
    NSString *url = @"http://106.184.7.12:8002/index.php/api/public/banner";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if([[responseObject objectForKey:@"status"] isEqual: @"200"]){
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

-(void)viewWillAppear:(BOOL)animated{
    [self getDateListWithUid: [NSNumber numberWithInt:1] token:@"nasdfnldssdaf"];
    [self getBanners];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"View Did Load At: %@", self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning At: %@", self);
}

#pragma mark - Table view data source

/**
 *  section数
 *
 *  @param tableView
 *
 *  @return NSInteger 数量
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 *  一个section的row数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSInteger 数量
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count] + 1;
}

/**
 *  获取单个Cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return 取好信息的cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"IdentifierViewCell";
    if (indexPath.row == 0) {
        IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
        return cell;
    }
    
    NSDictionary *dict = [self.data objectAtIndex: (indexPath.row - 1)];
    
    IndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSURL *avatarURL = [NSURL URLWithString:[dict objectForKey:@"head"]];
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
    if ([dict objectForKey:@"gender"] == [NSNumber numberWithInt:1]) {
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-boy"]];
    }else{
        [cell.gender setImage:[UIImage imageNamed:@"iconfont-girl"]];
    }
    
    //设置各种文本...
    cell.nickname.text = [dict objectForKey:@"nickname"];
    cell.subtitle.text = [dict objectForKey:@"title"];
    cell.content.text = [dict objectForKey:@"signature"];
    cell.address.text = [dict objectForKey:@"place"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"date_at"] doubleValue]];
    
    cell.date.text = [date description];
    cell.price.text = [Util priceNameForKey:[dict objectForKey:@"cost_model"]];

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IndexTableViewCell *cell = (IndexTableViewCell *)sender;
    DateDetailViewController *detailController = (DateDetailViewController *)segue.destinationViewController;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    scrollView.contentOffset.x / scrollView.superclass.f
}

@end
