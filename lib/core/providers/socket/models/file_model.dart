class FileModel {
  File? file;
  String? id;

  FileModel({this.file, this.id});

  FileModel.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? File.fromJson(json['file']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class File {
  String? filename;
  String? fileBase64;

  File({this.filename, this.fileBase64});

  File.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    fileBase64 = json['fileBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['fileBase64'] = fileBase64;
    return data;
  }
}
