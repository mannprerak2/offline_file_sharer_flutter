import 'package:flutter/foundation.dart';
import 'package:nearby_connections/nearby_connections.dart';

class Transfer extends ChangeNotifier {
  List<TransferElement> transferElements = [];
  Map<int, TransferElement> mappedElements = {};

  /// not required unless using a method ending with NoNotification
  void notify() {
    notifyListeners();
  }

  /// call [notifyListeners] after use
  void addWithNoNotification(String fileName, int fileLength) {
    transferElements.add(TransferElement(fileName, fileLength));
  }
}

class TransferElement extends ChangeNotifier {
  String name;
  int length;
  PayloadStatus status = PayloadStatus.NONE;

  double _progress = 0;
  get progress => _progress;
  set progress(double p) {
    _progress = p;
    notifyListeners();
  }

  TransferElement(this.name, this.length);
}
