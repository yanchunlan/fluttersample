import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Log{

    static void init([bool debug = false]){
      if (debug) {
        debugPrint = (String? message, {int? wrapWidth}) => debugPrintSynchronously(message, wrapWidth: wrapWidth);
        // debugPrint = (String? message, {int? wrapWidth}) => debugPrintThrottled(message, wrapWidth: wrapWidth);
      }else{
        debugPrint = (String? message, {int? wrapWidth}) {};//空实现
      }
    }

    static void d(String msg){
      debugPrint("msg $msg");
    }

}


