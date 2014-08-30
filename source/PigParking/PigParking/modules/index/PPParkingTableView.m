//
//  PPParkingTableView.m
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPParkingTableView.h"
#import "PPParkingTableViewCell.h"
#import "PPParkingFilterView.h"
#import "PPMapView.h"
#import "PPIndexModel.h"

@interface PPParkingTableView ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) PPIndexModel *model;

@end

@implementation PPParkingTableView

- (id)initWithFrame:(CGRect)frame data:(NSArray *)data
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.data = data;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 0;
    }
    
    if (0 == _data.count)
    {
        return 1;
    }
    
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == _data.count)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"empty-cell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"附近没有停车场。";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    static NSString *cid = @"parking-cell";
    
    PPParkingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell)
    {
        cell = [[PPParkingTableViewCell alloc] initWithReuseIdentifier:cid];
    }
    
    NSDictionary *d = _data[indexPath.row];
    
    cell.chargeLabel.text = [NSString stringWithFormat:@"费用：%@", 0==[d[@"charge"] intValue]?@"免费":d[@"charge"]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"地址：%@", d[@"address"]]; //@"距离：步行至此地5分钟";
    cell.parkingCountLabel.text = [NSString stringWithFormat:@"车位：%@", d[@"parkingCount"]];//@"车位：500个";
    cell.addressLabel.text = [NSString stringWithFormat:@"%@", d[@"title"]];// @"地址：深圳市区松坪山公园";
    cell.flag = (PPParkingTableViewCellFlag)[[d objectForKey:@"flag"] intValue];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_actDelegate && [_actDelegate respondsToSelector:@selector(parkingTableView:didSelectRowAtIndexPath:)])
    {
        [_actDelegate performSelector:@selector(parkingTableView:didSelectRowAtIndexPath:) withObject:self withObject:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        return 0.0f;
    }
    
    return 165.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (1 == section)
    {
        return nil;
    }
    
    PPParkingFilterView *v = [[PPParkingFilterView alloc] initWithDelegate:self];
    v.isResponseImmediately = YES;
    v.frame = CGRectMake(0.0f, 0.0f, v.bounds.size.width, 165.0f);
    v.clipsToBounds = YES;
    return v;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - model

- (void)fetchData:(NSDictionary *)options
{
    if (!_model)
    {
        self.model = [PPIndexModel model];
    }
    
    [_model fetchAroundParking:[PPMapView sharedInstance].coordinate params:options block:^(NSArray *data, NSError *error) {
        if (error)
        {
            return ;
        }
        
        self.data = data;
        [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - ParkingFilterViewDelegate

- (void)parkingFilterViewDidSelectOption:(PPParkingFilterView *)view options:(NSDictionary *)options
{
    [self fetchData:options];
}

@end
