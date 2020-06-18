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

public class ChromaRainbowSlider: ChromaBrightnessSlider {
    
    public var colors: [UIColor] = [.white, .black]
    public var handleColor: UIColor = .white
    
    override func commonInit() {
        super.commonInit()

        sliderTrackView.gradientValues = colors
    }
    
    override func updateControl(to value: CGFloat) {
        super.updateControl(to: value)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        handle.handleColor = handleColor
        CATransaction.commit()
    }
}
