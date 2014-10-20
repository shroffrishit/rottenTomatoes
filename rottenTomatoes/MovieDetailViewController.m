//
//  MovieDetailViewController.m
//  rottenTomatoes
//
//  Created by Rishit Shroff on 10/19/14.
//  Copyright (c) 2014 Rishit Shroff. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property long y;
@property long x;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.y = 400;
    self.x = 4;
 
    [self addTitleLabel];
    [self addCastLabel];
    [self addsSynopsisLabel];

    self.scroller.contentSize = CGSizeMake(320, self.y);
    self.scroller.pagingEnabled = true;
    
    // Set the background color of UIScrollView to transparent
    self.scroller.backgroundColor = [UIColor clearColor];
    
    // Update the poster image to the one passed in
    self.poster.image = self.image;
    
    // Set the background of scroller to the given image and put it
    // in the background
    [self.scroller sendSubviewToBack:self.poster];
    
    // Load the detailed image in the background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *moviePosterURL = self.movie[@"posters"][@"thumbnail"];
        moviePosterURL = [moviePosterURL stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];

        [self.poster setImageWithURL:[NSURL URLWithString:moviePosterURL]];
    });
}

- (void) addTitleLabel {
    self.movieTitle = [self createLabel:@"title" prependString:@"Title" useDict:TRUE];
    [self.scroller addSubview:self.movieTitle];
}

- (void) addCastLabel {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Cast"]];
    
    [title addAttribute:NSFontAttributeName value:
     [UIFont fontWithName:@"Helvetica-Bold" size:16]
                  range:NSMakeRange(0, title.length)];
    
    // Create the list of star-cast
    NSArray *characters = self.movie[@"abridged_cast"];
    NSString *actors = [[NSString alloc] init];
    for (int i = 0; i < characters.count; ++i) {
        actors = [actors stringByAppendingString:
                  [NSString stringWithFormat:@"%@", characters[i][@"name"]]];
        if (i != characters.count - 1) {
            actors = [actors stringByAppendingString:
                      [NSString stringWithFormat:@", "]];
        }
    }
    
    self.cast = [self createLabel:actors prependString:@"Cast" useDict:FALSE];
    [self.scroller addSubview:self.cast];
}

- (void) addsSynopsisLabel {
    self.details = [self createLabel:@"synopsis" prependString:@"Synopsis" useDict:TRUE];
    [self.scroller addSubview:self.details];
}

- (UILabel *) createLabel:(NSString *)key
                       prependString:(NSString *)prependValue
                  useDict:(BOOL)dict {
    
    NSMutableAttributedString *attributedText = nil;
    
    if (dict) {
        attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@", prependValue, self.movie[key]]];
    } else {
        attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@", prependValue, key]];
    }
    
    // Set the font
    [attributedText addAttribute:NSFontAttributeName value:
     [UIFont fontWithName:@"Helvetica" size:16]
                           range:NSMakeRange(0, attributedText.length)];
    
    // Set the bold font for the prepend text
    [attributedText addAttribute:NSFontAttributeName value:
     [UIFont fontWithName:@"Helvetica-Bold" size:16]
                           range:NSMakeRange(0, prependValue.length)];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){320, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    rect.origin = CGPointMake(self.x, self.y);
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textAlignment = NSTextAlignmentLeft;
    
    [label setAttributedText:attributedText];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setNumberOfLines:0];
    
    self.y += rect.size.height + 10;
    
    return label;
}

@end
