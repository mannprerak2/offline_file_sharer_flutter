import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:flutter_file_sharer/providers/files.dart';
import 'package:nearby_connections/nearby_connections.dart';

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
    for (var file in getP<Files>().files) {
      //send file
      int payloadId = await Nearby().sendFilePayload(id, file.path);
      //send filename along with payload id for identification
      Nearby().sendBytesPayload(
          id,
          Uint8List.fromList(
              "FILE:::$payloadId:::${file.path.split('/').last}".codeUnits));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
