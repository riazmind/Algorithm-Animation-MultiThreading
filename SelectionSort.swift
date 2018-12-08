//
//  SelectionSort.swift
//  AlgorithmAnimationAndMultiThreading
//

import Foundation

class SelectionSort {
    
    var arrayView: ArrayView
    let delay: UInt32 = 10_000
    
    init(_ arrayView: ArrayView) {
        self.arrayView = arrayView
    }
    
    func sort(_ a: inout [Int]) {
        
        var index: Int
        var smallerNumber: Int
        let N: Int = a.count
        
        for i in 0 ..< N - 1 {
            index = i
            
            // stop sorting if user select another sorting algoritm or change numbers in arrays.
            if stopSorting {
                break
            }
            
            for j in i + 1 ..< N {
                
                if a[j] < a[index] {
                    index = j;//searching for lowest index
                }
            }
            
            smallerNumber = a[index];
            a[index] = a[i];
            a[i] = smallerNumber;
            
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
            }
            usleep(delay)
            
        }
    }
    
}
