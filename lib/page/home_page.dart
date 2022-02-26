import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:json_tree_viewer/json_tree_viewer.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:pretty_json/pretty_json.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:tabbed_view/tabbed_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiSplitViewTheme(
        data: MultiSplitViewThemeData(
          dividerPainter: DividerPainters.grooved1(backgroundColor: Colors.grey.shade200),
        ),
        child: TabbedView(
            controller: TabbedViewController([
          TabData(text: 'Tab1', content: ChildPage(), keepAlive: true),
          TabData(text: 'Tab2', content: ChildPage(), keepAlive: true),
          TabData(text: 'Tab3', content: ChildPage(), keepAlive: true),
        ])),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSplitView(
      minimalWeight: 0.3,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            autofocus: true,
            minLines: 50,
            maxLines: double.maxFinite.toInt(),
            onChanged: (value) {},
            decoration: InputDecoration.collapsed(hintText: "Enter your text here"),
          ),
        ),
        JsonViewerPage(),
      ],
    );
  }
}

const json = {
  "code": 0,
  "message": "",
  "result": {
    "datas": [
      {
        "buyerAmount": 0,
        "classbImg": "",
        "createTime": "",
        "imageInfo": {"fileKey": "", "fileSize": 0, "fileUrl": "", "id": ""},
        "orderNo": "",
        "orderSource": 0,
        "orderSourceDesc": "",
        "orderStatus": 0,
        "payTime": "",
        "productName": "",
        "productSetId": "",
        "productStatus": 0
      }
    ],
    "page": {"begin": 0, "end": 0, "length": 0, "pageCount": 0, "pageNo": 0, "totalRecords": 0}
  }
};

class JsonViewerPage extends StatelessWidget {
  JsonViewerPage({Key? key}) : super(key: key) {
    _editingController.text = prettyJson(json);
  }

  final TextEditingController _editingController = TextEditingController();
  final RxBool _showTable = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Obx(
              () {
                return _showTable.value
                    ? JsonTreeViewer(
                        data: json,
                      )
                    : TextField(
                        minLines: 50,
                        maxLines: double.maxFinite.toInt(),
                        controller: _editingController,
                      );
              },
            ),

            // child: JsonViewer({"text": "name", "sex": "male"}),

            // child: JsonView.string(
            //   '{"key":"value"}',
            //   theme: JsonViewTheme(
            //     keyStyle: TextStyle(
            //       color: Colors.black54,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //     ),
            //     doubleStyle: TextStyle(
            //       color: Colors.green,
            //       fontSize: 16,
            //     ),
            //     intStyle: TextStyle(
            //       color: Colors.green,
            //       fontSize: 16,
            //     ),
            //     stringStyle: TextStyle(
            //       color: Colors.green,
            //       fontSize: 16,
            //     ),
            //     boolStyle: TextStyle(
            //       color: Colors.green,
            //       fontSize: 16,
            //     ),
            //     closeIcon: Icon(
            //       Icons.close,
            //       color: Colors.green,
            //       size: 20,
            //     ),
            //     openIcon: Icon(
            //       Icons.add,
            //       color: Colors.green,
            //       size: 20,
            //     ),
            //     separator: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 8.0),
            //       child: Icon(
            //         Icons.arrow_right_alt_outlined,
            //         size: 20,
            //         color: Colors.green,
            //       ),
            //     ),
            //   ),
            // ),
          ),
          Divider(),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.unfold_less_rounded).rotate(angle: 0.7)),
              IconButton(onPressed: () {}, icon: Icon(Icons.unfold_more_rounded).rotate(angle: 0.7)),
              IconButton(onPressed: _showTable.toggle, icon: Icon(Icons.table_chart_outlined)),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.content_copy_rounded)),
              IconButton(onPressed: () {}, icon: Icon(Icons.save_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.photo_camera_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.ios_share_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.ios_share_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}
