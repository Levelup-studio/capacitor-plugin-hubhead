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
    // метод для отправки локальных нотификаций из js
    // сейчас не используется
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
    // позволяет записать UserDefaults нужно для того чтобы синхронизировать js и сервис нотификаций
    // например когда сервису нужно знать если открыта карточка и чат отскроллен (значит пуш прочитается сразу)
    @objc func setUserDefaults(_ call: CAPPluginCall) {
        let group = call.getString("group") ?? "";
        let key = call.getString("key") ?? "";
        let value = call.getString("value") ?? "";
        sharedDefaults?.set(value, forKey: key);
    }
    // этот листенер кидает ивент на любые изменения в UserDefaults
    @objc func listenUserDefaults(_ call: CAPPluginCall) {
        observer = sharedDefaults?.observe(\.sync, options: [.new, .old, .initial]) { _,_ in
            self.notifyListeners("sync", data: [:]);
        }
    }
     // включить history back по свайпу от левого края
    @objc func enableNavigationGestures(_ call: CAPPluginCall) {
        self.bridge.getWebView()?.allowsBackForwardNavigationGestures = true;
    }
    // выключить history back по свайпу от левого края
    @objc func disableNavigationGestures(_ call: CAPPluginCall) {
        self.bridge.getWebView()?.allowsBackForwardNavigationGestures = false;
    }
    // прочитывает все нотификации которые есть в Notification Centre
    @objc func readAllNotifications(_ call: CAPPluginCall) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications();
    }
    // выставляет бейдж (красный круг с цифрой рядом с иконкой)
    // сейчас не используется
    @objc func setBadge(_ call: CAPPluginCall) {
        let count = call.getInt("count", 0);
        let content = UNMutableNotificationContent();
        content.badge = count as? NSNumber;
        var request = UNNotificationRequest(identifier: "badge",
                                            content: content, trigger: nil);
        var notificationCenter = UNUserNotificationCenter.current().add(request);
    }
}
