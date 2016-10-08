//
//  CityModel.m
//  生日键盘
//
//  Created by liuxingchen on 16/10/8.
//  Copyright © 2016年 liuxingchen. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel
+(instancetype)cityModelWithDict:(NSDictionary *)dict
{
    CityModel *city = [[self alloc]init];
    [city setValuesForKeysWithDictionary:dict];
    return city;
}
@end
