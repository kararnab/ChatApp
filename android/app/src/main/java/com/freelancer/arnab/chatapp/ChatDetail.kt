package com.freelancer.arnab.chatapp

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar

import kotlinx.android.synthetic.main.activity_chat_detail.*

class ChatDetail : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_chat_detail)

        setToolbarTitle(toolbar,intent.getStringExtra("userOrGroupName"))
        setSupportActionBar(toolbar)


        supportActionBar?.setDisplayHomeAsUpEnabled(true)

    }

    private fun setToolbarTitle(toolbar: Toolbar?,title: String){
        toolbar?.title = title
    }

}