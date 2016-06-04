//
//  GLLiveRoomModel.h
//  revaluation_Bili
//
//  Created by mac on 16/5/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLiveRoomModel : NSObject

/** 播放地址 */
@property (nonatomic, strong) NSString *URL;

/** 直播房间id */
@property (nonatomic, strong) NSString *ROOMID;

/** 直播房间名称 */
@property (nonatomic, strong) NSString *ROOMTITLE;

/** 直播房间modal前占位视图-毛玻璃后面的 */
@property (nonatomic, strong) NSString *COVER;

/** mid */
@property (nonatomic, strong) NSString *MASTERID;

/** up的名称 */
@property (nonatomic, strong) NSString *ANCHOR_NICK_NAME;

/** 头像 */
@property (nonatomic, strong) NSString *face;

/** 小头像 */
@property (nonatomic, strong) NSString *m_face;

/** 在线人数 */
@property (nonatomic, strong) NSString *online;

/** 在线状态 PREPARING / LIVE */
@property (nonatomic, strong) NSString *LIVE_STATUS;

/** 字典里有tag字典 */
@property (nonatomic, strong) NSDictionary *meta;

/** 字典里具体的tag */
@property (nonatomic, strong) NSDictionary *tag;

/** 装有tag的数组 */
@property (nonatomic, strong) NSArray *tags;

/** 房间描述/公告 */
@property (nonatomic, strong) NSString *des;



//http://live.bilibili.com/api/room_info?_device=iphone&_hwid=234af756f0fca4b4&_ulv=10000&access_key=aa769b7fbfadf8a43d209a567792b1f7&appkey=27eb53fc9058f8c3&appver=3220&build=3220&buld=3220&platform=ios&room_id=48499&type=json&sign=6afad619d1d6c703918b2b9d6584ad7a

/** 尝试直接用手机抓的JSON链接因为没有秘钥 拼接 计算 sign ,改用 网页的数据拼接 房间公共简介JSON也是返回HTML信息,就使用网页http://live.bilibili.com/11783 数据 - 其他信息用 http://live.bilibili.com/live/getInfo?roomid=11783 
 
 http://static.hdslb.com/live-static/live-room/live-room.bundle.min.js?2016052701 计算在线人数的js【roomInfo.viewerCount】
 
 <span class="v-bottom dp-none" style="color: rgb(170, 170, 170); display: inline;">127 人</span>
 
 <!-- Avatar Image & Link. | 播主头像图片兼链接. --> 【style="background-image】
 
  <div class="tag-box" tags="金丝猴,卖萌">
 
 
 <div class="content-container" ms-html="roomIntro"> ‘—-》’ <!— Recommend Videos. | 推荐视频节点. -->
 
 */


///** 直播房间id */
//@property (nonatomic, strong) NSString *room_id;
//
///** 直播房间名称 */
//@property (nonatomic, strong) NSString *title;
//
///** 直播房间modal前占位视图-毛玻璃后面的 */
//@property (nonatomic, strong) NSString *cover;
//
///** mid */
//@property (nonatomic, strong) NSString *mid;
//
///** up的名称 */
//@property (nonatomic, strong) NSString *uname;
//
///** 头像 */
//@property (nonatomic, strong) NSString *face;
//
///** 小头像 */
//@property (nonatomic, strong) NSString *m_face;
//
///** 在线人数 */
//@property (nonatomic, strong) NSString *online;
//
///** 在线状态 PREPARING / LIVE */
//@property (nonatomic, strong) NSString *status;
//
///** 字典里有tag字典 */
//@property (nonatomic, strong) NSDictionary *meta;
//
///** 字典里具体的tag */
//@property (nonatomic, strong) NSDictionary *tag;
//
///** up的名称 */
//@property (nonatomic, strong) NSString *des;




@end
