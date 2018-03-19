//
//  URLDefine.h
//  OilCardRecyle
//
//  Created by dingxin on 2018/1/25.
//  Copyright © 2018年 dingxin. All rights reserved.
//

#ifndef URLDefine_h
#define URLDefine_h

//获取新闻内容  POST
#define kGetNewsInfoDetail @"/GetNewsInfoDetail"
//获取新闻列表
#define kGetNewsInfoList @"/GetNewsInfoList"
//(获取机构服务内容)
#define kGetOrgService @"/GetOrgService"
//获取机构信息
#define kGetOrgInfo @"/GetOrgInfo"
//申请贷款服务
#define kApplyOrgService @"/ApplyOrgService"
//发布需求
#define kPublishDemand @"/PublishDemand"
//获取需求列表
#define kGetDmdList @"/GetDmdList"
//GetEvaluateInfo(获取某项服务的评价)
#define kGetEvaluateInfo @"/GetEvaluateInfo"
//GetEvaluateReply(获取某项服务评价的回复)
#define kGetEvaluateReply @"/GetEvaluateReply"
//PublishEvaluate(发布评价)
#define kPublishEvaluate @"/PublishEvaluate"
//LinkEvaluate(点赞评价)
#define kLinkEvaluate @"/LinkEvaluate"
//PublishReply(发布评价回复)
#define kPublishReply @"/PublishReply"
//GetOrgServiceList(获取机构服务列表)
#define kGetOrgServiceList @"/GetOrgServiceList"
//SetArticlePageView(增加文章浏览量)
#define kSetArticlePageView @"/SetArticlePageView"
//SetServicePageView(增加机构服务浏览量)
#define kSetServicePageView @"/SetServicePageView"
//GetAttachmentList(获取机构服务的附件)
#define kGetAttachmentList @"/GetAttachmentList"
//GetServiceCategory(获取服务类别)
#define kGetServiceCategory @"/GetServiceCategory"
//GetOrgServiceList(获取机构服务列表)
#define kGetOrgServiceList @"/GetOrgServiceList"
//GetServiceCollect(获取收藏服务)
#define kGetServiceCollect @"/GetServiceCollect"
//AddServiceCollect(添加服务到收藏表)
#define kAddServiceCollect @"/AddServiceCollect"
//GetCompanyInfo(获取小薇企业列表)
#define kGetCompanyInfo @"/GetCompanyType"
//SetServiceLink(增加机构服务点赞数量)
#define kSetServiceLink @"/SetServiceLink"
//增加文章浏览量
#define kSetArticlePageView @"/SetArticlePageView"
//GetDmdInfo(获取需求信息)
#define kGetDmdInfo @"/GetDmdInfo"
//注册企业服务商
#define kRegisterUser @"/RegisterUser"
//注册小微企业
#define kRegisterComUser @"/RegisterComUser"
//注册一般用户
#define kRegisterGeneralUser @"/RegisterGeneralUser"
//检查用户是否在企业数据表里
#define kCheckCompnay @"/CheckCompnay"
//
#define kGetCompanyType @"/GetCompanyType"
//获取用户信息
#define kGetUserInfo @"/GetUserInfo"
//修改用户信息
#define kUpdateUserInfo @"/SaveUserInfo"
//验证是否可以点赞
#define kValidateLike @"/ValidateLike"
//登录
#define kLogin @"/Login"
//忘记密码
#define KForgetPwd @"/ForgotPwd"

#endif /* URLDefine_h */
