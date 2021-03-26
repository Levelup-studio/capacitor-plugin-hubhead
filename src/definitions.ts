declare module '@capacitor/core' {
  interface PluginRegistry {
    HHPlugin: HHPluginPlugin;
  }
}

export interface HHPluginPlugin {
  notify(): never;
}
