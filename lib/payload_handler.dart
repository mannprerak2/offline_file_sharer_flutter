import 'package:flutter_file_sharer/providers/transfer.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:flutter_file_sharer/global.dart';

class PayloadHandler {
  // making this singleton
  static PayloadHandler _handler;
  factory PayloadHandler() {
    if (_handler == null) {
      _handler = PayloadHandler._();
    }
    return _handler;
  }
  PayloadHandler._();

  /// called on receiver end
  void onPayloadReceived(String endid, Payload payload) {
    // could be meta or filename or file payload
    if (payload.type == PayloadType.BYTES) {
      String rawdata = String.fromCharCodes(payload.bytes);
      List<String> data = rawdata.split(":::");
      if (data.length < 1) {
        print("sender error: empty payload");
        return;
      }
      if (data[0] == "FILE") {
        getP<Transfer>().mappedElements[int.parse(data[1])] = getP<Transfer>()
            .transferElements
            .firstWhere((e) => data[2] == e.name);
      } else if (data[0] == "META") {
        for (int i = 1; i < data.length; i += 2) {
          getP<Transfer>().addWithNoNotification(
            data[i],
            int.parse(data[i + 1]),
          );
        }
        getP<Transfer>().notify();
      }
    } else {
      // file payload
    }
  }

  void onPayloadTransferUpdateReceiver(
    String endpointId,
    PayloadTransferUpdate ptu,
  ) {
    getP<Transfer>().mappedElements[ptu.id]?.progress =
        (ptu.bytesTransferred / ptu.totalBytes);
    getP<Transfer>().mappedElements[ptu.id]?.status = ptu.status;
  }

  void onPayloadTransferUpdateSender(
    String endpointId,
    PayloadTransferUpdate ptu,
  ) {
    getP<Transfer>().mappedElements[ptu.id]?.progress =
        (ptu.bytesTransferred / ptu.totalBytes);
    getP<Transfer>().mappedElements[ptu.id]?.status = ptu.status;
  }
}
