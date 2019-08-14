const { NativeModules } = require("react-native");

const { SnapchatLoginManager } = NativeModules;

module.exports.login = SnapchatLoginManager && SnapchatLoginManager.login;
