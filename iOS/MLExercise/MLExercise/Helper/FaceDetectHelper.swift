//
//  FaceDetectHelper.swift
//  MLExercise
//
//  Created by Nick Wang on 11/04/24.
//

import Foundation
import MLKitFaceDetection
import MLKitVision


class FaceDetectHelper {
    
    private lazy var faceDetector = FaceDetector.faceDetector(options: faceDetectorOption)
    
    private lazy var faceDetectorOption: FaceDetectorOptions = {
        let option = FaceDetectorOptions()
        option.contourMode = .none
        option.performanceMode = .accurate
        return option
    }()
    
    func runFaceDetection(with image: UIImage, completion: @escaping (UIImage) -> ()) {
        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation
        faceDetector.process(visionImage) { faces, error in
            guard error == nil, let faces = faces, !faces.isEmpty else {
                return
            }
            
            var frames = [FrameWithLabel]()
            for (index, face) in faces.enumerated() {
                frames.append(FrameWithLabel(frame: face.frame, label: "\(index + 1)"))
            }
            completion(ImageHelper.drawFramesWithLabel(frames: frames, uiImage: image))
        }
    }
}
