# Algorithm-Animation-MultiThreading

- Animate various sorting algorithms for Insertion, Selection, Quick and Merge Sorts. 
- Building an app that uses the dispatch queues for multi-threading. 
- Following the best practices in memory management to ensure no cyclic strong
references.
- Develop an iOS app that animates various sorting algorithms. 
- The two views can animate two different algorithms simultaneously using the same data.

Before Sorting:  
![N|Solid](https://github.com/riazmind/Algorithm-Animation-MultiThreading/blob/master/screenshots/afterSorting.png)

After Sorting: 
![N|Solid](https://github.com/riazmind/Algorithm-Animation-MultiThreading/blob/master/screenshots/beforeSorting.png)


## Specific Requirements
1. Implement several common sorting algorithms to sort an array of integers.
2. Select the algorithms and the size of the array. The data in the array to be sorted are randomly generated (shuffled) each time.
3. Animate thep rogress of the sorting algorithms by displaying the state of the array being sorted in a fashion similar to what is in the sample UI. Add small delays in the algorithms so that the progress is observable at a comfortable pace.
4. Use a dispatch queue to execute the sorting algorithms on a thread other than the main thread.

## The software design of your app, including diagrams of the key components (classes) and their relations.
- This assignment has 6 main classes.
- Four Classes are for sorting algorithms like Insertion, Selection, Quick and Merge Sorts.
- ArrayView class is used to animate the bar graph by using Quartz
- View Controller class is the main class where all functions handled. It calls all the selected sorting class based on the user selection. It also controls the number of elements in array.
- queue.async is used to sort the array in background thread.
- DispatchQueue.main.async is used to display the progress of sorting in bar graph.
- setNeedsDisplay() is used to refresh the interface on each sorting number in bar graph.
- usleep() is used to add interval to slow the animation for user view.
- IndicatorView is used to show sorting is working. It stops when sorting is done.
- The Quick and Merge sort takes time to show animation and sometimes slower than insertion sort and selection sort because Quick and Merge sorts are faster only for big number of arrays. 

### The measure you took to avoid cyclic strong references in your code.
All the outlets are declared week optional type to break cyclic strong reference.
