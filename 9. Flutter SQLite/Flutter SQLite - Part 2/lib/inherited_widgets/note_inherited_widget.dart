
import 'package:flutter/material.dart';

class NoteInheritedWidget extends InheritedWidget {

  final notes = [
    {
      'title': 'asdmaskldmsklasdmaskldmsklasdmaskldmsklasdmaskldmskl',
      'text': 'asdmaskldmsklasdmaskldmsklasdmaskldmsklasdmaskldmskl'
    },
    {
      'title': 'sadkaskdsadkaskdsadkaskdsadkaskd',
      'text': 'sadkasksadkasksadkasksadkasksadkasksadkask'
    },
    {
      'title': 'asafas3253asafas3253asafas3253asafas3253',
      'text': '3asafas3253asafas3253asafa3asafas3253asafas3253asafa3asafas3253asafas3253asafa'
    }
  ];

  NoteInheritedWidget(Widget child) : super(child: child);

  static NoteInheritedWidget of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NoteInheritedWidget)as NoteInheritedWidget);
  }

  @override
  bool updateShouldNotify( NoteInheritedWidget oldWidget) {
    return oldWidget.notes != notes;
  }
}
