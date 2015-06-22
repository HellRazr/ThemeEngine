//
//  TKColorRendition.m
//  ThemeKit
//
//  Created by Alexander Zielenski on 6/13/15.
//  Copyright © 2015 Alex Zielenski. All rights reserved.
//

#import "TKColorRendition.h"
#import "TKRendition+Private.h"
#import "NSColor+CoreUI.h"

@implementation TKColorRendition

- (instancetype)initWithColorKey:(struct colorkey)key definition:(struct colordef)definition {
    if ((self = [self init])) {
        self.name  = @(key.name);
        self.color = [NSColor colorWithColorDef:definition];
    }
    
    return self;
}

- (void)setColor:(NSColor *)color {
    _color = color;
    self._previewImage = nil;
}

- (void)computePreviewImageIfNecessary {
    if (self._previewImage)
        return;
    
    __weak typeof(self) weakSelf = self;
    self._previewImage = [NSImage imageWithSize:NSMakeSize(1, 1) flipped:NO drawingHandler:^BOOL(NSRect dstRect) {
        [weakSelf.color setFill];
        NSRectFill(dstRect);
        
        return YES;
    }];
}

+ (NSDictionary *)undoProperties {
    static NSDictionary *TKColorProperties = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TKColorProperties = @{
                               TKKey(color): @"Change Color"
                               };
    });
    
    return TKColorProperties;
}


@end
