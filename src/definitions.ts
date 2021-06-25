declare module '@capacitor/core' {
  interface PluginRegistry {
    HHPlugin: HHPluginPlugin;
  }
}

export interface HHPluginPlugin {
  notify(): never;
  enableNavigationGestures(): never;
  disableNavigationGestures(): never;
  setUserDefaults(): never;
  listenUserDefaults(): never;
  vibrate(): never;
}
