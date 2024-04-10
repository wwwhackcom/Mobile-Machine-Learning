package net.wwwhackcom.ml.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material3.Button
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import net.wwwhackcom.ml.helper.assetsToBitmap
import net.wwwhackcom.ml.ui.theme.MLExerciseTheme

@Composable
fun FaceDetectionScreen(modifier: Modifier = Modifier) {
    Column(
        modifier = modifier
            .fillMaxSize()
            .background(Color.LightGray),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        val context = LocalContext.current
        val coroutineScope = rememberCoroutineScope()
        var imageBitmap by remember { mutableStateOf<ImageBitmap?>(null) }
        var fileIndex by remember { mutableIntStateOf(1) }

        LaunchedEffect(Unit) {
            withContext(Dispatchers.IO) {
                imageBitmap = context.assetsToBitmap("face_test_$fileIndex.jpg")
            }
        }

        imageBitmap?.let {
            Image(
                bitmap = it,
                contentDescription = "face_pic",
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(it.width.toFloat() / it.height.toFloat())
            )
        }

        Row(
            verticalAlignment = Alignment.CenterVertically
        ) {
            IconButton(
                onClick = {
                    fileIndex = getIndex(fileIndex - 1)
                    coroutineScope.launch(Dispatchers.IO) {
                        imageBitmap = context.assetsToBitmap("face_test_$fileIndex.jpg")
                    }
                },
                modifier = Modifier.size(48.dp)
            ) {
                Icon(
                    Icons.AutoMirrored.Filled.ArrowBack,
                    contentDescription = "Back"
                )
            }
            Button(
                modifier = Modifier.padding(20.dp),
                onClick = {

                }
            ) {
                Text("Detect")
            }

            IconButton(
                onClick = {
                    fileIndex = getIndex(fileIndex + 1)
                    coroutineScope.launch(Dispatchers.IO) {
                        imageBitmap = context.assetsToBitmap("face_test_$fileIndex.jpg")
                    }
                },
                modifier = Modifier.size(48.dp)
            ) {
                Icon(
                    Icons.AutoMirrored.Filled.ArrowForward,
                    contentDescription = "Next"
                )
            }
        }
    }
}

private fun getIndex(index: Int, minIndex: Int = 1, maxIndex: Int = 5): Int {
    return when {
        index < minIndex -> maxIndex
        index > maxIndex -> minIndex
        else -> index
    }
}

@Preview(showBackground = true)
@Composable
fun FaceDetectionScreenPreview() {
    MLExerciseTheme {
        FaceDetectionScreen()
    }
}