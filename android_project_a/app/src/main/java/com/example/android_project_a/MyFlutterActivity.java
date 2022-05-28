package com.example.android_project_a;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;

public class MyFlutterActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_flutter);
    }
}