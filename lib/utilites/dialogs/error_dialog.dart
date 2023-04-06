import 'package:flutter/cupertino.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/utilites/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: context.loc.generic_error_prompt,
    content: text,
    optionBuilder: ()=>{
      context.loc.ok : null,
    },
  );
}
