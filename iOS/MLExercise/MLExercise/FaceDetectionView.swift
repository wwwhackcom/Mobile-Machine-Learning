//
//  FaceDetectionView.swift
//  MLExercise
//
//  Created by Nick Wang on 11/04/24.
//

import SwiftUI

struct FaceDetectionView: View {
    @State private var index = 1
    var body: some View {
        VStack {
            if let uiImage = UIImage(named: "FDImages/face_test_\(index).jpg") {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
            }
            HStack {
                Button(action: {
                    index = getIndex(index - 1)
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 30))
                        .tint(.secondary)
                })

                Button(action: {
                    
                }) {
                    Text("Decode")
                        .font(.title)
                        .padding(20)
                        .background(.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Button(action: {
                    index = getIndex(index + 1)
                }, label: {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 30))
                        .tint(.secondary)
                })
            }
            .padding()
        }
        .padding()
    }
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


struct FaceDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        FaceDetectionView()
    }
}
