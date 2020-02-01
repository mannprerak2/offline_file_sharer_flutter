import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/transfer.dart';

class TransferElementTile extends StatefulWidget {
  final TransferElement element;

  TransferElementTile(this.element);

  @override
  _TransferElementTileState createState() => _TransferElementTileState();
}

class _TransferElementTileState extends State<TransferElementTile> {
  @override
  void initState() {
    widget.element.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.element.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(widget.element.name),
              Icon(widget.element.progress == 0
                  ? Icons.check_box_outline_blank
                  : widget.element.progress < 1
                      ? Icons.indeterminate_check_box
                      : Icons.check_box)
            ],
          ),
          LinearProgressIndicator(
            value: widget.element.progress,
          ),
        ],
      ),
    );
  }
}
