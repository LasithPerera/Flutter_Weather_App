import 'package:flutter/material.dart';

class LocationSelector extends StatefulWidget {
  final Function(String) onLocationChanged;

  LocationSelector({required this.onLocationChanged});

  @override
  _LocationSelectorState createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Location',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter location',
            ),
            onSubmitted: (value) {
              widget.onLocationChanged(value);
            },
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              widget.onLocationChanged(_controller.text);
            },
            child: Text('Update Location'),
          ),
        ],
      ),
    );
  }
}
