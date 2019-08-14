package me.maxschmeling.reactnativeloginkit;

import androidx.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.snapchat.kit.sdk.SnapLogin;
import com.snapchat.kit.sdk.core.controller.LoginStateController;
import com.snapchat.kit.sdk.login.models.MeData;
import com.snapchat.kit.sdk.login.models.UserDataResponse;
import com.snapchat.kit.sdk.login.networking.FetchUserDataCallback;

public class LoginKitModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public LoginKitModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "LoginKit";
    }

    @ReactMethod
    public void login(Promise callback) {
        final LoginStateController.OnLoginStateChangedListener loginStateChangedListener =
            new LoginStateController.OnLoginStateChangedListener() {
            @Override
            public void onLoginSucceeded() {
                SnapLogin.getLoginStateController(getReactApplicationContext()).removeOnLoginStateChangedListener(this);

                String query = "{me{bitmoji{avatar},displayName,externalId}}";
                SnapLogin.fetchUserData(getReactApplicationContext(), query, null, new FetchUserDataCallback() {
                    @Override
                    public void onSuccess(@Nullable UserDataResponse userDataResponse) {
                        if (userDataResponse == null || userDataResponse.getData() == null) {
                            promise.reject("No userDataResponse data.");
                            return;
                        }

                        MeData meData = userDataResponse.getData().getMe();
                        if (meData == null) {
                            promise.reject("No meData.");
                            return;
                        }


                        WritableMap result = Arguments.createMap();

                        result.putString("displayName", meData.getDisplayName());
                        result.putString("bitmojiAvatarUrl", meData.getBitmojiData().getAvatar());
                        result.putString("externalId", meData.getExternalId());
                        result.putString("accessToken", SnapLogin.getAuthTokenManager(getReactApplicationContext()).getAccessToken());

                        promise.resolve(result);
                    }

                    @Override
                    public void onFailure(boolean isNetworkError, int statusCode) {
                        promise.reject("Unknown Error");
                    }
                });
            }

            @Override
            public void onLoginFailed() {
                SnapLogin.getLoginStateController(getReactApplicationContext()).removeOnLoginStateChangedListener(this);
                promise.reject("Unknown Error");
            }

            @Override
            public void onLogout() {
                // Not applicable in this context
            }
        };

        SnapLogin.getLoginStateController(getReactApplicationContext())
                .addOnLoginStateChangedListener(loginStateChangedListener);

        SnapLogin.getAuthTokenManager(getReactApplicationContext()).startTokenGrant();
    }
}
