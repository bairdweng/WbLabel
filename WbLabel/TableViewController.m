//
//  TableViewController.m
//  WbLabel
//
//  Created by Baird-weng on 15/12/10.
//  Copyright © 2015年 Baird-weng. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *Array1 = @[@[@"广州",@"带边框的Label"],@[@"111",@"111"]];
    NSArray *Array2 = @[@[@"2",@"22"],@[@"222",@"带边框的Label"]];
    NSArray *Array3 = @[@[@"3",@"33"],@[@"333",@"3333"],@[@"33333",@"33333"]];
    NSArray *Array4 = @[@[@"2",@"22"],@[@"222",@"带边框的Label"]];
    NSArray *Array5 = @[@[@"5",@"深圳"],@[@"88888",@"999999"]];
    _titleAry = @[Array1,Array2,Array3,Array4,Array5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"第%ld组",section+1];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_titleAry count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *Ary2 = _titleAry[section];
    return [Ary2 count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.TestVbLabel.EdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    cell.TestVbLabel.AttributedstrArray = [self setAttributedString:indexPath.row andSelectIndex:indexPath.section];
    //刷新页面
    [cell.TestVbLabel setNeedsDisplay];
    //这一句相当重要，否则会造成布局不准确。
    [cell.TestVbLabel invalidateIntrinsicContentSize];
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(NSMutableArray *)setAttributedString:(NSInteger)index andSelectIndex:(NSInteger)section{
    NSArray *Array2 = _titleAry[section];
    NSArray *Array = Array2[index];
    NSMutableArray *arry = [NSMutableArray array];
    for (int i = 0; i<[Array count]; i++){
        WBModel *model = [WBModel new];
        model.Title = Array[i];
        model.Textfont = [UIFont systemFontOfSize:40];
        model.borderColor = [UIColor yellowColor];
        model.TextColor = [UIColor whiteColor];
        model.borderWide = 0.5;
        [arry addObject:model];
    }
    return arry;
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
