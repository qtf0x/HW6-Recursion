.data
    .align 2
    sumPrompt: .string "Summation: "

.text
    # Arguments
    #     a2: address of array containing integers to sum
    #     a3: number of elements in the array
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
            add t1, a2, t2         # offset = arrAddr + byte_temp
            lw t1, 0(t1)           # offset = *(arrAddr + byte_temp)

            add a0, a0, t1         # result += offset

            addi t0, t0, 1         # i++
            bne t0, a3, sumLoop    # loop while i < arrSize

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
        addi sp, sp, -20                 # space for 5 words
        sw ra, 16(sp)                    # save return address
        sw t0, 12(sp)                    # save t0, used within
        sw t1, 8(sp)                     # save t1, used within

        addi a7, zero, 4                 # load PrintString service
        la a0, sumPrompt                 # a0 = &sumPrompt
        ecall

        sw a2, 0(sp)                     # need a2 after jal
        slli t1, a3, 2                   # t1 = startIndex * 4
        add a2, a2, t1                   # a2 += startIndex * 4
        sw a3, 4(sp)                     # need a3 after jal
        sub a3, a4, a3                   # a3 = endIndex - startIndex
        addi a3, a3, 1                   # a3++
        jal ra, sum                      # call sum procedure
        lw a2, 0(sp)                     # restore a2
        lw a3, 4(sp)                     # restore a3

        addi a7, zero, 1                 # load PrintInt service
        ecall

        addi a7, zero, 11                # load PrintChar service
        addi a0, zero, 10                # a0 = '\n'
        ecall

        add t0, a3, a4                   # t0 = startIndex + endIndex
        addi t1, zero, 2                 # t1 = 2
        div a0, t0, t1                   # a0 = t0 / 2 (a0 = midIndex)

        slli t1, t0, 2                   # t1 = midIndex * 4
        add t1, a2, t1                   # t1 = addAddr + (midIndex * 4)
        lw t1, 0(t1)                     # t1 = *(arrAddr + (midIndex * 4))
        beq a5, t1, binarySearch_done    # base case

        blt a5, t1, recurseLeft          # recursive case left
        bgt a5, t1, recurseRight         # recursive case right

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
            lw t1, 8(sp)        # restore t1
            lw t0, 12(sp)       # restore t0
            lw ra, 16(sp)       # restore ra
            addi sp, sp, 20     # pop the stack frame

            jalr zero, ra, 0    # return to the caller
