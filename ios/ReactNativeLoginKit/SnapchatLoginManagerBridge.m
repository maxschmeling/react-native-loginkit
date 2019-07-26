//
//  SnapchatLoginManagerBridge.m
//  ReactNativeLoginKit
//
//  Created by Max Schmeling on 7/26/19.
//  Copyright © 2019 Max Schmeling. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapLoginManager, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_EXTERN_METHOD(login:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end

