package com.clone.core.components

import androidx.annotation.DrawableRes
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun Logo(
    @DrawableRes id: Int,
    contentDescription: String = "Logo",
    size: Dp = 100.dp
) {
    Image(
        painter = painterResource(id),
        contentDescription,
        modifier = Modifier
            .size(size)
            .padding(8.dp)
    )
}