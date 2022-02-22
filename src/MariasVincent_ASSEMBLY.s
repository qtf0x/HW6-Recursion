.text
    # Arguments
    #     a2: address of array cotnaining integers to sum
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
