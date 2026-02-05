import 'package:flutter/foundation.dart';

export 'network_exception.dart';

/// Global notifier for app-level "network unavailable" state.
/// Set to true when a request fails due to socket/connection error.
final ValueNotifier<bool> networkErrorNotifier = ValueNotifier<bool>(false);
