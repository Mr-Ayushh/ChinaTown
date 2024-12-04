import 'package:dummy_1/utils/exports.dart';

class CounterWidget extends StatefulWidget {
  final int initialCounter;

  const CounterWidget({
    super.key,
    required this.initialCounter,
  });

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialCounter;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _decrementCounter,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Icon(
                Icons.remove_circle_outlined,
                color: _counter > 0 ? AppColors.primary : AppColors.kFFDECF,
                size: 30,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '$_counter',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: _incrementCounter,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: const Icon(
                Icons.add_circle,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
