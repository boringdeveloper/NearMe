import 'package:flutter/material.dart';
import 'package:nearme/core/constants/constants.dart';
import 'package:provider/provider.dart';

import 'package:nearme/core/features/list_page/list_page.model.dart';
import 'package:nearme/core/models/location.model.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ListPageModel listModel;

  @override
  void didChangeDependencies() {
    listModel = Provider.of<ListPageModel>(
      context,
      listen: false,
    );
    listModel.getLocations();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('LatLong Sort'),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'My Location',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${myLocation["lat"].toString()}, ${myLocation["long"].toString()}',
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      listModel.sortLocation();
                    });
                  },
                  child: Text('Sort Near Me'),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.black54,
                ),
                Selector<ListPageModel, List<Location>>(
                  selector: (_, listModel) => listModel.locations,
                  builder: (_, data, __) {
                    if (data.isEmpty) {
                      return Center(
                        child: Text("No Data Found"),
                      );
                    }

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        Location location = data[index];

                        return ListTile(
                          dense: true,
                          title: Text(
                            location.name,
                          ),
                          subtitle: Text('${location.lat}, ${location.long}'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
