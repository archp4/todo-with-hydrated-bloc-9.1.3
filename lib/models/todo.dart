// ignore_for_file: public_member_api_docs, sort_constructors_first

class TodoModel {
  final String title;
  final String subtitle;
  bool isDone;

  TodoModel({
    this.title = '',
    this.subtitle = '',
    this.isDone = false,
  });

  TodoModel copyWith({
    String? title,
    String? subtitle,
    bool? isDone,
  }) {
    return TodoModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'subtitle': subtitle,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
      subtitle: map['subtitle'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  @override
  String toString() =>
      'TodoModel(title: $title, subtitle: $subtitle, isDone: $isDone)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.subtitle == subtitle &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ isDone.hashCode;
}
