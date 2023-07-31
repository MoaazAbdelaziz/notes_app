import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/widgets/custom_button.dart';
import 'package:notes_app/widgets/custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? noteTitle, noteSubTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextFormField(
            hint: 'Title',
            onSaved: (value) {
              noteTitle = value;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            hint: 'Content',
            maxLines: 5,
            onSaved: (value) {
              noteSubTitle = value;
            },
          ),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var currentDate = DateTime.now();
                    var fromattedCurrentDate =
                        DateFormat('dd-mm-yyyy').format(currentDate);
                    var noteModel = NoteModel(
                      noteTitle: noteTitle!,
                      noteSubTitle: noteSubTitle!,
                      noteDate: fromattedCurrentDate,
                      noteColor: Colors.red.value,
                    );

                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);

                    autovalidateMode = AutovalidateMode.always;
                  }
                  setState(() {});
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
