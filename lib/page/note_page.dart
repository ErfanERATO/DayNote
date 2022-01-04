import 'package:day_note_/classes/language.dart';
import 'package:day_note_/database/note_data_base.dart';
import 'package:day_note_/localization/language_constants.dart';
import 'package:day_note_/main.dart';
import 'package:day_note_/model/note_model.dart';
import 'package:day_note_/page/edit_note_page.dart';
import 'package:day_note_/page/note_detail_page.dart';
import 'package:day_note_/widget/note_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    DayNote.setLocale(context, _locale);
  }

  late List<NoteModel> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NoteDatabase.instance.readAllNote();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          /* Do something here if you want */
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              getTranslated(context, 'Notes')!,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: "assets/fonts/farsi/IRANYekanMobileMedium.ttf",
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<Language>(
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  onChanged: (Language? language) {
                    _changeLanguage(language!);
                  },
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: const TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          body: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : notes.isEmpty
                    ? Text(
                        getTranslated(context, 'NoNotes')!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily:
                              "assets/fonts/farsi/IRANYekanMobileMedium.ttf",
                        ),
                      )
                    : buildNotes(),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.orange,
            child: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AddEditNotePage()),
              );
              refreshNotes();
            },
          ),
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
