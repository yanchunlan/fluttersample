#import "FlutterNetworkPlugin.h"
#if __has_include(<flutter_network_plugin/flutter_network_plugin-Swift.h>)
#import <flutter_network_plugin/flutter_network_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_network_plugin-Swift.h"
#endif

@implementation FlutterNetworkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterNetworkPlugin registerWithRegistrar:registrar];
}
@end
