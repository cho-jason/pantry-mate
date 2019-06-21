import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _iconSize = 20.0;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).indicatorColor,
              tabs: [
                Tab(icon: Icon(Icons.view_list, size: _iconSize)),
                // Tab(icon: Icon(Icons.restaurant, size: _iconSize)),
                // Tab(icon: Icon(Icons.local_cafe, size: _iconSize)),
                Tab(icon: Icon(Icons.camera_alt, size: _iconSize)),
                Tab(icon: Icon(Icons.settings, size: _iconSize)),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(5.0),
          child: TabBarView(
            // Placeholders for content of the tabs:
            children: [
              Center(child: Icon(Icons.view_list)),
              // Center(child: Icon(Icons.restaurant)),
              // Center(child: Icon(Icons.local_cafe)),
              Center(child: Icon(Icons.camera_alt)),
              Center(child: Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}
