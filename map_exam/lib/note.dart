class Note {
  String? id;
  String? title;
  String? content;
  String? userEmail;

  Note({this.id = '', this.title = '', this.content = '', this.userEmail});

  Note.fromJson(Map<String, dynamic> json)
      : this(id: json['nid'], title: json['title'], content: json['content'], userEmail: json['userEmail']);

  Map<String, dynamic> toJson() =>
      {'nid': id, 'title': title, 'content': content, 'userEmail':userEmail};
}
