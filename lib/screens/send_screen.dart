import 'package:flutter/material.dart';
import 'package:flutter_file_sharer/payload_handler.dart';
import 'package:flutter_file_sharer/providers/endpoints.dart';
import 'package:flutter_file_sharer/providers/files.dart';
import 'package:flutter_file_sharer/providers/user.dart';
import 'package:flutter_file_sharer/global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  @override
  void initState() {
    // start discovery
    startDiscovery();
    // WidgetsBinding.instance.addPostFrameCallback((_) => );
    super.initState();
  }

  @override
  void dispose() {
    // stop discovery
    Nearby().stopDiscovery();
    super.dispose();
  }

  void startDiscovery() async {
    try {
      await Nearby()
          .startDiscovery(getP<User>().nickName, Strategy.P2P_POINT_TO_POINT,
              onEndpointFound: (String id, String nickName, String serviceId) {
        getP<Endpoints>().addUser(id, nickName);
      }, onEndpointLost: (String id) {
        getP<Endpoints>().removeUser(id);
      }, serviceId: serviceId);
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
            Consumer<Files>(
              builder: (_, files, __) {
                return Text("${files.files.length} files selected");
              },
            ),
            RaisedButton(
              child: Text("Select Files"),
              onPressed: () async {
                getP<Files>().add(await FilePicker.getMultiFile());
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer<Files>(
        builder: (_, files, __) {
          return FloatingActionButton.extended(
            label: Text("Proceed"),
            icon: Icon(Icons.send),
            onPressed: files.files.length < 1
                ? null
                : () {
                    //open list of advertisers to send files to..
                    showAdvertisersDialog();
                  },
          );
        },
      ),
    );
  }

  void showAdvertisersDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Receivers Near You"),
          content: Container(
            width: double.maxFinite,
            child: Center(
              child: Consumer<Endpoints>(
                builder: (_, endpoints, __) {
                  if (endpoints.externalUsers.length < 1)
                    return CircularProgressIndicator();

                  return EndpointListView(endpoints);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class EndpointListView extends StatefulWidget {
  final Endpoints endpoints;
  EndpointListView(
    this.endpoints, {
    Key key,
  }) : super(key: key);

  @override
  _EndpointListViewState createState() => _EndpointListViewState();
}

class _EndpointListViewState extends State<EndpointListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.endpoints.externalUsers.length,
      itemBuilder: (_, i) {
        return Padding(
          padding: EdgeInsets.all(6),
          child: FlatButton(
            child: Text("${widget.endpoints.externalUsers[i].nickName}"),
            onPressed: () {
              // request connection to advertiser
              requestConnection(i, context);
            },
          ),
        );
      },
    );
  }

  void requestConnection(int i, BuildContext context) {
    Nearby().requestConnection(
      getP<User>().nickName,
      widget.endpoints.externalUsers[i].endpointId,
      onConnectionInitiated: (id, info) {
        if (!info.isIncomingConnection) {
          Nearby().acceptConnection(
            id,
            onPayLoadRecieved: null,
            onPayloadTransferUpdate:
                PayloadHandler().onPayloadTransferUpdateSender,
          );
        }
      },
      onConnectionResult: (id, status) {
        //send files to user..
        if (status == Status.CONNECTED) {
          Router.navigator
              .pushReplacementNamed(Router.senderTransfer, arguments: id);
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Connection was Rejected"),
            ),
          );
        }
      },
      onDisconnected: (id) {},
    );
  }
}
