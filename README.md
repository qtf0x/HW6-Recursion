1) Include YOUR NAME and the names of all people who helped/collaborated as per
the syllabus and CS@Mines collaboration policy. [This is an individual assignment]

    Vincent Marias

2) Pseudocode (in C/Java/Python/etc) for your implementation [yes it should also be
recursive].

    ```c
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
    ```

3) Describe the challenges you encountered and how you surmounted them.

- 

4) What did you like about the assignment?

- 

5) How long did you spend working on this assignment?

    ~3 hours

6) A description of any features you added for extra credit (if any)

    N/A
