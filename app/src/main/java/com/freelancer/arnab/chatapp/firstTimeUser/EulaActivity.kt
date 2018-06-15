package com.freelancer.arnab.chatapp.firstTimeUser

/**
 * Created by Arnab Kar on 12/06/18.
 * Email   : arnabrocking@gmail.com
 */

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.Button
import com.freelancer.arnab.chatapp.MainActivity
import com.freelancer.arnab.chatapp.R
import com.freelancer.arnab.chatapp.SharedPreferencesManager

class EulaActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_eula)

        val acceptEulaBtn = findViewById<Button>(R.id.acceptEula)
        acceptEulaBtn.setOnClickListener {
            SharedPreferencesManager.setInitialSetupDone(this@EulaActivity,true)
            val intent = Intent(this, MainActivity::class.java)
            startActivity(intent)
            finish()
        }
    }

}