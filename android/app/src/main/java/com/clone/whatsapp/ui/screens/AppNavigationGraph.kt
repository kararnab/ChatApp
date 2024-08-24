package com.clone.whatsapp.ui.screens

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController

@Composable
fun AppNavigationGraph() {
    val navController = rememberNavController()
    NavHost(navController = navController, startDestination = Routes.CHAT_MASTER_SCREEN) {
        composable(Routes.CHAT_MASTER_SCREEN) {
            ChatMasterScreen()
        }
        composable(Routes.LOGIN_SCREEN) {
            LoginScreen()
        }
    }
}