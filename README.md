<h1>Assembly Bubble Sort</h1>

This is a fully recursive  bubble sort algorithm written in MIPS.

I wrote this for a project in my Fundamentals of Computer Systems course in Spring 2017 at Florida International University.

My professor, Trevor Cickovski, wrote the code for loading the array, and printing the array at the end of the program.
(Fantastic professor, if anyone at FIU sees this, take his class)

All the code is commented, and is translated directly from this snipet of java code.

    void bubbleSort(int arr[], int n) {
        // An array of 1 element is already sorted
        if (n == 1) return;
 
        // Put the last element in the right spot
        for (int j=0; j<n-1; j++) {
            if (arr[j] > arr[j+1]) {
                int tmp = arr[j];  // Again, swap arr[j] and arr[j+1]
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
            }
        }
        // Sort the first n-1 elements
        bubbleSort(arr, n-1);
    }
