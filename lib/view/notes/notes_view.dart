import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memo/constants/routes.dart';
import 'package:memo/enums/menu_actions.dart';
import 'package:memo/extension/buildContext/loc.dart';
import 'package:memo/services/auth/auth_service.dart';
import 'package:memo/services/auth/bloc/auth_bloc.dart';
import 'package:memo/services/auth/bloc/auth_event.dart';
import 'package:memo/services/cloud/cloud_note.dart';
import 'package:memo/services/cloud/firebase_cloud_storage.dart';
import 'package:memo/utilites/dialogs/logout_dialog.dart';
import 'package:memo/view/notes/notes_list_view.dart';

extension Count<T extends Iterable> on Stream<T> {
  Stream<int> get getLength => map((event) => event.length);
}

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final FirebaseCloudStorage _notesService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: _notesService.allNotes(ownerUserId: userId).getLength,
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              final noteCount = snapshot.data ?? 0;
              final text = context.loc.notes_title(noteCount);
              return Text(text);  
            } else {
              return const Text("");
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoutes);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    context.read<AuthBloc>().add(const AuthEventLoggedOut());
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text(context.loc.logout_button),
                )
              ];
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.documentId);
                  },
                  onTap: (note) {
                    Navigator.of(context)
                        .pushNamed(createOrUpdateNoteRoutes, arguments: note);
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }

            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
