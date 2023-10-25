import 'package:flutter/material.dart';
import 'package:testapiproject/tabs/favtab.dart';
import 'package:testapiproject/tabs/hometab.dart';


class homepage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('T E S T'),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
              icon: Icon(
                Icons.home,
                color: Colors.indigo,
              ),
            ),
              Tab(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.indigo,
                ),
              )]),
            Expanded(
              child: TabBarView(children: [
                //First Tab
                hometab(),

                favtab()

              ]),
            )

          ],
        ),
      ),
    );
  }

}