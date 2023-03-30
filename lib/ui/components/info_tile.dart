import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String name;
  final String info;
  final bool even;

  const InfoTile({
    super.key,
    required this.name,
    required this.info,
    required this.even,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      color: even ? CupertinoColors.systemGrey6 : Colors.transparent,
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
