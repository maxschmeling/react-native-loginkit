//
//  SnapchatLoginManager.swift
//  ReactNativeLoginKit
//
//  Created by Max Schmeling on 7/26/19.
//  Copyright © 2019 Max Schmeling. All rights reserved.
//

import SCSDKLoginKit

@objc(SnapchatLoginManager)
class SnapchatLoginManager: NSObject {
  @objc func login(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
   DispatchQueue.main.async {
     let viewController: UIViewController = UIApplication.shared.windows[0].rootViewController!;

     SCSDKLoginClient.login(from: viewController) { (success : Bool, error : Error?) in
       if (error != nil) {
         reject("UNKNOWN", error!.localizedDescription, nil);
       } else {
         let graphQLQuery = "{me{externalId, displayName, bitmoji{avatar}}}"
         
         let variables = ["page": "bitmoji"]

         SCSDKLoginClient.fetchUserData(withQuery: graphQLQuery, variables: variables, success: { (resources: [AnyHashable: Any]?) in
           guard let resources = resources,
             let data = resources["data"] as? [String: Any],
             let me = data["me"] as? [String: Any] else { return }

           let displayName = me["displayName"] as? String
           var bitmojiAvatarUrl: String?
           if let bitmoji = me["bitmoji"] as? [String: Any] {
             bitmojiAvatarUrl = bitmoji["avatar"] as? String
           }
           let externalId = me["externalId"] as? String

           let token = SCSDKLoginClient.getAccessToken()
           resolve([
             "displayName": displayName,
             "bitmojiAvatarUrl": bitmojiAvatarUrl,
             "externalId": externalId,
             "accessToken": token
           ]);
         }, failure: { (error: Error?, isUserLoggedOut: Bool) in
           reject("UNKNOWN", error!.localizedDescription, nil);
         });
       }
     }
   }
  }
}

