import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/services/auth/bloc/auth_bloc.dart';
import 'package:memo/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.loc.verify_email,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(context.loc.verify_email_view_prompt),
            TextButton(
              onPressed: () async {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: Text(context.loc.verify_email_send_email_verification),
            ),
            TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLoggedOut());
              },
              child: Text(context.loc.restart),
            )
          ],
        ),
      ),
    );
  }
}
