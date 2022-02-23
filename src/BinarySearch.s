#    BinarySearch.s
#
#    A simple, recursive implementation of the binary search algorithm, written 
#    in RISC-V Assembly. No error-handling is performed, and input is assumed #    to be pre-sorted in ascending order. Returns -1 if value not found.
#
#    @author Vincent Marias

.data
    .align 2
    sumPrompt: .string "Summation: "

.text
    # Arguments
    #     a6: address of array containing integers to sum
    #     a7: number of elements in the array
    # Return values
    #     a0: the summation of the integers in the array
    .globl sum
    sum:
        addi sp, sp, -12      # adjust stack to make room for for 3 items
        sw t0, 8(sp)          # save register t0 for use afterward
        sw t1, 4(sp)          # save register t1 for use afterward
        sw t2, 0(sp)          # save register t2 for use afterward

        add a0, zero, zero    # result = 0
        add t0, zero, zero    # i = 0
        add t1, zero, zero    # offset = 0
        add t2, zero, zero    # byte_temp = 0

        sumLoop:
            slli t2, t0, 2         # byte_temp = i * 4
            add t1, a6, t2         # offset = arrAddr + byte_temp
            lw t1, 0(t1)           # offset = *(arrAddr + byte_temp)

            add a0, a0, t1         # result += offset

            addi t0, t0, 1         # i++
            bne t0, a7, sumLoop    # loop while i < arrSize

        lw t2, 0(sp)          # restore register t2 for caller
        lw t1, 4(sp)          # restore register t1 for caller
        lw t0, 8(sp)          # restore register t0 for caller
        addi sp, sp, 12       # adjust stack to delete 3 items

        jalr zero, ra, 0      # return result
    
    # Arguments
    #     a2: address of the array
    #     a3: start index
    #     a4: end index
    #     a5: value to find
    # Return values
    #     a0: index of value
    .globl binarySearch
    binarySearch:
        addi sp, sp, -12                 # space for 5 words
        sw ra, 8(sp)                     # save return address
        sw t0, 4(sp)                     # save t0, used within
        sw t1, 0(sp)                     # save t1, used within

        addi a7, zero, 4                 # load PrintString service
        la a0, sumPrompt                 # a0 = &sumPrompt
        ecall

        slli t1, a3, 2                   # t1 = startIndex * 4
        add a6, a2, t1                   # a6 = arrAddr + (startIndex * 4)
        sub a7, a4, a3                   # a7 = endIndex - startIndex
        addi a7, a7, 1                   # a7++
        jal ra, sum                      # call sum procedure

        addi a7, zero, 1                 # load PrintInt service
        ecall

        addi a7, zero, 11                # load PrintChar service
        addi a0, zero, 10                # a0 = '\n'
        ecall

        add t0, a3, a4                   # t0 = startIndex + endIndex
        addi t1, zero, 2                 # t1 = 2
        div a0, t0, t1                   # a0 = t0 / 2 (a0 = midIndex)

        slli t1, a0, 2                   # t1 = midIndex * 4
        add t1, a2, t1                   # t1 = addAddr + (midIndex * 4)
        lw t1, 0(t1)                     # t1 = *(arrAddr + (midIndex * 4))
        beq a5, t1, binarySearch_done    # base case

        blt a5, t1, recurseLeft          # recursive case left
        bge a5, t1, recurseRight         # recursive case right

        addi a0, zero, -1                # a0 = -1
        jal zero, binarySearch_done      # fail case

        recurseLeft:
            addi a4, a0, -1    # a4 = midIndex - 1
            jal ra, binarySearch
            jal zero, binarySearch_done

        recurseRight:
            addi a3, a0, 1    # a3 = midIndex + 1
            jal ra, binarySearch
            jal zero, binarySearch_done

        binarySearch_done:
            lw t1, 0(sp)        # restore t1
            lw t0, 4(sp)        # restore t0
            lw ra, 8(sp)        # restore ra
            addi sp, sp, 12     # pop the stack frame

            jalr zero, ra, 0    # return to the caller
