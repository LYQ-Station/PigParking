//
//  PPParkingTableView.m
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPParkingTableView.h"
#import "PPParkingTableViewCell.h"

@interface PPParkingTableView ()

@property (nonatomic, assign) NSArray *data;

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

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"parking-cell";
    
    PPParkingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell)
    {
        cell = [[PPParkingTableViewCell alloc] initWithReuseIdentifier:cid];
    }
    
    NSDictionary *d = _data[indexPath.row];
    
    cell.chargeLabel.text = [NSString stringWithFormat:@"费用：%@", d[@"charge"]];
    cell.distanceLabel.text = [NSString stringWithFormat:@"距离：%@", d[@"charge"]]; //@"距离：步行至此地5分钟";
    cell.parkingCountLabel.text = [NSString stringWithFormat:@"车位：%@", d[@"parkingCount"]];//@"车位：500个";
    cell.addressLabel.text = [NSString stringWithFormat:@"地址：%@", d[@"address"]];// @"地址：深圳市区松坪山公园";
    cell.flag = (PPParkingTableViewCellFlag)[[d objectForKey:@"type"] intValue];
    
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
