//
//  ViewController.swift
//  AlgorithmAnimationAndMultiThreading
//

/*
 Documentation:
 -------------
 
- This project has 6 main classes.
 
- Four classes are for sorting algorithms like Insertion, Selection, Quick and Merge Sorts.
 
- ArrayView class is used to animate the bar graph by using Quartz
 
- View Controller class is the main class where all functions handled. It calls all the selected sorting class based on the user selection. It also control the number of elements in array.
 
- queue.async is used to sort the array in background thread.

- DispatchQueue.main.async is used to display teh progress of sorting in bar graph.
 
- setNeedsDisplay() is used to refresh the interface on each sorting number in bar graph.
 
- usleep() is used to add interval to slow the animation for user view.
 
- IndicatorView is used to show sorting is working. It stop when sorting is done.
 
- The Quick and Merge sort takes time to show animation and sometimes slower than insertion sort and selection sort because Quick and Merge sorts are faster only for big number of arrays.
 
 - All the outlets are declared week optional type to break cyclic strong reference.
 
 */

import UIKit

var stopSorting: Bool = false

class ViewController: UIViewController {

    @IBOutlet weak var arrayView: ArrayView!
    @IBOutlet weak var arrayView2: ArrayView!
    @IBOutlet weak var indicator1: UIActivityIndicatorView!
    @IBOutlet weak var indicator2: UIActivityIndicatorView!
    
    let delay: UInt32 = 100_000
    var N: Int = 16
    var firstAlgorithm = "insertion"
    var secondAlgorithm = "insertion"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeGraph()
    }
    
    // Load elements in array
    func initializeGraph() {
        arrayView.data.removeAll()
        arrayView2.data.removeAll()
        
        for i in 0 ..< N {
            arrayView.data.append(i + 1)
            arrayView2.data.append(i + 1)
        }
        self.shuffle()
    }
    
    //shuffle the elements in array
    func shuffle() {
        var a = [Int]()
        a = self.arrayView.data
        let N = a.count
        
        for i in 0 ..< N {
            // choose index uniformly in [0, i]
            let r = Int(arc4random_uniform(UInt32(i + 1)))
            //ViewController.swap(&a[i], &a[r])
            a.swapAt(i, r)
        }
        
        self.arrayView.data = a
        self.arrayView2.data = a
        
        self.arrayView.setNeedsDisplay()
        self.arrayView2.setNeedsDisplay()
    }
    
    @IBAction func changeArraySize(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            N = 16
        case 1:
            N = 32
        case 2:
            N = 48
        case 3:
            N = 64
        default:
            N = 16
        }
        
        stopSorting = true
        usleep(delay) // sleep before initializing new graph otherwise array out of index arror.
        initializeGraph()
    }
    
    @IBAction func selectFirstAlgorithm(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            firstAlgorithm = "insertion"
        case 1:
            firstAlgorithm = "selection"
        case 2:
            firstAlgorithm = "quick"
        case 3:
            firstAlgorithm = "merge"
        default:
            firstAlgorithm = "insertion"
        }
        
        stopSorting = true
        usleep(delay) // sleep before shuffle new graph otherwise array out of index arror.
        self.shuffle()
    }
    
    @IBAction func selectSecondAlgorithm(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            secondAlgorithm = "insertion"
        case 1:
            secondAlgorithm = "selection"
        case 2:
            secondAlgorithm = "quick"
        case 3:
            secondAlgorithm = "merge"
        default:
            secondAlgorithm = "insertion"
        }
        
        stopSorting = true
        usleep(delay) // sleep before shuffle new graph otherwise array out of index arror.
        self.shuffle()
    }
    
    @IBAction func stopSortingNow(_ sender: UIButton) {
        stopSorting = true
    }
    
    @IBAction func shuffleArray(_ sender: UIButton) {
        stopSorting = true
        usleep(delay) // sleep before shuffle new graph otherwise array out of index arror.
        self.shuffle()
    }
    
    @IBAction func sortArray(_ sender: UIButton) {
    
        stopSorting = false
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        self.indicator1.startAnimating()
        self.indicator2.startAnimating()
        
        if firstAlgorithm == "insertion" {
            queue.async {
                let insertionSort: InsertionSort = InsertionSort(self.arrayView)
                insertionSort.sort(&self.arrayView.data)
                self.stopIndicator1()
            }
        }
        
        if secondAlgorithm == "insertion" {
            queue.async {
                let insertionSort: InsertionSort = InsertionSort(self.arrayView2)
                insertionSort.sort(&self.arrayView2.data)
                self.stopIndicator2()
            }
        }
        
        if firstAlgorithm == "selection" {
            queue.async {
                let selectionSort: SelectionSort = SelectionSort(self.arrayView)
                selectionSort.sort(&self.arrayView.data)
                self.stopIndicator1()
            }
        }
        
        if secondAlgorithm == "selection" {
            queue.async {
                let selectionSort: SelectionSort = SelectionSort(self.arrayView2)
                selectionSort.sort(&self.arrayView2.data)
                self.stopIndicator2()
            }
        }
        
        if firstAlgorithm == "quick" {
            queue.async {
                let quickSort: QuickSort = QuickSort(self.arrayView)
                quickSort.sort(&self.arrayView.data, 0, self.arrayView.data.count - 1)
                self.stopIndicator1()
            }
        }
        
        if secondAlgorithm == "quick" {
        queue.async {
                let quickSort: QuickSort = QuickSort(self.arrayView2)
                quickSort.sort(&self.arrayView2.data, 0, self.arrayView2.data.count - 1)
            self.stopIndicator2()
            }
        }
    
        if firstAlgorithm == "merge" {
            queue.async {
                let mergeSort: MergeSort = MergeSort(self.arrayView)
                mergeSort.sort(&self.arrayView.data)
                self.stopIndicator1()
            }
        }
        
        if secondAlgorithm == "merge" {
            queue.async {
                let mergeSort: MergeSort = MergeSort(self.arrayView2)
                mergeSort.sort(&self.arrayView2.data)
                self.stopIndicator2()
            }
        }
    }
    
    func stopIndicator1() {
        DispatchQueue.main.async {
            self.indicator1.stopAnimating()
        }
    }
    
    func stopIndicator2() {
        DispatchQueue.main.async {
            self.indicator2.stopAnimating()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
} //class

