#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapchatLoginManager, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_EXTERN_METHOD(login:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end

