/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_theme.dart';
import '../../manager/routes/app_navigators.dart';
import '../../widgets/app_circular_image_widget.dart';
import '../../widgets/app_loading_overlay_widget.dart';
import '../../widgets/app_parent_widget.dart';
import '../../widgets/app_text_widget.dart';
import '../../widgets/custom_button_widget.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  //final controller = Get.put(UserListController());
  //final detailsController = Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) => AppParentWidget(
        safeAreaTop: false,
        resizeToAvoidBottomInset: true,
        bottomWidget: SizedBox(
          width: Get.width,
          height: 46.0,
          child: Obx(() {
            return AppButton(
              label: "Load Next",
              labelColor: textColor,
              bgColor: accentColor,
              width: Get.width,
              onTap: () {
                //controller.getNextData(controller: controller);
              },
            );
          }),
        ),
        bodyWidget: Obx(
          () => LoadingOverlay(
            //isLoading: controller.isLoading.value,
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext ctx, int index) => Obx(() {
                    return InkWell(
                      onTap: () {},
                      /*child: ListTile(
                        leading: AppCircularImage(
                          url: controller.ulm.value[index].data?[index].avatar,

                          //url: "data:image/jpeg;base64,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",
                        ),
                        title: AppText(
                          label:
                              "{controller.ulm.value[index].data?[index].firstName}",
                          textStyle: textStyle(
                              size: 16.0, overflow: TextOverflow.ellipsis),
                        ),
                      ),*/
                    );
                  }),
                );
              },
            ),
          ),
        ),
      );
}
