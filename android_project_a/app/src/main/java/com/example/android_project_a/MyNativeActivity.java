package com.example.android_project_a;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import io.flutter.embedding.android.FlutterActivity;

public class MyNativeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_native);
    }

    public void onToFlutter1Click(View view) {
        Intent intent = new Intent(this, MyFlutterActivity.class);
        startActivity(intent);
    }

    public void onToFlutter2Click(View view) {
        Intent intent = new Intent(this, MyFlutterActivity2.class);
        startActivity(intent);
    }

    public void onToFlutter3Click(View view) {
        startActivity(FlutterActivity.withNewEngine().initialRoute("route2").build(this));
    }
}