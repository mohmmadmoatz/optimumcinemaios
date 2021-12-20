import 'package:cinema_project/api/MovieRepo.dart';
import 'package:cinema_project/ui/components/dummies.dart';
import 'package:cinema_project/ui/components/widgets/category/grid_of_categories.dart';
import 'package:cinema_project/ui/components/widgets/search/search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var movierepo = Provider.of<MovieRepo>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black12,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(tr('secondPageTitle'),
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Hero(
              tag: 'searchBar',
              child: SearchBar(
                searchController: _searchController,
                preview: true,
              ),
            ),
          ),
        ),
      ),
      body: GridOfCategories(categories: movierepo.catagory),
    );
  }
}
