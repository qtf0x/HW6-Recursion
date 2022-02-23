### CSCI 341 - Computer Organization (Spring 2022)
# Recursive Binary Search

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

        // base case
        if (searchVal == *(arrAddr + midIndex)) {
            return midIndex;
        // recursive case left
        } else if (searchVal < *(arrAddr + midIndex)) {
            return binarySearch(arrAddr, startIndex, midIndex - 1, searchVal);
        // recursive case right
        } else {
            return binarySearch(arrAddr, midIndex + 1, endIndex, searchVal);
        }

        return -1;    // fail case
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
