module.exports = {
  dependency: {
    platforms: {
      ios: {},
      android: {
        packageInstance: 'LoginKitModule.getPackage()',
        packageImportPath: 'import me.maxschmeling.reactnativeloginkit.LoginKitModule;'
      }
    },
    assets: [],
    hooks: {}
  }
}