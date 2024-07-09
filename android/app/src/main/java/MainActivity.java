package com.example.yourapp;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.mr.flutter.plugin.filepicker.FilePickerPlugin;
import vn.hunghd.flutter.plugins.imagecropper.ImageCropperPlugin; 

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        // flutterEngine.getPlugins().add(new FilePickerPlugin());
        flutterEngine.getPlugins().add(new ImageCropperPlugin());
    }
}