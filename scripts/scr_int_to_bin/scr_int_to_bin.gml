// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//function scr_int_to_bin(_x) {
//	var ret, negative, pow;
//	ret = ""
//    negative = 0
//    if (_x < 0) { // negative value
//        ret = "-" + ret
//        _x *= -1
//        negative = 1
//	} else if (_x == 0) {  // non-negative, non-positive value
//        return "0"
//	}
//    // for each power of two it could contain
//	for (pow = 4*string_length(string(_x)); pow > -1; pow--) {
//        // remove every power of two it contains and log whether it does or not
//        if _x / power(2, pow) >= 1 {
//            _x -= power(2, pow)
//            ret += "1"
//        } else if string_length(ret) > 0 + negative {
//            ret += "0"
//		}
//	}
//    return ret
//}

function int_to_bin(_x) {
	var _str = ""
	//negatives are 0 now. I declare it
	if _x <= 0 {
		return "0"
	}
	while (_x > 0) {
		if _x % 2 == 0 {
			_str = "0" + _str	
		} else {
			_str = "1" + _str
		}
		_x = _x div 2
	}
	return _str
}