import 'package:firestore_ref/src/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_logger/simple_logger.dart';

bool recordFirestoreOperationCount = false;

class FirestoreOperationCounter {
  FirestoreOperationCounter._();

  static FirestoreOperationCounter _instance;
  // ignore: prefer_constructors_over_static_methods
  static FirestoreOperationCounter get instance =>
      _instance ??= FirestoreOperationCounter._();

  Level traceLogLevel = Level.FINE;

  var _read = 0;
  var _readFromCache = 0;
  var _write = 0;
  var _delete = 0;

  int get read => _read;
  int get readFromCache => _readFromCache;
  int get readTotal => _read + _readFromCache;
  int get write => _write;
  int get delete => _delete;
  double get readPriceUsCentralInUSD => _read * 0.06 / 100000;
  double get writePriceUsCentralInUSD => _write * 0.18 / 100000;
  double get deletePriceUsCentralInUSD => _delete * 0.02 / 100000;
  double get totalPriceUsCentralInUSD =>
      readPriceUsCentralInUSD +
      writePriceUsCentralInUSD +
      deletePriceUsCentralInUSD;
  double get cacheHitRatio => readTotal == 0 ? 0 : readFromCache / readTotal;

  void recordRead({@required bool isFromCache, int count = 1}) {
    isFromCache ? _readFromCache += count : _read += count;
    logger.log(traceLogLevel, this);
  }

  void recordWrite({int count = 1}) {
    _write += count;
    logger.log(traceLogLevel, this);
  }

  void recordDelete({int count = 1}) {
    _delete += count;
    logger.log(traceLogLevel, this);
  }

  @override
  String toString() {
    return '''
AccessCounter{
  read: $read (\$${readPriceUsCentralInUSD.toStringAsPrecision(3)})
  readFromCache: $readFromCache (cache hit: ${(cacheHitRatio * 100).toStringAsPrecision(3)} %)
  write: $write (\$${writePriceUsCentralInUSD.toStringAsPrecision(3)})
  delete: $delete (\$${deletePriceUsCentralInUSD.toStringAsPrecision(3)})
  totalPrice(UsCentral): \$${totalPriceUsCentralInUSD.toStringAsPrecision(3)}
}
    ''';
  }
}
