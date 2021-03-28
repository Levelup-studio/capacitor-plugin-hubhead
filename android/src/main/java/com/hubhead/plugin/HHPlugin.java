package com.hubhead.plugin;
import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import android.app.Notification;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.os.Bundle;

@NativePlugin
public class HHPlugin extends Plugin {
    @Override
    protected void handleOnNewIntent(Intent data) {
        super.handleOnNewIntent(data);
        Log.d("NS", "CUSTOM INTENT");
        Bundle bundle = data.getExtras();
        JSObject notificationJson = new JSObject();
        JSObject dataObject = new JSObject();
        if (bundle != null) {
            for (String key : bundle.keySet()) {
                if (key.equals("google.message_id")) {
                    notificationJson.put("id", bundle.get(key));
                } else {
                    Object value = bundle.get(key);
                    String valueStr = (value != null) ? value.toString() : null;
                    dataObject.put(key, valueStr);
                }
            }

            notificationJson.put("data", dataObject);
            JSObject actionJson = new JSObject();
            actionJson.put("actionId", "tap");
            actionJson.put("notification", notificationJson);
            notifyListeners("pushNotificationActionPerformed", actionJson, true);
        }
    }
    @PluginMethod
    public void notify(PluginCall call) {
        String body = call.getString("body");
        String title = call.getString("title");
        String tag = call.getString("tag");
        String data = call.getString("data");
        String displayStyle = call.getString("displayStyle");
        Integer priority = (displayStyle == "default") ? NotificationCompat.PRIORITY_LOW : NotificationCompat.PRIORITY_HIGH;
        Integer importance = (displayStyle == "default") ? NotificationManager.IMPORTANCE_LOW : NotificationManager.IMPORTANCE_HIGH;

        String packageName = getContext().getPackageName();
        Intent launchIntent = getContext().getPackageManager().getLaunchIntentForPackage(packageName);
        launchIntent.putExtra("jsonData", data);
        PendingIntent resultPendingIntent = PendingIntent.getActivity(
                getContext(),
                0,
                launchIntent,
                PendingIntent.FLAG_CANCEL_CURRENT
        );
        Notification notification = new NotificationCompat.Builder(getContext(), "3")
                .setContentTitle(title)
                .setContentText(body)
                .setSmallIcon(getContext().getApplicationInfo().icon)
                .setPriority(priority)
                .setContentIntent(resultPendingIntent)
                .build();
        NotificationManagerCompat manager = NotificationManagerCompat.from(getContext());
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    "3", "Foreground notifications", NotificationManager.IMPORTANCE_HIGH);
            manager.createNotificationChannel(channel);
        }
        manager.notify(tag, 0, notification);
    }
}
