import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  final PageController? controller;
  final int? page;

  const DrawerTile(
      {Key? key, this.iconData, this.text, this.controller, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller?.jumpToPage(page!);
        },
        child: SizedBox(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                iconData,
                size: 32.0,
                color: controller?.page!.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              const SizedBox(width: 32.0),
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 16.0,
                  color: controller?.page!.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
