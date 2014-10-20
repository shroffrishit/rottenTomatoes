//
//  MovieDetailTableViewCell.h
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/19/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *synopsis;

@end
