import 'dart:io';

import 'package:flutter/material.dart';

class NavigationController {
  Future go(BuildContext context, String route) async {
    await Navigator.pushNamed(context, route);
  }

  Future goWithData(BuildContext context, String route, data) async {
    await Navigator.pushNamed(context, route, arguments: data);
  }

  goBack(
    BuildContext context,
  ) {
    Navigator.pop(context);
  }

  goAndRemoveUntil(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => true);
  }
}
