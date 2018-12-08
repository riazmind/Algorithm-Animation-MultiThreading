//
//  InsertionSort.swift
//  AlgorithmAnimationAndMultiThreading
//

import Foundation

class InsertionSort {
    
    var arrayView: ArrayView
    let delay: UInt32 = 10_000
    
    init(_ arrayView: ArrayView) {
        self.arrayView = arrayView
    }
    
    func sort(_ a: inout [Int]) {
        var j: Int
        let N: Int = a.count
        
        for i in 0 ..< N {
            j = i
            
            // stop sorting if user select another sorting algoritm or change numbers in arrays. 
            if stopSorting {
                break
            }
            
            while j > 0 && a[j-1] > a[j] {
                a.swapAt(j-1, j)
                j -= 1
                
                DispatchQueue.main.async {
                    self.arrayView.setNeedsDisplay()
                }
                usleep(delay)
 
            } //while
            
        } //for
    }
    
}
