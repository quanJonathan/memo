import 'package:flutter/cupertino.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/utilites/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: context.loc.logout_button,
    content: context.loc.logout_dialog_prompt,
    optionBuilder: ()=>{
      context.loc.cancel: false,
      context.loc.logout_button: true,
    }).then(
      (value) => value?? false,
    );
}
