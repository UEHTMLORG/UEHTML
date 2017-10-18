//
//  ATQDataSource.m
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQDataSource.h"
#import "ATQPYQModel.h"
#import "ATQCommentModel.h"
@implementation ATQDataSource
+(NSMutableArray *)loadDataArray
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSArray *nameArray = @[@"伤心天涯人",@"寂寞高手",@"怎么忍心怪你犯了错",@"布吉"];
    NSArray *msgStringArray = @[@"这是个测试数据",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据"];
    NSArray *headImgNameArray = @[@"icon1",@"icon2",@"icon3",@"icon4"];
    NSArray *picImageNamesArray = @[ @"pic00.jpg",
                                     @"pic01.jpg",
                                     @"pic02.jpg",
                                     @"pic03.jpg",
                                     @"pic04.jpg"
                                     ];
    for(int i = 0;i < 10 ;i++)
    {
        ATQPYQModel *model = [[ATQPYQModel alloc] init];
        int randomIndex = arc4random_uniform(4);// 生成 0-3随机数
        int picCount = arc4random_uniform(5);
        model.usernName = nameArray[randomIndex];
        model.headImgName = headImgNameArray[randomIndex];
        model.msgContent = msgStringArray[randomIndex];
        
        NSMutableArray *picTemArray = [NSMutableArray array];
        NSMutableArray *commentArray = @[].mutableCopy;
        for(int i = 0;i < picCount ;i++)
        {
            int picIndex = arc4random_uniform(4);
            [picTemArray addObject:picImageNamesArray[picIndex]];
        }
        if(picTemArray.count != 0)
        {
            //图片的数组
            model.picNameArray = [NSArray arrayWithArray:picTemArray];
        }
        for(int i=0;i<3;i++)
        {
            ATQCommentModel *comment = [[ATQCommentModel alloc] init];
            comment.userName = nameArray[i];
            comment.content = msgStringArray[i];
            if(i==1)
            {
                comment.replyUserName = nameArray[3];
            }
            [commentArray addObject:comment];
        }
        //赞的数组
        model.likeNameArray = @[@"怎么忍心怪你犯了错",@"伤心天涯人"];
        //评论的数组
        model.commentArray = [NSArray arrayWithArray:commentArray];
        [dataArray addObject:model];
    }
    return dataArray;
}

+(NSMutableArray *)initFeedArray {
    NSMutableArray *feedArray = [[NSMutableArray alloc] init];
    NSArray *contentArray = [NSArray arrayWithObjects:@"这是最为常用的格式，在平时常用的的文本编辑器中大多是这样现的：输入文本、选中文本、设置标题格式", @"这是最为常用的格式，在平时常用的的文本编辑器中大多是这样现的：输入文本、选中文本、设置标题格式。而在 Markdown 中，你只需要在文本前面加上 # 即可，同理、你还可以增加二级标题、三级标题、四级标题、五级标题和六级标题，总共六级，只需要增加 # 即可，标题字号相应降低。例如", nil];
    
    for (int i = 0; i < 10; i++) {
        ATQPYQModel *feed = [[ATQPYQModel alloc] init];
//        feed.imageUrl = @"http://cdn-qn0.jianshu.io/assets/default_avatar/13-8072fce67829ce128ba5df823205516c.jpg";
        feed.usernName = [NSString stringWithFormat:@"标题%d", i];
//        feed.time = [NSString stringWithFormat:@"这里是时间%d", i];
        feed.msgContent = [contentArray objectAtIndex:(i % 2)];
        [feedArray addObject:feed];
    }
    return feedArray;
}
@end
