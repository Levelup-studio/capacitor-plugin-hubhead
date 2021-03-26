import { WebPlugin } from '@capacitor/core';
import { HHPluginPlugin } from './definitions';

export class HHPluginWeb extends WebPlugin implements HHPluginPlugin {
  constructor() {
    super({
      name: 'HHPlugin',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const HHPlugin = new HHPluginWeb();

export { HHPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(HHPlugin);
