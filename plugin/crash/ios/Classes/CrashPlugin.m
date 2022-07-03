#import "CrashPlugin.h"
#if __has_include(<crash/crash-Swift.h>)
#import <crash/crash-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "crash-Swift.h"
#endif

@implementation CrashPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCrashPlugin registerWithRegistrar:registrar];
}
@end
