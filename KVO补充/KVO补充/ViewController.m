//
//  ViewController.m
//  KVO补充
//
//  Created by 赵鹏 on 2019/5/7.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "ZPPerson.h"

@interface ViewController ()

@property (strong, nonatomic) ZPPerson *person;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [[ZPPerson alloc] init];
    self.person.age = 1;
    
    //给person对象添加KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    /**
     ·对于已经被添加KVO监听的对象来讲，修改它属性的值的话可以触发KVO的监听方法，但是如果修改它的成员变量的值是不能够触发KVO的监听方法的。
     ·其原因就在于对于已经被添加KVO监听的对象而言，instance对象的isa指针已经被改变为了指向系统新创建的子类的class对象了，然后在这个子类的class对象里面找到了(setAge:)实例方法，最后再进行调用。由之前的Demo可知，当调用新创建的子类的class对象中的属性的set实例方法的时候其实是在调用Foundation框架里面的C语言函数"_NSSetIntValueAndNotify"，这个函数中会执行"didChangeValueForKey:"方法，此方法会触发KVO的监听方法。由此可知KVO的本质是调用set实例方法，即只有通过调用属性的set实例方法来修改属性的值才能触发KVO的监听方法，而修改对象的成员变量就没有调用属性的set方法，所以是不能够触发KVO的监听方法的。
     */
    self.person->_age = 2;
    
    //如果想要在修改对象的成员变量的时候也能够触发KVO的监听方法的话就要手动触发KVO
//    [self manualTriggerKVO];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"监听到%@的%@属性值改变了 - %@", object, keyPath, change);
}

#pragma mark ————— 手动触发KVO —————
- (void)manualTriggerKVO
{
    [self.person willChangeValueForKey:@"age"];
    self.person->_age = 3;
    [self.person didChangeValueForKey:@"age"];
}

- (void)dealloc
{
    [self.person removeObserver:self forKeyPath:@"age"];
}

@end
