//
//  QuickSort.swift
//  lgorithmAnimationAndMultiThreading
//

import Foundation

class QuickSort {
    
    var arrayView: ArrayView
    let delay: UInt32 = 10_000
    
    init(_ arrayView: ArrayView) {
        self.arrayView = arrayView
    }
    
    func partitionQuickSort(_ a: inout [Int], _ left: Int, _ right: Int) -> Int {
        
        var i: Int = left
        var j: Int = right
        var temp: Int
        let pivot: Int = a[(left + right)/2]
        
        while i <= j {
            
            // stop sorting if user select another sorting algoritm or change numbers in arrays.
            if stopSorting {
                break
            }
            
            while a[i] < pivot {
                i += 1;
            }
            
            while a[j] > pivot {
                j -= 1;
                
            }
            
            if i <= j {
                temp = a[i]
                a[i] = a[j]
                a[j] = temp
                i += 1
                j -= 1
            }
            
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
            }
            usleep(delay)
            
        } // while
        
        return i;
    }
    
    func sort(_ a: inout [Int], _ left: Int, _ right: Int) {
        
        // stop sorting if user select another sorting algoritm or change numbers in arrays.
        if stopSorting {
            return
        }
        
        let index: Int = partitionQuickSort(&a, left, right)
        
        if left < index - 1 {
            sort(&a, left, right - 1)
        }
        
        if index < right {
            sort(&a, index, right)
        }
    }
}
