//
//  CALayer+Exception.h
//  SVGKit-iOS
//
//  Created by vlr on 8/28/17.
//  Copyright © 2017 na. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Exception)

- (BOOL)handleException:(NSException *)e;

@end
