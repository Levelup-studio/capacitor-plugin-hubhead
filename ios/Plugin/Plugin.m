#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(HHPlugin, "HHPlugin",
           CAP_PLUGIN_METHOD(notify, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(enableNavigationGestures, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(setUserDefaults, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(listenUserDefaults, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(disableNavigationGestures, CAPPluginReturnPromise);
)
