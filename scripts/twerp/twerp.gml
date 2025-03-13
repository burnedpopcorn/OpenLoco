function twerp(argument0, argument1, argument2, argument3, argument4, argument5)
{
    argument0 = clamp(argument0, 0, UnknownEnum.Value_31);
    argument3 = clamp(argument3, 0, 1);
    var _chng = argument2 - argument1;
    var _mid = (argument1 + argument2) / 2;
    
    switch (argument0)
    {
        case UnknownEnum.Value_0:
            return lerp(argument1, argument2, argument3);
        
        case UnknownEnum.Value_22:
            var _b = (argument4 == undefined) ? 1.5 : argument4;
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_23, argument1, _mid, argument3 * 2, _b) : twerp(UnknownEnum.Value_24, _mid, argument2, (argument3 - 0.5) * 2, _b);
        
        case UnknownEnum.Value_23:
            _b = (argument4 == undefined) ? 1.5 : argument4;
            return (_chng * argument3 * argument3 * (((_b + 1) * argument3) - _b)) + argument1;
        
        case UnknownEnum.Value_24:
            _b = (argument4 == undefined) ? 1.5 : argument4;
            argument3 -= 1;
            return (_chng * ((argument3 * argument3 * (((_b + 1) * argument3) + _b)) + 1)) + argument1;
        
        case UnknownEnum.Value_25:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_27, argument1, (argument1 + argument2) / 2, argument3 * 2) : twerp(UnknownEnum.Value_26, (argument1 + argument2) / 2, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_26:
            if (argument3 < 0.36363636363636365)
            {
                return (_chng * (7.5625 * argument3 * argument3)) + argument1;
            }
            else if (argument3 < 0.7272727272727273)
            {
                argument3 -= 0.5454545454545454;
                return (_chng * ((7.5625 * argument3 * argument3) + 0.75)) + argument1;
            }
            else if (argument3 < 0.9090909090909091)
            {
                argument3 -= 0.8181818181818182;
                return (_chng * ((7.5625 * argument3 * argument3) + 0.9375)) + argument1;
            }
            
            argument3 -= 0.9545454545454546;
            return (_chng * ((7.5625 * argument3 * argument3) + 0.984375)) + argument1;
        
        case UnknownEnum.Value_27:
            _chng = argument2 - argument3;
            argument3 = 1 - argument3;
            return (_chng - twerp(UnknownEnum.Value_26, argument1, argument2, argument3, 7.5625)) + argument1;
        
        case UnknownEnum.Value_13:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_15, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_14, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_14:
            argument3--;
            return (_chng * sqrt(1 - (argument3 * argument3))) + argument1;
        
        case UnknownEnum.Value_15:
            return (-_chng * (sqrt(1 - (argument3 * argument3)) - 1)) + argument1;
        
        case UnknownEnum.Value_1:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_3, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_2, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_2:
            return (_chng * (power(argument3 - 1, 3) + 1)) + argument1;
        
        case UnknownEnum.Value_3:
            return (_chng * power(argument3, 3)) + argument1;
        
        case UnknownEnum.Value_28:
            var _e = (argument4 == undefined) ? 0.3 : argument4;
            var _d = (argument5 == undefined) ? 5 : argument5;
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_30, argument1, _mid, argument3 * 2, _e, _d) : twerp(UnknownEnum.Value_29, _mid, argument2, (argument3 - 0.5) * 2, _e, _d);
        
        case UnknownEnum.Value_29:
            _e = (argument4 == undefined) ? 0.3 : argument4;
            _d = (argument5 == undefined) ? 5 : argument5;
            
            if (argument3 == 0 || _chng == 0)
                return argument1;
            
            if (argument3 == 1)
                return argument2;
            
            var _p = _d * _e;
            var _s = (sign(_chng) == -1) ? (_p * 0.25) : ((_p / (2 * pi)) * 1.5707963267948966);
            return (_chng * power(2, -10 * argument3) * sin((((argument3 * _d) - _s) * (2 * pi)) / _p)) + _chng + argument1;
        
        case UnknownEnum.Value_30:
            _e = (argument4 == undefined) ? 0.3 : argument4;
            _d = (argument5 == undefined) ? 5 : argument5;
            
            if (argument3 == 0 || _chng == 0)
                return argument1;
            
            if (argument3 == 1)
                return argument2;
            
            _p = _d * _e;
            _s = (sign(_chng) == -1) ? (_p * 0.25) : ((_p / (2 * pi)) * 1.5707963267948966);
            return -(_chng * power(2, 10 * --argument3) * sin((((argument3 * _d) - _s) * (2 * pi)) / _p)) + argument1;
        
        case UnknownEnum.Value_19:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_21, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_20, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_20:
            return (_chng * (-power(2, -10 * argument3) + 1)) + argument1;
        
        case UnknownEnum.Value_21:
            return (_chng * power(2, 10 * (argument3 - 1))) + argument1;
        
        case UnknownEnum.Value_4:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_6, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_5, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_5:
            return (-_chng * argument3 * (argument3 - 2)) + argument1;
        
        case UnknownEnum.Value_6:
            return (_chng * argument3 * argument3) + argument1;
        
        case UnknownEnum.Value_7:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_9, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_8, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_8:
            return (-_chng * (((argument3 - 1) * (argument3 - 1) * (argument3 - 1) * (argument3 - 1)) - 1)) + argument1;
        
        case UnknownEnum.Value_9:
            return (_chng * (argument3 * argument3 * argument3 * argument3)) + argument1;
        
        case UnknownEnum.Value_10:
            return (argument3 < 0.5) ? twerp(UnknownEnum.Value_12, argument1, _mid, argument3 * 2) : twerp(UnknownEnum.Value_11, _mid, argument2, (argument3 - 0.5) * 2);
        
        case UnknownEnum.Value_11:
            return (_chng * (((argument3 - 1) * (argument3 - 1) * (argument3 - 1) * (argument3 - 1) * (argument3 - 1)) + 1)) + argument1;
        
        case UnknownEnum.Value_12:
            return (_chng * argument3 * argument3 * argument3 * argument3 * argument3) + argument1;
        
        case UnknownEnum.Value_16:
            return (_chng * 0.5 * (1 - cos(pi * argument3))) + argument1;
        
        case UnknownEnum.Value_17:
            return (_chng * sin(argument3 * 1.57079632679)) + argument1;
        
        case UnknownEnum.Value_18:
            return (_chng * (1 - cos(argument3 * 1.57079632679))) + argument1;
    }
}
