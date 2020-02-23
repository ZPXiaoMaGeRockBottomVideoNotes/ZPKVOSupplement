//
//  ZPPerson.h
//  KVO补充
//
//  Created by 赵鹏 on 2019/5/7.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZPPerson : NSObject
{
    @public
    int _age;
}

@property (nonatomic, assign) int age;

@end

NS_ASSUME_NONNULL_END
