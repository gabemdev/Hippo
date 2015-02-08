//
//  ColorPickerView.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "ColorPickerView.h"

#import "SettingsController.h"
#import "AppDelegate.h"

@interface ColorPickerView ()

@property (nonatomic, strong) SettingsController *setController;

@end

@implementation ColorPickerView
{
    NSUserDefaults *userDefaults;
    
    UIColor *backgroundColor;
    UIColor *textColor;
    NSArray *brandColors;
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        backgroundColor = [UIColor GMDColorWithHex: [userDefaults stringForKey:backgroundColorPrefsKey]];
        textColor = [UIColor GMDColorWithHex: [userDefaults stringForKey:textColorPrefsKey]];
        self.backgroundColor = [UIColor whiteColor];
        
        self.bcColors = @[@"#1abc9c", @"#2ecc71", @"#3498db", @"#9b59b6", @"#34495e", @"#16a085", @"#27ae60", @"#2980b9", @"#8e44ad", @"#2c3e50", @"#f1c40f", @"#e67e22", @"#e74c3c", @"#ecf0f1", @"#95a5a6", @"#f39c12", @"#d35400", @"#c0392b", @"#bdc3c7", @"#7f8c8d"];
        //brandColors = @[[UIColor Instagram], [UIColor Facebook], [UIColor Dropbox], [UIColor Evernote], [UIColor Amazon], [UIColor Carbonmade], [UIColor Foursquare]];
        
        //colors = @[[UIColor colorWithHexString:@"#1abc9c" alpha:1], [UIColor colorWithHexString:@"#2ecc71" alpha:1], [UIColor colorWithHexString:@"#3498db" alpha:1], [UIColor colorWithHexString:@"#9b59b6" alpha:1], [UIColor colorWithHexString:@"#34495e" alpha:1], [UIColor colorWithHexString:@"#16a085" alpha:1], [UIColor colorWithHexString:@"#27ae60" alpha:1], [UIColor colorWithHexString:@"#2980b9" alpha:1], [UIColor colorWithHexString:@"#8e44ad" alpha:1], [UIColor colorWithHexString:@"#2c3e50" alpha:1], [UIColor colorWithHexString:@"#f1c40f" alpha:1], [UIColor colorWithHexString:@"#e67e22" alpha:1], [UIColor colorWithHexString:@"#e74c3c" alpha:1], [UIColor colorWithHexString:@"#ecf0f1" alpha:1], [UIColor colorWithHexString:@"#95a5a6" alpha:1], [UIColor colorWithHexString:@"#f39c12" alpha:1], [UIColor colorWithHexString:@"#d35400" alpha:1], [UIColor colorWithHexString:@"#c0392b" alpha:1], [UIColor colorWithHexString:@"#bdc3c7" alpha:1], [UIColor colorWithHexString:@"#7f8c8d" alpha:1]];
        
        float scrollContentheight = [_bcColors count] * 50.0;
        self.contentSize = CGSizeMake(self.bounds.size.width, scrollContentheight);
        [self setContentOffset:CGPointMake(0.0, 0.0)];
        self.canCancelContentTouches = YES;
        
        [self createTiles];
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

- (void)createTiles {
    float tileWidth = self.bounds.size.width / 2;
    float tileHeight = 100.0;
    
    NSInteger numOfTiles = [_bcColors count];
    NSInteger tileCount = 0;
    
    for (int i = 0; i < numOfTiles; i++) {
        float tileX;
        float tileY;
        
        CALayer *tile = [CALayer layer];
        if (i % 2) {
            tileX = tileWidth;
            tileY = ((tileCount - 1) / 2.0) * tileHeight;
            tile.frame = CGRectMake(tileX, tileY, tileWidth, tileHeight);
        }
        else {
            tileX = 0;
            tileY = (tileCount / 2.0) * tileHeight;
            tile.frame = CGRectMake(tileX, tileY, tileWidth, tileHeight);
        }
        
        tile.backgroundColor = [[UIColor GMDColorWithHex:[_bcColors objectAtIndex:tileCount]] CGColor];
        [self.layer addSublayer:tile];
        
        UIButton *tileButton = [[UIButton alloc] initWithFrame:CGRectMake(tileX, tileY, tileWidth, tileHeight)];
        [tileButton setTag:tileCount];
        [tileButton addTarget:_setController action:@selector(tilePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tileButton];
        
        tileCount++;
    }
}

@end
