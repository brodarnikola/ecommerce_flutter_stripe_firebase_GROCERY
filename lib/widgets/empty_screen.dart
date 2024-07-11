import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feeds_screen.dart';
import 'package:grocery_app/services/global_methods.dart';
import 'package:grocery_app/widgets/text_widget.dart';

import '../services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText,
      this.route = FeedsScreen.routeName,
      this.navigateBack = false})
      : super(key: key);
  final String imagePath, title, subtitle, buttonText, route;
  final bool navigateBack;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Whoops!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(text: title, color: Colors.cyan, textSize: 20),
              const SizedBox(
                height: 20,
              ),
              subtitle.isNotEmpty
                  ? TextWidget(text: subtitle, color: Colors.cyan, textSize: 20)
                  : Container(),
              // TextWidget(text: subtitle, color: Colors.cyan, textSize: 20),
              subtitle.isNotEmpty
                  ? SizedBox(height: size.height * 0.1)
                  : Container(),
              buttonText.isNotEmpty
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: color,
                          ),
                        ),
                        // onPrimary: color,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                      ),
                      onPressed: () {
                        if (navigateBack) {
                          Navigator.pop(context);
                        } else {
                          GlobalMethods.navigateTo(
                              ctx: context,
                              routeName: route); //FeedsScreen.routeName);
                        }
                      },
                      child: TextWidget(
                        text: buttonText,
                        textSize: 20,
                        color: themeState
                            ? Colors.grey.shade300
                            : Colors.grey.shade800,
                        isTitle: true,
                      ),
                    )
                  : Container(),
            ]),
      )),
    );
  }
}
