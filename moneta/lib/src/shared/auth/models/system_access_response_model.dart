import 'dart:convert';

class SystemAccessResponseModel {
  String? code;
  PermissionSystemAccess? permission;

  SystemAccessResponseModel({
    this.code,
    this.permission,
  });

  SystemAccessResponseModel copyWith({
    String? code,
    PermissionSystemAccess? permission,
  }) =>
      SystemAccessResponseModel(
        code: code ?? this.code,
        permission: permission ?? this.permission,
      );

  factory SystemAccessResponseModel.fromRawJson(String str) =>
      SystemAccessResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemAccessResponseModel.fromJson(Map<String, dynamic> json) =>
      SystemAccessResponseModel(
        code: json["code"],
        permission: json["permission"] == null
            ? null
            : PermissionSystemAccess.fromJson(json["permission"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "permission": permission?.toJson(),
      };
}

class PermissionSystemAccess {
  bool? isHide;
  bool? canView;
  String? msgView;
  bool? canCreate;
  String? msgCreate;

  PermissionSystemAccess({
    this.isHide,
    this.canView,
    this.msgView,
    this.canCreate,
    this.msgCreate,
  });

  PermissionSystemAccess copyWith({
    bool? isHide,
    bool? canView,
    String? msgView,
    bool? canCreate,
    String? msgCreate,
  }) =>
      PermissionSystemAccess(
        isHide: isHide ?? this.isHide,
        canView: canView ?? this.canView,
        msgView: msgView ?? this.msgView,
        canCreate: canCreate ?? this.canCreate,
        msgCreate: msgCreate ?? this.msgCreate,
      );

  factory PermissionSystemAccess.fromRawJson(String str) =>
      PermissionSystemAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PermissionSystemAccess.fromJson(Map<String, dynamic> json) =>
      PermissionSystemAccess(
        isHide: json["isHide"],
        canView: json["canView"],
        msgView: json["msgView"],
        canCreate: json["canCreate"],
        msgCreate: json["msgCreate"],
      );

  Map<String, dynamic> toJson() => {
        "isHide": isHide,
        "canView": canView,
        "msgView": msgView,
        "canCreate": canCreate,
        "msgCreate": msgCreate,
      };
}
