package com.example.android_project_a;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import io.flutter.facade.Flutter;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        View FlutterView = Flutter.createView(this, getLifecycle(), "defaultRoute"); //传入路由标识符
        setContentView(FlutterView);//用FlutterView替代Activity的ContentView
    }
}