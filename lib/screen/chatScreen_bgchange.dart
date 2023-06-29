import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreenBackgroundChange extends StatefulWidget {
  const ChatScreenBackgroundChange({Key? key}) : super(key: key);

  @override
  State<ChatScreenBackgroundChange> createState() =>
      _ChatScreenBackgroundChangeState();
}

class _ChatScreenBackgroundChangeState
    extends State<ChatScreenBackgroundChange> {
  List image = [
    'assets/images/b1.jpg',
    'assets/images/b2.jpeg',
    'assets/images/b3.jpeg',
    'assets/images/b4.jpeg',
    'assets/images/b5.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat wallpaper'),
        backgroundColor: context.theme.cardColor,
      ),
      backgroundColor: context.theme.canvasColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: image.length,
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs
                        .setString('wallpaper', image[i].toString())
                        .then((value) {
                      Get.snackbar(
                        'Success',
                        'Wallpaper change successfully',
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      );
                    });
                    print(image[i].toString());
                  },
                  child: Card(
                    child: Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                  child: Image(
                                image: AssetImage(image[i]),
                                fit: BoxFit.fill,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5,
                mainAxisExtent: 264,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
