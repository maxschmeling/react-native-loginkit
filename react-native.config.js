module.exports = {
  dependency: {
    platforms: {
      ios: {},
      android: {
        packageInstance: 'ReactNativeLoginKit.getPackage()',
        packageImportPath: 'import me.maxschmeling.reactnativeloginkit.LoginKitModule;'
      }
    },
    assets: [],
    hooks: {}
  }
}