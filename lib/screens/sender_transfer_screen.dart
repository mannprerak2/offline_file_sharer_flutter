import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:flutter_file_sharer/providers/files.dart';
import 'package:flutter_file_sharer/providers/transfer.dart';
import 'package:flutter_file_sharer/widgets/transfer_element_tile.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';

class SenderTransferScreen extends StatefulWidget {
  final String endpointId;

  const SenderTransferScreen(this.endpointId, {Key key}) : super(key: key);

  @override
  _SenderTransferScreenState createState() => _SenderTransferScreenState();
}

class _SenderTransferScreenState extends State<SenderTransferScreen> {
  @override
  void initState() {
    startTransfer(widget.endpointId);
    super.initState();
  }

  void startTransfer(String id) async {
    String meta = "";
    for (var file in getP<Files>().files) {
      String name = file.path.split('/').last;
      int len = await file.length();
      getP<Transfer>().addWithNoNotification(
        name,
        len,
      );
      meta += ":::$name:::$len";
    }
    getP<Transfer>().notify();

    // send metadata
    Nearby().sendBytesPayload(id, Uint8List.fromList("META$meta".codeUnits));

    // start sending files (send file then name encoded with payload id of file)
    for (var file in getP<Files>().files) {
      //send file
      int payloadId = await Nearby().sendFilePayload(id, file.path);
      String fileName = file.path.split('/').last;

      // add to map for quick access
      getP<Transfer>().mappedElements[payloadId] = getP<Transfer>()
          .transferElements
          .firstWhere((e) => fileName == e.name);

      //send filename along with payload id for identification
      Nearby().sendBytesPayload(
          id, Uint8List.fromList("FILE:::$payloadId:::$fileName".codeUnits));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Transfer>(
      builder: (_, transfer, __) {
        if (transfer.transferElements.length < 1) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            body: ListView.builder(
              itemCount: getP<Transfer>().transferElements.length,
              itemBuilder: (context, i) {
                return TransferElementTile(
                    getP<Transfer>().transferElements[i]);
              },
            ),
          );
        }
      },
    );
  }
}
