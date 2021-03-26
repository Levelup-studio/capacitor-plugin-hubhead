declare module '@capacitor/core' {
  interface PluginRegistry {
    HHPlugin: HHPluginPlugin;
  }
}

export interface HHPluginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
