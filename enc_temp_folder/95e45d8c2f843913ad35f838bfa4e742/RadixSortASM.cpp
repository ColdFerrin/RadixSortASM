// RadixSortASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <random>
#include <time.h>

using namespace std;

extern "C" void radixSortBuckets(int radix, int numToSort, int* inputArrayPtr, int* outputArrayPtr);

static void RadixSort256(unsigned int* arr, int n);

bool areEqual(int arr1[], int arr2[], int length)
{

    // Linearly compare elements
    for (int i = 0; i < length; i++)
        if (arr1[i] != arr2[i])
            return false;

    // If all elements were same.
    return true;
}

int main()
{
    srand(1);
    const int numberToSort = 16;
    int originalArray[numberToSort] = { 0 };
    int inputArray[numberToSort] = { 0 };
    int outputArray[numberToSort] = { 0 };
    unsigned int anotherArray[numberToSort] = { 0 };

    for (int i = 0; i < numberToSort; ++i) {
        int temp = rand();
        originalArray[i] = temp;
        inputArray[i] = temp;
        anotherArray[i] = temp;

    }

    cout << sizeof(int) << endl;

    //  Printing array elements
    // using traditional for loop
    for (int i = 0; i < numberToSort; ++i) {
        cout << inputArray[i] << "  ";
    }
    cout << endl;

    RadixSort256(anotherArray, numberToSort);
    radixSortBuckets(256, numberToSort, inputArray, outputArray);
    int n = sizeof(originalArray) / sizeof(originalArray[0]);
    sort(originalArray, originalArray + n);

    if (areEqual(originalArray, outputArray, numberToSort)) {
        cout << "Arrays are the same" << endl;
    }

    std::cout << "Testing Radix Sort" << endl;
}

static void RadixSort256(unsigned int* arr, int n)
{
    if (n <= 1) return; // Added base case

    unsigned int* output = new unsigned int[n]; // output array
    int* count = new int[256];
    unsigned int* originalArr = arr; // So we know which was input

    for (int shift = 0, s = 0; shift < 4; shift++, s += 8)
    {
        // Zero the counts
        for (int i = 0; i < 256; i++)
            count[i] = 0;

        // Store count of occurrences in count[] 
        for (int i = 0; i < n; i++)
            count[(arr[i] >> s) & 0xff]++;

        // Change count[i] so that count[i] now contains 
        // actual position of this digit in output[] 
        for (int i = 1; i < 256; i++)
            count[i] += count[i - 1];

        // Build the output array 
        for (int i = n - 1; i >= 0; i--)
        {
            // precalculate the offset as it's a few instructions
            int idx = (arr[i] >> s) & 0xff;

            // Subtract from the count and store the value
            output[--count[idx]] = arr[i];
        }

        // Copy the output array to input[], so that input[] 
        // is sorted according to current digit

        // We can just swap the pointers
        unsigned int* tmp = arr;
        arr = output;
        output = tmp;
    }

    // If we switched pointers an odd number of times,
    // make sure we copy before returning
    if (originalArr == output)
    {
        unsigned int* tmp = arr;
        arr = output;
        output = tmp;

        for (int i = 0; i < n; i++)
            arr[i] = output[i];
    }

    delete[] output;
    delete[] count;
}
