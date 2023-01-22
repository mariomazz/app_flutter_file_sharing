import 'dart:convert';

FileModel fileModelFromJson(String str) => FileModel.fromJson(json.decode(str));

String fileModelToJson(FileModel data) => json.encode(data.toJson());

class FileModel {
  FileModel({
    this.id,
    this.filename,
    this.fileBase64,
  });

  final String? id;
  final String? filename;
  final String? fileBase64;

  FileModel copyWith({
    String? id,
    String? filename,
    String? fileBase64,
  }) =>
      FileModel(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        fileBase64: fileBase64 ?? this.fileBase64,
      );

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        filename: json["filename"],
        fileBase64: json["fileBase64"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "fileBase64": fileBase64,
      };
}
