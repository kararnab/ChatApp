package com.freelancer.arnab.chatapp;

import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by Arnab Kar on 11/06/18.
 * Email   : arnabrocking@gmail.com
 */
public class SharedPreferencesManager {

    private static final String APP_CREDENTIALS = "app_credentials";


    // properties
    private static final String INITIAL_SETUP_DONE = "initialSetupDone";
    // add other properties here...


    private SharedPreferencesManager() {}

    private static SharedPreferences getSharedPreferences(Context context) {
        return context.getSharedPreferences(APP_CREDENTIALS, Context.MODE_PRIVATE);
    }

    public static Boolean getInitialSetupDone(Context context) {
        return getSharedPreferences(context).getBoolean(INITIAL_SETUP_DONE , false);
    }

    public static void setInitialSetupDone(Context context, Boolean newValue) {
        final SharedPreferences.Editor editor = getSharedPreferences(context).edit();
        editor.putBoolean(INITIAL_SETUP_DONE , newValue);
        editor.apply();
    }

    // other getters/setters
}