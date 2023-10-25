import 'package:flutter/material.dart';
import 'package:testapiproject/models/modelclass.dart';
import 'package:testapiproject/sharedPref.dart';

class favtab extends StatefulWidget
{
  @override
  State<favtab> createState() => _favtabState();
}

class _favtabState extends State<favtab>
{
  var favArr = <ModelClass>[];

  SharedPref sharedPref = SharedPref();

  @override
  void initState()
  {
    super.initState();
    SharedPref.getMyModel().then((value)
    {
      setState(() {
        favArr = value ?? [];
        print("myARR ======${favArr.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return  ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: ClipOval(
            child: SizedBox.fromSize(
              child: Image.network(
                '${favArr[index].avatarUrl}',
              ),
            ),
          ),
          title: Text(
            '${favArr[index].login}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            onPressed: ()
            {
              addFavorite(favArr[index]);
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.red
            ),
          ),
        );
      },
      itemCount: favArr.length ?? 0,
      separatorBuilder: (context, index)
      {
        return const Divider(
          height: 10,
          thickness: 1,
          color: Colors.grey,
        );
      },
    );
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

      }
      SharedPref.saveMyModel(favArr);
    });
  }
}
