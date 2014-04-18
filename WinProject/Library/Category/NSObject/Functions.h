//
//  Functions.h
//  InnerBand
//
//  Created by Dean on 11/15/11.
//  Copyright (c) 2011 Rapture In Venice. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL IS_IPHONE(void);

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define Alert(x) [[[UIAlertView alloc] initWithTitle:@"提示" message:x delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show]