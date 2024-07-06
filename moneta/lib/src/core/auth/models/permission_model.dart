import 'dart:convert';

import 'package:flutter/widgets.dart';

class PermissionModel {
  final bool? godMode;
  final bool? canRead;
  final String? msgRead;
  final bool? canUpdate;
  final String? msgUpdate;
  final bool? canDelete;
  final String? msgDelete;
  final bool? canExtra01;
  final String? msgExtra01;
  final bool? canExtra02;
  final String? msgExtra02;
  final bool? canExtra03;
  final String? msgExtra03;
  final bool? canExtra04;
  final String? msgExtra04;
  final bool? canExtra05;
  final String? msgExtra05;

  PermissionModel({
    this.godMode,
    this.canRead,
    this.msgRead,
    this.canUpdate,
    this.msgUpdate,
    this.canDelete,
    this.msgDelete,
    this.canExtra01,
    this.msgExtra01,
    this.canExtra02,
    this.msgExtra02,
    this.canExtra03,
    this.msgExtra03,
    this.canExtra04,
    this.msgExtra04,
    this.canExtra05,
    this.msgExtra05,
  });

  PermissionModel copyWith({
    ValueGetter<bool?>? godMode,
    ValueGetter<bool?>? canRead,
    ValueGetter<String?>? msgRead,
    ValueGetter<bool?>? canUpdate,
    ValueGetter<String?>? msgUpdate,
    ValueGetter<bool?>? canDelete,
    ValueGetter<String?>? msgDelete,
    ValueGetter<bool?>? canExtra01,
    ValueGetter<String?>? msgExtra01,
    ValueGetter<bool?>? canExtra02,
    ValueGetter<String?>? msgExtra02,
    ValueGetter<bool?>? canExtra03,
    ValueGetter<String?>? msgExtra03,
    ValueGetter<bool?>? canExtra04,
    ValueGetter<String?>? msgExtra04,
    ValueGetter<bool?>? canExtra05,
    ValueGetter<String?>? msgExtra05,
  }) {
    return PermissionModel(
      godMode: godMode?.call() ?? this.godMode,
      canRead: canRead?.call() ?? this.canRead,
      msgRead: msgRead?.call() ?? this.msgRead,
      canUpdate: canUpdate?.call() ?? this.canUpdate,
      msgUpdate: msgUpdate?.call() ?? this.msgUpdate,
      canDelete: canDelete?.call() ?? this.canDelete,
      msgDelete: msgDelete?.call() ?? this.msgDelete,
      canExtra01: canExtra01?.call() ?? this.canExtra01,
      msgExtra01: msgExtra01?.call() ?? this.msgExtra01,
      canExtra02: canExtra02?.call() ?? this.canExtra02,
      msgExtra02: msgExtra02?.call() ?? this.msgExtra02,
      canExtra03: canExtra03?.call() ?? this.canExtra03,
      msgExtra03: msgExtra03?.call() ?? this.msgExtra03,
      canExtra04: canExtra04?.call() ?? this.canExtra04,
      msgExtra04: msgExtra04?.call() ?? this.msgExtra04,
      canExtra05: canExtra05?.call() ?? this.canExtra05,
      msgExtra05: msgExtra05?.call() ?? this.msgExtra05,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'godMode': godMode,
      'canRead': canRead,
      'msgRead': msgRead,
      'canUpdate': canUpdate,
      'msgUpdate': msgUpdate,
      'canDelete': canDelete,
      'msgDelete': msgDelete,
      'canExtra01': canExtra01,
      'msgExtra01': msgExtra01,
      'canExtra02': canExtra02,
      'msgExtra02': msgExtra02,
      'canExtra03': canExtra03,
      'msgExtra03': msgExtra03,
      'canExtra04': canExtra04,
      'msgExtra04': msgExtra04,
      'canExtra05': canExtra05,
      'msgExtra05': msgExtra05,
    };
  }

  factory PermissionModel.fromMap(Map<String, dynamic> map) {
    return PermissionModel(
      godMode: map['godMode'],
      canRead: map['canRead'],
      msgRead: map['msgRead'],
      canUpdate: map['canUpdate'],
      msgUpdate: map['msgUpdate'],
      canDelete: map['canDelete'],
      msgDelete: map['msgDelete'],
      canExtra01: map['canExtra01'],
      msgExtra01: map['msgExtra01'],
      canExtra02: map['canExtra02'],
      msgExtra02: map['msgExtra02'],
      canExtra03: map['canExtra03'],
      msgExtra03: map['msgExtra03'],
      canExtra04: map['canExtra04'],
      msgExtra04: map['msgExtra04'],
      canExtra05: map['canExtra05'],
      msgExtra05: map['msgExtra05'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory PermissionModel.fromJson(String source) =>
  //     PermissionModel.fromMap(json.decode(source));

  factory PermissionModel.fromJson(String source) => PermissionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PermissionModel(godMode: $godMode, canRead: $canRead, msgRead: $msgRead, canUpdate: $canUpdate, msgUpdate: $msgUpdate, canDelete: $canDelete, msgDelete: $msgDelete, canExtra01: $canExtra01, msgExtra01: $msgExtra01, canExtra02: $canExtra02, msgExtra02: $msgExtra02, canExtra03: $canExtra03, msgExtra03: $msgExtra03, canExtra04: $canExtra04, msgExtra04: $msgExtra04, canExtra05: $canExtra05, msgExtra05: $msgExtra05)';
  }
}
