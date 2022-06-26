import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Log2{
    var logger = Logger(

        // filter: TbLogsFilter(),
        // printer: PrefixPrinter(
        //     PrettyPrinter(
        //         methodCount: 0,
        //         errorMethodCount: 8,
        //         lineLength: 200,
        //         colors: false,
        //         printEmojis: true,
        //         printTime: false
        //     )
        // ),
        // output: LogOutput()
    );

    static void init([bool debug = false]){

    }

    static void d(String msg,{String? tag}){

        // logger.d("debug messages!");
    }

}


