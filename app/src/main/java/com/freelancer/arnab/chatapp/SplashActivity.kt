package com.freelancer.arnab.chatapp

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import com.freelancer.arnab.chatapp.firstTimeUser.EulaActivity

class SplashActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent: Intent = if (SharedPreferencesManager.getInitialSetupDone(this)) {
            Intent(this, MainActivity::class.java)
        } else {
            Intent(this, EulaActivity::class.java)
        }

        startActivity(intent)
        finish()
    }
}