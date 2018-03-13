//
//  RWSoundManager.m
//  ucupay
//
//  Created by dingxin on 2017/10/2.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "RWSoundManager.h"

@implementation RWSoundManager
static RWSoundManager *_sharedInstance;
static RWSoundManager *_sharedInstanceForSound;
+(id)sharedInstanceForVibrate
{
    
    @synchronized ([RWSoundManager class]) {
        
        if (_sharedInstance == nil) {
            
            _sharedInstance = [[RWSoundManager alloc] initForPlayingVibrate];
            
        }
    }
    return _sharedInstance;
    
}
+ (id) sharedInstanceForSound
{
    @synchronized ([RWSoundManager class]) {
        
        if (_sharedInstanceForSound == nil) {
            
            _sharedInstanceForSound = [[RWSoundManager alloc] initForPlayingSystemSoundEffectWith:@"sms-received2" ofType:@"caf"];
            
        }
    }
    return _sharedInstanceForSound;
}
-(id)initForPlayingVibrate
{
    self=[super init];
    
    if(self){
        
        soundID=kSystemSoundID_Vibrate;
    }
    return self;
}

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self=[super init];
    
    if(self){
        
        //        NSString *path=[[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",resourceName,type];
        if(path){
            
            SystemSoundID theSoundID;
            
            OSStatus error =AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&theSoundID);
            
            if(error == kAudioServicesNoError){
                
                soundID=theSoundID;
            }else{
                
                NSLog(@"Failed to create sound");
                
            }
            
        }
        
    }
    return  self;
}
-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    self=[super init];
    if(self){
        
        NSURL *fileURL=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if(fileURL!=nil){
            
            SystemSoundID theSoundID;
            
            OSStatus error=AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            
            if(error ==kAudioServicesNoError){
                
                soundID=theSoundID;
            }else{
                
                NSLog(@"Failed to create sound");
                
            }
        }
    }
    
    return self;
    
}
-(void)play
{
    AudioServicesPlaySystemSound(soundID);
}
-(void)cancleSound
{
    _sharedInstance=nil;
    //AudioServicesRemoveSystemSoundCompletion(soundID);
}
-(void)dealloc
{
    
    AudioServicesDisposeSystemSoundID(soundID);
}

+ (void)palySoundName:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
}
void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    
}

@end
