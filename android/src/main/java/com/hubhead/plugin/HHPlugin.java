package com.hubhead.plugin;

import android.R;

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

import java.util.jar.Manifest;

@NativePlugin
public class HHPlugin extends Plugin {

    @PluginMethod
    public void echo(PluginCall call) {
        String body = call.getString("body");
        String title = call.getString("title");
        String tag = call.getString("tag");
        Notification notification = new NotificationCompat.Builder(getContext(), "0")
                    .setContentTitle(title)
                    .setContentText(body)
                    .setSmallIcon(getContext().getApplicationInfo().icon)
                    .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                    .build();
            NotificationManagerCompat manager = NotificationManagerCompat.from(getContext());
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                NotificationChannel channel = new NotificationChannel(
                        "0", "0", NotificationManager.IMPORTANCE_DEFAULT);
                manager.createNotificationChannel(channel);
            }
            manager.notify(tag, 0, notification);
    }
}
