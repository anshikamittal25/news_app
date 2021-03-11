import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/filters_page.dart';
import 'package:news_app/services/api_calls.dart';
import 'package:news_app/tiles/news_tile.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = new TextEditingController();
  bool search;

  @override
  void initState() {
    search = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: (search)
            ? TextField(
          autofocus: true,
                controller: _searchController,
          cursorColor: Colors.black12,
          decoration: InputDecoration(hintText: 'Search'),
              )
            : Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (search) {
                setState(() {
                  state.searchOptions.q = _searchController.text;
                  search = !search;
                });
              } else {
                setState(() {
                  search = !search;
                });
              }
            },
          ),
          (search)
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      state.searchOptions.q = '';
                      search = false;
                    });
                  })
              : IconButton(
                  icon: Icon(Icons.filter_list_alt),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FiltersPage()));
                  }),
        ],
      ),
      body: (search)
          ? Center(
              child: Icon(
                Icons.search,
                size: MediaQuery.of(context).size.width / 2,
                color: Colors.grey[350],
              ),
            )
          : FutureBuilder(
              future: topHeadlines(state.searchOptions),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong!'));
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return (snapshot.data.length == 0)
                      ? Center(
                          child: Text('No news found!'),
                        )
                      : ListView(
                          children: snapshot.data.map<Widget>((news) {
                            return newsTile(news);
                          }).toList(),
                        );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}
