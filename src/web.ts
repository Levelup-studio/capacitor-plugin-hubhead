import { WebPlugin } from '@capacitor/core';
import { HHPluginPlugin } from './definitions';

export class HHPluginWeb extends WebPlugin implements HHPluginPlugin {
  constructor() {
    super({
      name: 'HHPlugin',
      platforms: ['web'],
    });
  }
  notify(): never {
    throw this.unimplemented('Not implemented on web.');
  }
}

const HHPlugin = new HHPluginWeb();

export { HHPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(HHPlugin);
