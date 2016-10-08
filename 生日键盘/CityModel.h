//
//  CityModel.h
//  生日键盘
//
//  Created by liuxingchen on 16/10/8.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property(nonatomic,copy)NSString * name ;
@property(nonatomic,strong)NSArray * cities ;
+(instancetype)cityModelWithDict:(NSDictionary *)dict;
@end
