import 'package:flutter/material.dart';
import 'package:pingstats/repository/bloc/HostsDataBloc.dart';
import 'package:pingstats/screens/widgets/HostTile.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HostsDataBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<HostsDataBloc>();
    // bloc.hosts.listen((event) {
    //   event.then((value) => print(value));
    // });
  }

  void startAll() {
    bloc.startAll();
  }

  void stopAll() {
    bloc.stopAll();
  }

  @override
  Widget build(BuildContext context) {
    // bloc.addHost('speedtest.net');
    // bloc.deleteHost('speeqweqwd');

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 36,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: Color(0xffEBEBEB),
                    ),
                    tooltip: 'Start all',
                    onPressed: startAll),
                IconButton(
                    icon: Icon(
                      Icons.stop,
                      color: Color(0xffEBEBEB),
                    ),
                    tooltip: 'Stop all',
                    onPressed: stopAll),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Color(0xffEBEBEB),
                    ),
                    tooltip: 'Add host',
                    onPressed: null),
                IconButton(
                    icon: Icon(
                      Icons.do_disturb_sharp,
                      color: Color(0xffEBEBEB),
                    ),
                    tooltip: 'Delete all',
                    onPressed: null)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text('Status'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Count'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Host'),
                  )
                ]),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Latency'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Graph'),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: bloc.hosts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: snapshot.data,
                  builder: (context, s2) {
                    if (s2.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: s2.data.length,
                          itemBuilder: (_, i) => HostTile(s2.data[i]));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Text('INITIALIZE'),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
