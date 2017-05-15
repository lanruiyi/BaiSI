//
//  RLMUser.h
//  BaiSI
//
//  Created by Mac on 17/5/10.
//  Copyright © 2017年 www.lanruiyi.com. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMUser : RLMObject
@property NSString       *accid;//用户注册id
@property NSInteger      custId;//姓名
@property NSString       *custName;//头像大图url
@property NSString       *avatarBig;
@property RLMArray *cars;


//@interface Car : RLMObject
//@property NSString *carName;
//@property RLMUser *owner;
@end
RLM_ARRAY_TYPE(RLMUser) // 定义RLMArray
//RLM_ARRAY_TYPE(Car) // 定义RLMArray@end

