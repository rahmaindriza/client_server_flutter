import 'dart:convert';
import 'package:client_server_flutter/model/model_users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_user_view.dart';

class PageListUserView extends StatefulWidget {
  const PageListUserView({super.key});

  @override
  State<PageListUserView> createState() => _PageListUserViewState();
}

class _PageListUserViewState extends State<PageListUserView> {

  bool isLoading = false;
  List<ModelUsers> listUsers = [];

  Future getUser() async{
    try{
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var data = res.body;

      setState(() {
        var decodedData = json.decode(data);
        for(var i in decodedData){
          listUsers.add(ModelUsers.fromJson(i));
        }
      });
    }
    catch(e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  void initState(){
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List User'),
        ),

        body: ListView.builder(
          itemCount: listUsers.length,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Card(
                child: ListTile(
                  title: Text(listUsers[index].name ?? "",
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listUsers[index].username ?? "",),
                      Text(listUsers[index].email ?? "",),
                      Text(listUsers[index].address.city ?? "",),

                      //untuk memanggil string di dalam string
                      Text("Email : +listUsers[index].email" ),
                      Text("Company : ${listUsers[index].company.name}"),


                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailUserView(user: listUsers[index]),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )

    );
  }
}