import 'package:flutter/cupertino.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/utilites/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: context.loc.sharing,
    content: context.loc.cannot_share_empty_note_prompt,
    optionBuilder: () =>{
      context.loc.ok: null,
    },
  );
}
