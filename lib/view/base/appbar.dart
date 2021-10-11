import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, canBack, {actionButtons}) {
  return AppBar(
    title: const Text('ToDo App'),
    automaticallyImplyLeading: canBack,
    actions: actionButtons,
  );
}
