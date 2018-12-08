//
//  ArrayView.swift
//  AlgorithmAnimationAndMultiThreading
//

import UIKit

class ArrayView: UIView {
    
    @IBInspectable var color: UIColor = UIColor.green
    
    var data = [Int]()
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if data.count > 0 {
            let gap = 2
            let w = Int(bounds.width) / data.count - gap
            let h = Int(bounds.height) / data.count
            context.setFillColor(color.cgColor)
            
            for i in 0 ..< data.count {
                context.fill(CGRect(x: i * (w + gap), y: Int(bounds.height), width: w, height: -data[i] * h))
            }
        }
    } //draw
    
}



