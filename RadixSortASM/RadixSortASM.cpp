// RadixSortASM.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
#include <random>
#include <time.h>

using namespace std;

extern "C" void radixSortBuckets(int radix, int numToSort, int* inputArrayPtr, int* outputArrayPtr);

int main()
{
    srand(time(NULL));
    const int numberToSort = 25;
    int inputArray[numberToSort] = { 0 };
    int outputArray[numberToSort] = { 0 };

    for (int i = 0; i < numberToSort; ++i) {
        inputArray[i] = rand();
    }

    cout << sizeof(int) << endl;

    //  Printing array elements
    // using traditional for loop
    for (int i = 0; i < numberToSort; ++i) {
        cout << inputArray[i] << "  ";
    }
    cout << endl;

    radixSortBuckets(256, numberToSort, inputArray, outputArray);

    std::cout << "Testing Radix Sort" << endl;
}