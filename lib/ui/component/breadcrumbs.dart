
import 'package:flutter/material.dart';

typedef BreadcrumbsItemBuilder = Widget Function(BuildContext context, int index);

class Breadcrumbs extends StatefulWidget {

  final int itemCount;

  final BreadcrumbsItemBuilder itemBuilder;

  Breadcrumbs(this.itemCount, this.itemBuilder) : assert(itemCount >= 0), assert(itemBuilder != null);

  @override
  State<StatefulWidget> createState() {
    return _BreadcrumbsState();
  }
}

class _BreadcrumbsState<T> extends State<Breadcrumbs> {

  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void afterFirstLayout(BuildContext context) {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 50.0),
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      ),
    );
  }

}