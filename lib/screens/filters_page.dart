import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';
import 'home_page.dart';

class FiltersPage extends StatefulWidget {
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  List<String> _categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  String category;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    category = state.searchOptions.category;

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter your search'),
        //title: Consumer<String>(builder: (_,state,__)=>Text('Filter $state'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              'Categories:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Wrap(
              spacing: 10,
              children: List<Widget>.generate(_categories.length, (index) {
                bool isSelected =
                    state.searchOptions.category == _categories[index];
                return FilterChip(
                  selectedColor: Theme.of(context).accentColor,
                  selected: isSelected,
                  checkmarkColor: Colors.white,
                  label: Text(_categories[index]),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: (isSelected)
                          ? Colors.white70
                          : Theme.of(context).textTheme.bodyText1.color),
                  onSelected: (bool selected) {
                    if (selected) {
                      setState(() {
                        state.searchOptions.category = _categories[index];
                      });
                    } else {
                      setState(() {
                        state.searchOptions.category = null;
                      });
                    }
                  },
                );
              }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    state.searchOptions.category=category;
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  title: 'Top Headlines',
                                )),
                        (route) => false);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
