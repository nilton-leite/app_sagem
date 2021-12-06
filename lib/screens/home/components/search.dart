import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final Function(String, int) function;
  final TextEditingController search;

  const Search({Key key, this.function, this.search}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static final TextEditingController _search = new TextEditingController();
  String get searchText => _search.text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: TextField(
          controller: _search,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFCC39191),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintStyle: TextStyle(color: Color(0xFFCC39191)),
            hintText: "Nome da atendente...",
            suffixIcon: searchText.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _search.text = '';
                      });

                      widget.function('', 0);
                    },
                    icon: Icon(Icons.close_rounded),
                    focusColor: Color(0xFFCC39191),
                    color: Color(0xFFCC39191),
                  )
                : IconButton(
                    onPressed: () {
                      widget.function(searchText, 0);
                    },
                    icon: Icon(Icons.search),
                    focusColor: Color(0xFFCC39191),
                    color: Color(0xFFCC39191),
                  ),
          ),
        ),
      ),
    );
  }
}
