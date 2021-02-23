//
//  SAShapeView.m
//  ShapeApp
// 
//  Created by Morgan Winer on 9/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "SAShapeView.h"
#import "SARectangle.h"
#import "SAPinchGesture.h"

@interface SAShapeView ()

@property (nonatomic, strong) NSMutableArray *list;

@end


@implementation SAShapeView
//@implementation TableViewController {   SAShapeView *_shapeView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    _shapeView = [[SAShapeView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_shapeView];
//
//    [_shapeView addShape:[SARectangle shapeWithFrame:CGRectMake(10,50,100,100) color:[UIColor blueColor]]];
//    [_shapeView addShape:[SACircle shapeWithFrame:CGRectMake(30,110,100,100) color:[UIColor greenColor]]];
    
    self.list = [NSMutableArray array];
    [self.list addObject:[SARectangle class]];

    
    
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
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [self.list[indexPath.row] displayName];


    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class class = self.list[indexPath.row];
    id controller = [[class alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
