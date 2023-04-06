import 'package:flutter/cupertino.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/utilites/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog({required BuildContext context}) {
  return showGenericDialog(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionBuilder: () => {
      context.loc.ok: null,
    },
  );
}
