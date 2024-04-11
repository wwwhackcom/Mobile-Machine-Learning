//
//  FaceDetectionView.swift
//  MLExercise
//
//  Created by Nick Wang on 11/04/24.
//

import SwiftUI

struct FaceDetectionView: View {
    
    @State private var selectedUiImage: UIImage?
    @State private var index = 1
    private let faceDetector = FaceDetectHelper()
    
    var body: some View {
        ZStack {
            VStack {
                if let uiImage = selectedUiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width)
                    
                    HStack {
                        Button(action: {
                            selectedUiImage = getImage(index - 1)
                        }, label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 30))
                                .tint(.secondary)
                        })
                        
                        Button(action: {
                            faceDetector.runFaceDetection(with: uiImage) { finalImage in
                                Task { @MainActor in
                                    selectedUiImage = finalImage
                                }
                            }
                        }) {
                            Text("Decode")
                                .font(.title)
                                .padding(20)
                                .background(.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button(action: {
                            selectedUiImage = getImage(index + 1)
                        }, label: {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 30))
                                .tint(.secondary)
                        })
                    }
                    .padding()
                }
            }
        }
        .padding()
        .onAppear(perform: {
            selectedUiImage = getImage(2)
        })
    }
    
    private func getIndex(_ index: Int, minIndex: Int = 1, maxIndex: Int = 5) -> Int {
        if index < minIndex {
            return maxIndex
        } else if index > maxIndex {
            return minIndex
        } else {
            return index
        }
    }
    
    private func getImage(_ idx: Int) -> UIImage {
        index = getIndex(idx)
        return UIImage(named: "FDImages/face_test_\(index).jpg")!
    }
}

struct FaceDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FaceDetectionView()
    }
}
