#include <stdio.h>

int sum(int* arrAddr, int arrSize) {
    int result = 0;

    for (int i = 0; i < arrSize; ++i) result += *(arrAddr + i);

    return result;
}

int binarySearch(int* arrAddr, int startIndex, int endIndex, int searchVal) {
    printf("Summation: %d\n", sum(arrAddr + startIndex, 
           (endIndex - startIndex) + 1));

    int midIndex = (startIndex + endIndex) / 2;

    if (searchVal == *(arrAddr + midIndex)) {          // base case
        return midIndex;
    } else if (searchVal < *(arrAddr + midIndex)) {    // recursive case left
        return binarySearch(arrAddr, startIndex, midIndex - 1, searchVal);
    } else {                                          // recursive case right
        return binarySearch(arrAddr, midIndex + 1, endIndex, searchVal);
    }

    return -1;                                        // fail case
}

int main() {
    char arrayNumberPrompt[] = "Enter a number to add to the array: ";
    char searchPrompt[] = "What value are you looking for? ";
    char indexPrompt[] = "Index: %d\n";
    char valuePrompt[] = "Value: %d\n";

    int arrAddr[sizeof(int) * 200];
    int nextInput = 0;
    int endIndex = 0;

    printf("%s", arrayNumberPrompt);
    scanf("%d", &nextInput);
    while (nextInput != 0) {
        *(arrAddr + endIndex) = nextInput;

        printf("%s", arrayNumberPrompt);
        scanf("%d", &nextInput);

        endIndex++;
    }

    int searchVal = 0;
    
    printf("%s", searchPrompt);
    scanf("%d", &searchVal);

    int searchIndex = binarySearch(arrAddr, 0, endIndex - 1, searchVal);

    printf(indexPrompt, searchIndex);
    printf(valuePrompt, *(arrAddr + searchIndex));

    return 0;
}
