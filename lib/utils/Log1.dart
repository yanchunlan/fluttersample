import 'package:flutter/material.dart';
export 'package:dog/dog.dart';

class Log1{

    static void init([bool debug = false]){
      // dog = Dog(handler: Handler(formatter: PrettyFormatter(
      //   callerGetter: () {
      //     List<Frame> frames = Trace.current().frames;
      //     if (frames != null && frames.isNotEmpty) {
      //       for (int i = frames.length - 1; i >= 0; i--) {
      //         Frame frame = frames[i];
      //         if ((frame.package == 'banban_base' &&
      //             frame.member.startsWith('Log.') ||
      //             frame.member.startsWith('Xhr.')) ||
      //             frame.package == 'dog') {
      //           return frames[min(i + 1, frames.length - 1)].toString();
      //         }
      //       }
      //     }
      //     return null;
      //   },
      // ),emitter: ConsoleEmitter(supportsAnsiColor: true)));
      // dog.level = Level.off;
    }

    static void d(String msg,{String? tag}){
      // dog.d('$msg', tag: tag);
    }

}


