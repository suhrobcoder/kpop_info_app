import 'package:flutter/cupertino.dart';

class InfoTile extends StatelessWidget {
  final String name;
  final String info;

  const InfoTile({
    super.key,
    required this.name,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontSize: 20)),
          Expanded(
            child: Text(
              info,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
