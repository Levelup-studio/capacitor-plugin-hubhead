import Foundation
import Capacitor
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(HHPlugin)
public class HHPlugin: CAPPlugin {
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
        var uuidString = UUID().uuidString
        var request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: nil)
        var notificationCenter = UNUserNotificationCenter.current().add(request)
    }
}
