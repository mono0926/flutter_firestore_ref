import 'package:rxdart/rxdart.dart';
import 'package:state_notifier/state_notifier.dart';

export 'logger.dart';

extension StateNotifierEx<T> on StateNotifier<T> {
  Stream<T> get streamWithCurrent =>
      // ignore: invalid_use_of_protected_member
      Rx.concat([Stream.value(state), stream]);
}
