//
//  LocationResultsTableViewCell.h
//  MapKit-Classwork
//
//  Created by Evan Baumgardner on 5/27/14.
//  Copyright (c) 2014 Evan Baumgardner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationResultsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
