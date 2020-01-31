import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/transfer.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:flutter_file_sharer/widgets/transfer_element_tile.dart';
import 'package:provider/provider.dart';

class ReceiverTransferScreen extends StatelessWidget {
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
