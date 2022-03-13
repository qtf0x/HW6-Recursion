### CSCI 341 - Computer Organization (Spring 2022)
# Recursive Binary Search

1) Include YOUR NAME and the names of all people who helped/collaborated as per the syllabus and CS@Mines collaboration policy. [This is an individual assignment]

    Vincent Marias

<br>

2) Pseudocode (in C/Java/Python/etc) for your implementation [yes it should also be recursive].

    ```c
    int binarySearch(int* arrAddr, int startIndex, int endIndex, int searchVal) 
    {
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

<br>

3) Describe the challenges you encountered and how you surmounted them.

- When I was writing my C implementation (before the assembly one), I kept getting very weird results. At first it seemed like my function was somehow not being inclusive of the end index. But I realized that I had forgotten to decrement or increment the middle index value before recursing left or right respectively. That way, we get the correct range of indices for each recursive call.

- When writing the RISC-V assembly implementation, there was a bug that was creating an infinite loop at some point in the recursive chain. I had to step through the instructions one-by-one to track down the source. It was literally one single character on line 75. I had accidentally written t0 instead of a0.

- I had to modify my original `sum` procedure so that it takes arguments from `a6` and `a7` now. I figured this was simpler and cleaner than storing and restoring `a2` and `a3` inside the `binarySearch` procedure.

<br>

4) What did you like about the assignment?

- I like that we are finally writing something in assembly that seems useful in the real world. Binary search is a real search algorithm that real engineers use, and this assignment feels more worthwhile as a result.

- I also like that the algorithm chosen for this assignment is relatively simple. If we had to implement some much more complex recursive algorithm as our first foray into assembly recursion, that would have been ... cruel.

<br>

5) How long did you spend working on this assignment?

    ~3 hours

<br>

6) A description of any features you added for extra credit (if any)

    N/A
