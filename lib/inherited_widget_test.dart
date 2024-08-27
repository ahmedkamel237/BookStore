import 'package:flutter/material.dart';

class Inherited extends InheritedModel {
  const Inherited({
    super.key,
    required super.child,
    required this.color,
  });

  final Color color;

  static of(BuildContext context) {
    Inherited? inherited =
        context.dependOnInheritedWidgetOfExactType<Inherited>();
    assert(inherited != null, 'Inherited not found in widget tree');
    return inherited;
  }

  // this method is called when the widget tree changes
  @override
  bool updateShouldNotify(covariant Inherited oldWidget) {
    return oldWidget.color != color;
  }

  @override
  bool updateShouldNotifyDependent(
      covariant InheritedModel<dynamic> oldWidget, Set<dynamic> dependencies) {
    // TODO: implement updateShouldNotifyDependent
    throw UnimplementedError();
  }
}

class ColorBox extends StatelessWidget {
  const ColorBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Inherited.of(context).color,
            ),
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Inherited.of(context).color,
            ),
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Inherited.of(context).color,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      home: Inherited(
        color: Color.fromARGB(040, 235, 0, 0),
        child: ColorBox(),
      ),
    ),
  );
}
