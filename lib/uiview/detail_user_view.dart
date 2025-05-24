import 'package:flutter/material.dart';
import 'package:client_server_flutter/model/model_users.dart';

class DetailUserView extends StatelessWidget {
  final ModelUsers user;

  const DetailUserView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _infoTile("Name", user.name),
            _infoTile("Username", user.username),
            _infoTile("Email", user.email),
            _infoTile("Phone", user.phone),
            _infoTile("Website", user.website),
            const Divider(),
            Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
            _infoTile("Street", user.address.street),
            _infoTile("Suite", user.address.suite),
            _infoTile("City", user.address.city),
            _infoTile("Zipcode", user.address.zipcode),
            const Divider(),
            Text("Company", style: TextStyle(fontWeight: FontWeight.bold)),
            _infoTile("Name", user.company.name),
            _infoTile("Catch Phrase", user.company.catchPhrase),
            _infoTile("BS", user.company.bs),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? "-")),
        ],
      ),
    );
  }
}