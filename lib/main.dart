import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(35, 166, 240, 1)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      floatingActionButton: FabWithOptions(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class FabWithOptions extends StatefulWidget {
  @override
  _FabWithOptionsState createState() => _FabWithOptionsState();
}

class _FabWithOptionsState extends State<FabWithOptions> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ActionWidget(isOpen: _isOpen, icon: Icon(Icons.add, color: Colors.white,), title: 'Action 1', width: 202.0, height: 61.0, margin_bottom: 150.0, margin_right: 60.0,),
        ActionWidget(isOpen: _isOpen, icon: Icon(Icons.remove, color: Colors.white), title: 'Action 2', width: 161.0, height: 61.0, margin_bottom: 80.0, margin_right: 60.0,),
        ActionWidget(isOpen: _isOpen, icon: Icon(Icons.check, color: Colors.white), title: 'Action 3', width: 121.0, height: 61.0, margin_bottom: 10.0, margin_right: 60.0,),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            heroTag: 'fab',
            backgroundColor: Color.fromRGBO(35, 166, 240, 1),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            shape: CircleBorder(),
            onPressed: _toggle,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Transform.rotate(
                angle: _animation.value * 1.57,
                child: const Icon(Icons.add, color: Colors.white, size: 27, ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class ActionWidget extends StatelessWidget {
  final isOpen;
  final title;
  final width;
  final height;
  final icon;
  final margin_bottom;
  final margin_right;
  const ActionWidget({super.key, required this.isOpen, required this.title, required this.width, required this.height, required this.icon, required this.margin_bottom, required this.margin_right});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 350),
      opacity: isOpen ? 1 : 0,
      child: Container(
        margin: EdgeInsets.only(bottom: margin_bottom, right: margin_right),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Color.fromRGBO(35, 166, 240, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon,
              Text(title, style: TextStyle(color: Colors.white, fontSize: 14), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}

