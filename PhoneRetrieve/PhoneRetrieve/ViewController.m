//
//  ViewController.m
//  V44Demo
//
//  Created by wangzhangchuan on 2018/1/8.
//  Copyright © 2018年 wangzhangchuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializedBaseProperties];
    [self loadData];
}

- (void)initializedBaseProperties {
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"FunctionList" ofType:@"plist"];
    
    
    NSArray *tempArray = [[NSArray alloc] initWithContentsOfFile:configPath];
    self.dataArray = @[tempArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *tempArray = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *tempDict    = [tempArray objectAtIndex:indexPath.row];
    cell.textLabel.text       = tempDict[@"Description"];
    cell.detailTextLabel.text = tempDict[@"ClassName"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *tempArray = [self.dataArray objectAtIndex:indexPath.section];
    NSDictionary *tempDict    = [tempArray objectAtIndex:indexPath.row];

    [self push2VCWith:tempDict[@"ClassName"] title:tempDict[@"Description"]];
}


@end
