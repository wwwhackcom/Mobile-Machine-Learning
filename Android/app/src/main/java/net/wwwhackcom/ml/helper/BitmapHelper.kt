package net.wwwhackcom.ml.helper

import android.content.Context
import android.graphics.BitmapFactory
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.graphics.asImageBitmap
import java.io.IOException

fun Context.assetsToBitmap(fileName: String): ImageBitmap? {
    return try {
        with(assets.open(fileName)) {
            BitmapFactory.decodeStream(this).asImageBitmap()
        }
    } catch (e: IOException) {
        e.printStackTrace()
        null
    }
}