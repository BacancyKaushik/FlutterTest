import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:testapiproject/models/modelclass.dart';
import 'package:testapiproject/sharedPref.dart';

class hometab extends StatefulWidget {
  @override
  State<hometab> createState() => _hometabState();
}

class _hometabState extends State<hometab> {
  Future<List<ModelClass>> fetchAPI() async
  {
    Dio dio = Dio();
    try {
      var response = await dio.get('https://api.github.com/users');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final model = responseData.map((json) => ModelClass.fromJson(json)).toList();
        return model;
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      log("Error: $e");
      throw Exception("Network error");
    }
  }


  var favArr = <ModelClass>[];
  var userdata = <ModelClass>[];

  SharedPref sharedPref = SharedPref();

  @override
  void initState() {
    super.initState();
    SharedPref.getMyModel().then((value) {
      favArr = value ?? [];
      print("myARR ======${favArr.length}");
    });

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ModelClass>>(
        future: fetchAPI(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ModelClass>> snapshot) {
          log('Length is: ${snapshot.data?.length}');
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipOval(
                    child: SizedBox.fromSize(
                      child: Image.network(
                        '${snapshot.data![index].avatarUrl}',
                      ),
                    ),
                  ),
                  title: Text(
                    '${snapshot.data?[index].login}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      addFavorite(snapshot.data![index]);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: favArr.map((item) => item.id).contains(snapshot.data![index].id) ? Colors.red : Colors.grey,


                      // favArr.isNotEmpty ? ((favArr.firstWhere((it) => it.id == snapshot.data![index]?.id)) != null)
                      //     ? Colors.red
                      //     : Colors.grey : Colors.grey,
                    ),
                  ),
                );
              },
              itemCount: snapshot.data?.length ?? 0,
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.grey,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  addFavorite(ModelClass? snap)
  {
    setState(()
    {
      if (favArr.length > 0)
      {
        if (favArr.map((item) => item.id).contains(snap!.id))
        {
          int index = favArr.indexWhere((st) => st.id == snap!.id);

          if (index != -1) {
            favArr.removeAt(index);
          }
        }
        else
        {
          favArr.add(snap!);
        }
      }
      else
        {
          favArr.add(snap!);
        }

      SharedPref.saveMyModel(favArr);
    });
  }
}
