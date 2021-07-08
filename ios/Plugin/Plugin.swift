import Foundation
import Capacitor
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
extension UserDefaults
{
    @objc dynamic var sync: String
    {
        get {
            return string(forKey: "sync") ?? ""
        }
        set {
            set(newValue, forKey: "sync")
        }
    }
}
@objc(HHPlugin)
public class HHPlugin: CAPPlugin {
    let sharedDefaults = UserDefaults(suiteName: "group.hubhead.application");
    private var observer: NSKeyValueObservation?
    @objc func notify(_ call: CAPPluginCall) {
        let content = UNMutableNotificationContent()
        let body = call.getString("body") ?? ""
        let title = call.getString("title") ?? ""
        let data = call.getObject("data") ?? [:]
        let tag = call.getString("tag") ?? ""
        content.title = title
        content.body = body
        content.userInfo = data
        content.threadIdentifier = tag
        content.categoryIdentifier = tag
        var request = UNNotificationRequest(identifier: tag,
                    content: content, trigger: nil)
        var notificationCenter = UNUserNotificationCenter.current().add(request)
    }
    @objc func setUserDefaults(_ call: CAPPluginCall) {
        let group = call.getString("group") ?? "";
        let key = call.getString("key") ?? "";
        let value = call.getString("value") ?? "";
        sharedDefaults?.set(value, forKey: key);
    }
    @objc func listenUserDefaults(_ call: CAPPluginCall) {
        observer = sharedDefaults?.observe(\.sync, options: [.new, .old, .initial]) { _,_ in
            self.notifyListeners("sync", data: [:]);
        }
    }
    @objc func enableNavigationGestures(_ call: CAPPluginCall) {
        self.bridge.getWebView()?.allowsBackForwardNavigationGestures = true;
    }
    @objc func disableNavigationGestures(_ call: CAPPluginCall) {
        self.bridge.getWebView()?.allowsBackForwardNavigationGestures = false;
    }
    @objc func readAllNotifications(_ call: CAPPluginCall) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications();
    }
    @objc func setBadge(_ call: CAPPluginCall) {
        let count = call.getInt("count", 0);
        let content = UNMutableNotificationContent();
        content.badge = count as? NSNumber;
        var request = UNNotificationRequest(identifier: "badge",
                                            content: content, trigger: nil);
        var notificationCenter = UNUserNotificationCenter.current().add(request);
    }
}
