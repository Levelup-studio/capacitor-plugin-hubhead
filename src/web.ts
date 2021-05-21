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
    throw 'Not implemented on web.';
  }
  enableNavigationGestures(): never {
    throw 'Not implemented on web.';
  }
  disableNavigationGestures(): never {
    throw 'Not implemented on web.';
  }
  vibrate(): never {
    throw 'Not implemented on web.';
  }
}

const HHPlugin = new HHPluginWeb();

export { HHPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(HHPlugin);
