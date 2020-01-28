import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';

class ReceiveScreen extends StatefulWidget {
  @override
  _ReceiveScreenState createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  bool advertising = false;

  @override
  void initState() {
    startAdvertising();
    // WidgetsBinding.instance.addPostFrameCallback((_) => );
    super.initState();
  }

  @override
  void dispose() {
    Nearby().stopAdvertising();
    super.dispose();
  }

  void startAdvertising() async {
    try {
      advertising = await Nearby().startAdvertising(
        getP<User>().nickName,
        Strategy.P2P_POINT_TO_POINT,
        onConnectionInitiated: (String id, ConnectionInfo info) {
          // Called whenever a discoverer requests connection
          if (info.isIncomingConnection) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("${info.endpointName} wants to share files"),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text("Deny"),
                      onPressed: () {
                        Router.navigator.pop();
                      },
                    ),
                    RaisedButton(
                      child: Text("Allow"),
                      onPressed: () {
                        Nearby().acceptConnection(id,
                            onPayLoadRecieved: (endid, bytes) {},
                            onPayloadTransferUpdate:
                                (endid, payloadTransferUpdate) {});
                        // connection was already accepted by sender so its
                        // safe to directly go to receiver_transfer_screen
                        Router.navigator
                            .pushReplacementNamed(Router.receiverTransfer);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        onConnectionResult: (String id, Status status) {
          // Called when connection is accepted/rejected
        },
        onDisconnected: (String id) {
          // Callled whenever a discoverer disconnects from advertiser
        },
        serviceId: serviceId,
      );
      setState(() {});
    } catch (e) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Some Error occurred :("),
            content: Text(e.toString()),
            actions: <Widget>[
              RaisedButton(
                child: Text("Go back"),
                onPressed: () {
                  Router.navigator.pop();
                  Router.navigator.pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(advertising ? "Initialising" : "Waiting for a sender.."),
          ],
        ),
      ),
    );
  }
}
