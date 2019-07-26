#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SnapLoginManager, NSObject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

RCT_EXTERN_METHOD(login:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end

