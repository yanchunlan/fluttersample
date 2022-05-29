package com.example.android_project_a;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MyNativeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_native);
    }

    public void onToFlutterClick(View view) {
        Intent intent = new Intent(this, MyFlutterActivity.class);
        startActivity(intent);
    }
}