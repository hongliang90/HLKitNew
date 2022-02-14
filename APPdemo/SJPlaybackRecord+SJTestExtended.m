//
//  SJPlaybackRecord+SJTestExtended.m
//  APPdemo
//
//  Created by db on 2022/2/14.
//

// 这里对 record 类扩展了一个属性, 在保存记录时会自动保存到数据库中
// 你可以按照这种方式, 扩展一些自己的业务属性, 在第三步创建播放记录时, 进行赋值操作, 使其能够保存到数据库中

#import "SJPlaybackRecord+SJTestExtended.h"



@interface SJPlaybackRecord(sjTestExtended)
@property (nonatomic, copy,nullable) NSString *title;
@end

@implementation SJPlaybackRecord (SJTestExtended)

- (void)setTitle:(NSString *)title {
   objc_setAssociatedObject(self,@selector(title),title,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)title {
    return objc_getAssociatedObject(self, _cmd);
}

@end
