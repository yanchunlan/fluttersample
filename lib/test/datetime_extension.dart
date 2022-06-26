import 'package:intl/intl.dart' as Date;

/**
 * 拓展类
 */
extension DateTimeExt on DateTime {
  /// 2020-02-02 02:02:02
  String toyyyyMMddHHmmss() {
    return Date.DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  /// 2020-02-02 02:02
  String toyyyyMMddHHmm() {
    return Date.DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  /// 02-20 20:20
  String toMMddHHmm() {
    return Date.DateFormat('MM-dd HH:mm').format(this);
  }

  /// 02-20
  String toyyyyMMdd() {
    return Date.DateFormat('yyyy-MM-dd').format(this);
  }

  /// 02-20-2020
  String toddMMyyyy() {
    return Date.DateFormat('dd-MM-yyyy').format(this);
  }
}
