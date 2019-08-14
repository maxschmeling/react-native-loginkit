module.exports = {
  dependency: {
    platforms: {
      ios: {},
      android: {
        packageInstance: 'new LoginKitPackage()',
        packageImportPath: 'import me.maxschmeling.reactnativeloginkit.LoginKitPackage;'
      }
    },
    assets: [],
    hooks: {}
  }
}