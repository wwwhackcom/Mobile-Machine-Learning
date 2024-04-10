package net.wwwhackcom.ml.helper

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.face.Face
import com.google.mlkit.vision.face.FaceDetection
import com.google.mlkit.vision.face.FaceDetectorOptions

fun processFaceDetection(
    bitmap: Bitmap,
    onSuccessListener: ((List<Face>) -> Unit),
    onFailListener: ((Exception) -> Unit)
) {
    val highAccuracyOpts = FaceDetectorOptions.Builder()
        .setPerformanceMode(FaceDetectorOptions.PERFORMANCE_MODE_FAST)
        .build()

    val detector = FaceDetection.getClient(highAccuracyOpts)
    val image = InputImage.fromBitmap(bitmap, 0)
    detector.process(image)
        .addOnSuccessListener { faces ->
            onSuccessListener(faces)
        }
        .addOnFailureListener { e ->
            onFailListener(e)
        }
}


fun Bitmap.drawWithRectangle(faces: List<Face>): Bitmap? {
    val bitmap = copy(config, true)
    val canvas = Canvas(bitmap)
    for (face in faces) {
        val bounds = face.boundingBox
        Paint().apply {
            color = Color.RED
            style = Paint.Style.STROKE
            strokeWidth = 4.0f
            isAntiAlias = true
            canvas.drawRect(
                bounds,
                this
            )
        }
    }
    return bitmap
}
