

function v2 = MSASLGetHand(v,handThresh)

    v2 = [];

    if v(3) < handThresh
        v(1) = 0; v(2) = 0;
    end
    if v(6) < handThresh
        v(4) = 0; v(5) = 0;
    end
    if v(9) < handThresh
        v(7) = 0; v(8) = 0;
    end
    if v(12) < handThresh
        v(10) = 0; v(11) = 0;
    end
    if v(15) < handThresh
        v(13) = 0; v(14) = 0;
    end
    if v(18) < handThresh
        v(16) = 0; v(17) = 0;
    end
    if v(21) < handThresh
        v(19) = 0; v(20) = 0;
    end
    if v(24) < handThresh
        v(22) = 0; v(23) = 0;
    end
    if v(27) < handThresh
         v(25) = 0; v(26) = 0;
    end
    if v(30) < handThresh
        v(28) = 0; v(29) = 0;
    end
    if v(33) < handThresh
        v(31) = 0; v(32) = 0;
    end
    if v(36) < handThresh
        v(34) = 0; v(35) = 0;
    end
    if v(39) < handThresh
        v(37) = 0; v(38) = 0;
    end
    if v(42) < handThresh
        v(40) = 0; v(41) = 0;
    end
    if v(45) < handThresh
        v(43) = 0; v(44) = 0;
    end
     if v(48) < handThresh
        v(46) = 0; v(47) = 0;
    end
    if v(51) < handThresh
        v(49) = 0; v(50) = 0;
    end
    if v(54) < handThresh
        v(52) = 0; v(53) = 0;
    end
    if v(57) < handThresh
        v(55) = 0; v(56) = 0;
    end
    if v(60) < handThresh
        v(58) = 0; v(59) = 0;
    end
    if v(63) < handThresh
        v(61) = 0; v(62) = 0;
    end

    v2 = [v(1)   v(2)   0 v(4)   v(5)  0 v(7)   v(8)  0 v(10)  v(11) 0 ...
          v(13)  v(14)  0 v(16)  v(17) 0 v(19)  v(20) 0 v(22)  v(23) 0 ...
          v(25)  v(26)  0 v(28)  v(29) 0 v(31)  v(32) 0 v(34)  v(35) 0 ...
          v(37)  v(38)  0 v(40)  v(41) 0 v(43)  v(44) 0 v(46)  v(47) 0 ...
          v(49)  v(50)  0 v(52)  v(53) 0 v(55)  v(56) 0 v(58)  v(59) 0 ...
          v(61)  v(62)  0];
end