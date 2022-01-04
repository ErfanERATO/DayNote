import 'package:day_note_/localization/language_constants.dart';
import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteFormWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   children: [
              //     Switch(
              //       value: isImportant ?? false,
              //       onChanged: onChangedImportant,
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: (number ?? 0).toDouble(),
              //         min: 0,
              //         max: 5,
              //         divisions: 5,
              //         onChanged: (number) => onChangedNumber(number.toInt()),
              //       ),
              //     )
              //   ],
              // ),
              TextFormField(
                maxLines: 1,
                initialValue: title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: getTranslated(context, 'Title')!,
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
                validator: (title) => title != null && title.isEmpty
                    ? getTranslated(context, 'TitleError')!
                    : null,
                onChanged: onChangedTitle,
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 5,
                initialValue: description,
                style: const TextStyle(color: Colors.white60, fontSize: 18),
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: getTranslated(context, 'TypeSomething')!,
                  hintStyle: const TextStyle(color: Colors.white60),
                ),
                validator: (title) => title != null && title.isEmpty
                    ? getTranslated(context, 'DesError')!
                    : null,
                onChanged: onChangedDescription,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );

// TextFormField buildTitle() => TextFormField(
//   maxLines: 1,
//   initialValue: title,
//   style: const TextStyle(
//     color: Colors.white70,
//     fontWeight: FontWeight.bold,
//     fontSize: 24,
//   ),
//   decoration: InputDecoration(
//     border: InputBorder.none,
//     hintText: getTranslated(context, 'Title')!,
//     hintStyle: const TextStyle(color: Colors.white70),
//   ),
//   validator: (title) =>
//   title != null && title.isEmpty ? 'عنوان نمیتواند خالی باشد' : null,
//   onChanged: onChangedTitle,
// );

// Widget buildDescription() => TextFormField(
//       maxLines: 5,
//       initialValue: description,
//       style: const TextStyle(color: Colors.white60, fontSize: 18),
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//         hintText: '...چیزی تایپ کنید',
//         hintStyle: TextStyle(color: Colors.white60),
//       ),
//       validator: (title) => title != null && title.isEmpty
//           ? 'توضیحات نمیتواند خالی باشد'
//           : null,
//       onChanged: onChangedDescription,
//     );
}