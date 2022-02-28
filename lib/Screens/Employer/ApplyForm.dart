import 'package:flutter/material.dart';
import 'package:jop_portal/helpers/Components.dart';

class Apply_form extends StatelessWidget {
   Apply_form({Key? key}) : super(key: key);
  @override
  var email = TextEditingController();
  var name = TextEditingController();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply For Job'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            formField(controller: name, type: TextInputType.text, prefix: Icons.person),
            formField(controller: email, type: TextInputType.emailAddress, prefix: Icons.email),
            
          ],
        ),
      ),
    );
  }
}
