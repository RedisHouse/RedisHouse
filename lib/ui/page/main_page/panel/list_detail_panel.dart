
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:redis_house/bloc/model/main_page_data.dart';

class ListDetailPanel extends StatefulWidget {
  final ListKeyDetail keyDetail;
  ListDetailPanel(this.keyDetail):super(key: ValueKey(keyDetail.key));
  @override
  State<StatefulWidget> createState() {
    return _ListDetailPanelState();
  }
}

class _ListDetailPanelState extends State<ListDetailPanel> {

  TextEditingController _keyEditingController;
  TextEditingController _valueEditingController;

  @override
  void initState() {
    super.initState();
    _keyEditingController = TextEditingController(text: widget.keyDetail.key);
    _valueEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _keyEditingController?.dispose();
    _valueEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text("${widget.keyDetail.type.toUpperCase()}"),
              SizedBox(width: 10,),
              Expanded(child: TextField(
                readOnly: true,
                controller: _keyEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(),
                ),
              )),
              MaterialButton(
                onPressed: () {
                  BotToast.showText(text: "重命名 Key");
                },
                child: Text("重命名"),
              ),
              MaterialButton(
                onPressed: () {
                  BotToast.showText(text: "修改 TTL");
                },
                child: Text("TTL: ${widget.keyDetail.ttl}"),
              ),
              MaterialButton(
                onPressed: () {
                  BotToast.showText(text: "删除 KEY");
                },
                child: Text("删除"),
              ),
            ],
          ),
        ),
        Container(color: Colors.green, height: 200,),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _valueEditingController,
            maxLines: 200,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        )),
      ],
    );
  }

}