import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sendmail extends StatefulWidget {
  const Sendmail({Key? key}) : super(key: key);

  @override
  State<Sendmail> createState() => _SendmailState();
}

class _SendmailState extends State<Sendmail> {
  final mailbody = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: mailbody,
              minLines: 3,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  hintText: 'Tell us how can we help',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Please reach out if you have any questions and feel free to ask. You will be notified as soon as your request is processed.',
            ),
            const SizedBox(height: 20.0),
            const Text(
              'We will respond to you soon.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                launch(
                    'mailto:patilmrunalini7156@gmail.com,chavanshamal0305@gmail.com?subject=Test app&body=${Uri.encodeFull(mailbody.text)}');
              },
              child: const Text(
                'Proceed',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
