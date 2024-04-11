//
//  ImageHelper.swift
//  MLExercise
//
//  Created by Nick Wang on 11/04/24.
//

import UIKit

struct FrameWithLabel {
    let frame: CGRect
    let label: String
}

class ImageHelper {
    public static func drawFramesWithLabel(frames: Array<FrameWithLabel>, uiImage: UIImage) -> UIImage {
        
        let margin: CGFloat = 10
        let color = CGColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        let fontSize: CGFloat = 32
        
        var bmp = uiImage
        autoreleasepool {
            let rendererFormat = UIGraphicsImageRendererFormat()
            rendererFormat.scale = 1
            let renderer = UIGraphicsImageRenderer(size : uiImage.size, format: rendererFormat)
            bmp = renderer.image { ctx in
                uiImage.draw(in: CGRect(x:0, y:0, width: uiImage.size.width, height: uiImage.size.height))
                ctx.cgContext.setLineWidth(2)
                
                let textTransform = CGAffineTransform(scaleX: 1.0, y: -1.0)
                ctx.cgContext.textMatrix = textTransform
                
                for frame in frames {
                    ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
                    ctx.cgContext.addRect(frame.frame)
                    ctx.cgContext.drawPath(using: .stroke)
                    
                    let fontName = "Verdana" as CFString
                    let font = CTFontCreateWithName(fontName, fontSize, nil)
                    
                    let attributes: [NSAttributedString.Key : Any] = [.font: font, .foregroundColor: color]
                    
                    // Text
                    let attributedString = NSAttributedString(string: frame.label,
                                                              attributes: attributes)
                    
                    // Render
                    let line = CTLineCreateWithAttributedString(attributedString)
                    let stringRect = CTLineGetImageBounds(line, ctx.cgContext)
                    
                    ctx.cgContext.setStrokeColor(UIColor.yellow.cgColor)
                    ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
                    ctx.cgContext.setTextDrawingMode(.fillStroke)
                    ctx.cgContext.textPosition = CGPoint(x: frame.frame.minX + margin, y: frame.frame.minY + margin + stringRect.height)
                    CTLineDraw(line, ctx.cgContext)
                }
            }
        }
        return bmp
    }
}
