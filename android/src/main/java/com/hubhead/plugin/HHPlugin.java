package com.hubhead.plugin;
import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;
import android.app.NotificationChannel;
import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;

@NativePlugin
public class HHPlugin extends Plugin {

    @PluginMethod
    public void notify(PluginCall call) {
        String body = call.getString("body");
        String title = call.getString("title");
        String tag = call.getString("tag");
        String displayStyle = call.getString("displayStyle");
        Integer priority = (displayStyle == "default") ? NotificationCompat.PRIORITY_LOW : NotificationCompat.PRIORITY_HIGH;
        Integer importance = (displayStyle == "default") ? NotificationManager.IMPORTANCE_LOW : NotificationManager.IMPORTANCE_HIGH;
        Notification notification = new NotificationCompat.Builder(getContext(), "3")
                .setContentTitle(title)
                .setContentText(body)
                .setSmallIcon(getContext().getApplicationInfo().icon)
                .setPriority(priority)
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
