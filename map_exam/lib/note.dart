class Note {
  final dynamic nid;
  String? title;
  String? info;
  String? userEmail;

  Note({this.nid = 0, this.title = '', this.info = '', this.userEmail});

  Note.fromJson(Map<String, dynamic> json)
      : this(nid: json['nid'], title: json['title'], info: json['info'], userEmail: json['userEmail']);

  Map<String, dynamic> toJson() =>
      {'nid': nid, 'title': title, 'info': info, 'userEmail':userEmail};
}
