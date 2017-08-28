//
//  CALayer+Exception.m
//  SVGKit-iOS
//
//  Created by vlr on 8/28/17.
//  Copyright © 2017 na. All rights reserved.
//

#import "CALayer+Exception.h"

@import UIKit;

@implementation CALayer (Exception)

/* This method is handling specific crash which is not occured on iOS 10.*.
 * Actually, some specific reasons are ignored on iOS 10.* by Core Animation and so
 * we are ignoring the same reasons on iOS 9.*: manually by this method it sets position to Zero values.
 *
 * It is handling following reasons:
 *   - sublayer with non-finite position: inf, -inf and etc;
 *   - CALayer position contains NaN.
 *
 * Exceptions with these resons will be crached and ignored to avoid app crashing.
 * All other exceptions will be regenerated and app will crash.
 */
- (BOOL)handleException:(NSException *)e {
    BOOL handled = NO;
    
    if ([e.name isEqualToString:@"CALayerInvalidGeometry"]) {
        
        if ([e.reason containsString:@"sublayer with non-finite position"] ||
            [e.reason containsString:@"CALayer position contains NaN"]) {
            
            if ([[[UIDevice currentDevice] systemVersion] containsString:@"9."]) {
                NSLog(@"____SVGKit___CRASH!!!:__\n___Name: %@___Reason: %@___UserInfo: %@", e.name, e.reason, e.userInfo);
               
                for (CALayer *layer in self.sublayers) {
                    if (isinf(layer.position.x) || isinf(layer.position.y)) {
                        layer.position = CGPointZero;
                    }
                    else if (isnan(layer.position.x) || isnan(layer.position.y)) {
                        layer.position = CGPointZero;
                    }
                }
                
                handled = YES;
            }
        }
    }
    
    return handled;
}

@end
