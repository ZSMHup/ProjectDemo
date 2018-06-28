//
//  BookDetailEvaluateModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface BookDetailEvaluateModel : NetworkRequestModel

/**评论码*/
@property (nonatomic, copy) NSString *commentCode;
/**书籍码*/
@property (nonatomic, copy) NSString *bookCode;
/**id*/
@property (nonatomic, copy) NSString *uid;
/**评论文字内容*/
@property (nonatomic, copy) NSString *commentContent;
/**评论为语音内容*/
@property (nonatomic, copy) NSString *commentVoiceUrl;
/**评分*/
@property (nonatomic, copy) NSString *commentScore;
/**评论时间*/
@property (nonatomic, copy) NSString *commentTime;
/**COMMENT_TEXT COMMENT_VOICE*/
@property (nonatomic, copy) NSString *commentType;
/**用户昵称*/
@property (nonatomic, copy) NSString *userNick;
/**用户头像*/
@property (nonatomic, copy) NSString *userAvatar;
/**语音时长*/
@property (nonatomic, copy) NSString *commentDuration;
/**是否停止播放音频*/
@property (nonatomic, assign) BOOL isStopAudio;

@end
