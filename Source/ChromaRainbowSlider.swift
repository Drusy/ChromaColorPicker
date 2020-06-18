//
//  ChromaRainbowSlider.swift
//  ChromaColorPicker
//
//  Created by Jon Cardasis on 4/13/19.
//  Copyright © 2019 Jonathan Cardasis. All rights reserved.
//

import UIKit
import CoreGraphics
import Foundation

extension CALayer {
    func colorOfPoint(point: CGPoint) -> CGColor {
        var pixel: [CUnsignedChar] = [0, 0, 0, 0]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context!.translateBy(x: -point.x, y: -point.y)
        
        self.render(in: context!)
        
        let red: CGFloat   = CGFloat(pixel[0]) / 255.0
        let green: CGFloat = CGFloat(pixel[1]) / 255.0
        let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
        let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
        
        let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
        
        return color.cgColor
    }
}

public class ChromaRainbowSlider: ChromaBrightnessSlider {
    
    public var colors: [UIColor] = [.white, .black] {
        didSet {
            updateGradientColors()
            updateHandleColor()
        }
    }
    public var handleColor: UIColor? = nil {
        didSet {
            updateHandleColor()
        }
    }
    
    override func commonInit() {
        super.commonInit()

        updateGradientColors()
        updateHandleColor()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        updateHandleColor()
    }
    
    override func updateHandleColor(from value: CGFloat) {
        updateHandleColor()
    }
    
    // MARK: -
    
    private func updateGradientColors() {
        sliderTrackView.gradientValues = colors
    }
    
    private func updateHandleColor() {
        var color: UIColor
        
        if let handleColor = handleColor {
            color = handleColor
        } else {
            let border = sliderTrackView.layer.borderWidth
            let x = min(max(0, handle.frame.midX + border), sliderTrackView.frame.maxX - border * 2)
            let y = sliderTrackView.frame.midY
            let cgColor = sliderTrackView.layer.colorOfPoint(point: CGPoint(x: x, y: y))
            
            color = UIColor(cgColor: cgColor)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        handle.handleColor = color
        CATransaction.commit()
    }
}
