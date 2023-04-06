import 'package:flutter/cupertino.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/utilites/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: context.loc.delete,
    content: context.loc.delete_note_prompt,
    optionBuilder: ()=>{
      context.loc.cancel: false,
      context.loc.yes: true,
    }).then(
      (value) => value?? false,
    );
}