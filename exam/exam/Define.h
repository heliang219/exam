//
//  Define.h
//  exam
//
//  Created by zdy on 15/9/9.
//  Copyright © 2015年 xinyunlian. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
#endif /* Define_h */
