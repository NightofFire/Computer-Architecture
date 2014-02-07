# jump to gt_lab if $reg0 > $reg1
# bgt $reg0, $reg1, gt_lab
        slt     $at, $reg1, $reg0  # t0=1 if $reg1 < $reg2
        bne     $at, $zero, gt_lab # if t0!=0, goto gt_lab
