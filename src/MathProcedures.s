.text
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

    .globl prod
    prod:
        addi sp, sp, -12      # adjust stack to make room for for 3 items
        sw t0, 8(sp)          # save register t0 for use afterward
        sw t1, 4(sp)          # save register t1 for use afterward
        sw t2, 0(sp)          # save register t2 for use afterward

        lb a0, 0(a2)          # result = *arrAddr
        addi t0, zero, 1      # i = 1
        add t1, zero, zero    # offset = 0
        add t2, zero, zero    # byte_temp = 0

        prodLoop:
            slli t2, t0, 2          # byte_temp = i * 4
            add t1, a2, t2          # offset = arrAddr + byte_temp
            lb t1, 0(t1)            # offset = *(arrAddr + byte_temp)

            mul a0, a0, t1          # result *= offset

            addi t0, t0, 1          # i++
            bne t0, a3, prodLoop    # loop while i < arrSize

        lw t2, 0(sp)          # restore register t2 for caller
        lw t1, 4(sp)          # restore register t1 for caller
        lw t0, 8(sp)          # restore register t0 for caller
        addi sp, sp, 12       # adjust stack to delete 3 items

        jalr zero, ra, 0      # return result

    .globl max
    max:
        addi sp, sp, -12      # adjust stack to make room for for 3 items
        sw t0, 8(sp)          # save register t0 for use afterward
        sw t1, 4(sp)          # save register t1 for use afterward
        sw t2, 0(sp)          # save register t2 for use afterward

        lb a0, 0(a2)          # result = *arrAddr
        addi t0, zero, 1      # i = 1
        add t1, zero, zero    # offset = 0
        add t2, zero, zero    # byte_temp = 0

        maxLoop:
            slli t2, t0, 2          # byte_temp = i * 4
            add t1, a2, t2          # offset = arrAddr + byte_temp
            lb t1, 0(t1)            # offset = *(arrAddr + byte_temp)

            blt t1, a0, maxLoopEnd    # skip assignment if offset < result
            add a0, zero, t1          # result = offset

            maxLoopEnd:
                addi t0, t0, 1         # i++
                bne t0, a3, maxLoop    # loop while i < arrSize

        lw t2, 0(sp)          # restore register t2 for caller
        lw t1, 4(sp)          # restore register t1 for caller
        lw t0, 8(sp)          # restore register t0 for caller
        addi sp, sp, 12       # adjust stack to delete 3 items

        jalr zero, ra, 0      # return result

    .globl min
    min:
        addi sp, sp, -12      # adjust stack to make room for for 3 items
        sw t0, 8(sp)          # save register t0 for use afterward
        sw t1, 4(sp)          # save register t1 for use afterward
        sw t2, 0(sp)          # save register t2 for use afterward

        lb a0, 0(a2)          # result = *arrAddr
        addi t0, zero, 1      # i = 1
        add t1, zero, zero    # offset = 0
        add t2, zero, zero    # byte_temp = 0

        minLoop:
            slli t2, t0, 2          # byte_temp = i * 4
            add t1, a2, t2          # offset = arrAddr + byte_temp
            lb t1, 0(t1)            # offset = *(arrAddr + byte_temp)

            bge t1, a0, minLoopEnd    # skip assignment if offset >= result
            add a0, zero, t1          # result = offset

            minLoopEnd:
                addi t0, t0, 1         # i++
                bne t0, a3, minLoop    # loop while i < arrSize

        lw t2, 0(sp)          # restore register t2 for caller
        lw t1, 4(sp)          # restore register t1 for caller
        lw t0, 8(sp)          # restore register t0 for caller
        addi sp, sp, 12       # adjust stack to delete 3 items

        jalr zero, ra, 0      # return result
