const { NativeModules } = require("react-native");

const { SnapchatLoginManager } = NativeModules;

export function login(): Promise<void> {
  return SnapchatLoginManager.login();
}
