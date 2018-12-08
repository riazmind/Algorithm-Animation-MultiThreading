//
//  MergeSort.swift
//  AlgorithmAnimationAndMultiThreading
//

import Foundation

class MergeSort {
    
    var arrayView: ArrayView
    let delay: UInt32 = 10_000
    
    init(_ arrayView: ArrayView) {
        self.arrayView = arrayView
    }
    
    // Places the elements of the given array into sorted order
    // using the merge sort algorithm.
    // post: array is in sorted (nondecreasing) order
    func sort(_ a: inout [Int]) {
        
        // stop sorting if user select another sorting algoritm or change numbers in arrays.
        if stopSorting {
            return
        }
        
        if a.count > 1 {
            // split array into two halves
            var left: [Int] = leftHalf(&a);
            var right: [Int] = rightHalf(&a);
            
            // recursively sort the two halves
            sort(&left);
            sort(&right);
            
            // merge the sorted halves into a sorted whole
            merge(&a, &left, &right);
        }
    }
    
    // Returns the first half of the given array.
    func leftHalf(_ a: inout [Int]) -> [Int]{
        let size1: Int = a.count / 2;
        var left = [Int] (repeating: 0, count: size1)
        
        for i in 0 ..< size1 {
            left[i] = a[i];
        }
        
        return left;
    }
    
    // Returns the second half of the given array.
    func rightHalf(_ a: inout [Int]) -> [Int] {
        
        let size1: Int = a.count / 2;
        let size2: Int = a.count - size1;
        var right = [Int] (repeating: 0, count: size2)
        
        for i in 0 ..< size2 {
            right[i] = a[i + size1];
        }
        
        return right;
    }
    
    // Merges the given left and right arrays into the given
    // result array.  Second, working version.
    // pre : result is empty; left/right are sorted
    // post: result contains result of merging sorted lists;
    func merge(_ result: inout [Int], _ left: inout [Int], _ right: inout [Int]) {
        var i1: Int = 0 // index into left array
        var i2: Int = 0 // index into right array
        let N: Int = result.count
        
        for i in 0 ..< N {
            
            // stop sorting if user select another sorting algoritm or change numbers in arrays.
            if stopSorting {
                break
            }
            
            if i2 >= right.count || (i1 < left.count && left[i1] <= right[i2]) {
                result[i] = left[i1]
                i1 += 1;
            } else {
                result[i] = right[i2] // take from right
                i2 += 1;
            }
            
            DispatchQueue.main.async {
                self.arrayView.setNeedsDisplay()
            }
            usleep(delay)
            
        } // FOR
    }
    
} //class
