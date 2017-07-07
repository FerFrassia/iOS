package com.avenida_cabildo.avenida_cabildo;

import android.content.Intent;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseUser;

public class ActivitySplash extends AppCompatActivity {

    private Handler handler;
    private Runnable runnable;
    private long delay_time;
    private long time = 1000L;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(com.avenida_cabildo.avenida_cabildo.R.layout.a_splash);
        getSupportActionBar().hide();

        handler = new Handler();

        runnable = new Runnable() {
            public void run() {
                entrar();
            }
        };
    }

    @Override
    public void onResume() {
        super.onResume();
        delay_time = time;
        handler.postDelayed(runnable, delay_time);
        time = System.currentTimeMillis();
    }

    @Override
    public void onPause() {
        super.onPause();
        handler.removeCallbacks(runnable);
        time = delay_time - (System.currentTimeMillis() - time);
    }

    private void entrar(){
        FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
        Intent intent;
        if(user != null){
            intent = new Intent(this, ActivityMain.class);
        }else{
            intent = new Intent(this, ActivityLogin.class);
        }

        startActivity(intent);
        finish();
    }

}
