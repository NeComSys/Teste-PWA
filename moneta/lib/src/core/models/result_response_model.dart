// To parse this JSON data, do
//
//     final resultResponseModel = resultResponseModelFromMap(jsonString);

import 'dart:convert';

ResultResponseModel resultResponseModelFromMap(String str) => ResultResponseModel.fromMap(json.decode(str));

String resultResponseModelToMap(ResultResponseModel data) => json.encode(data.toMap());

ResultResponseModel resultResponseModelFromJson(String str) => ResultResponseModel.fromJson(json.decode(str));

String resultResponseModelToJson(ResultResponseModel data) => json.encode(data.toJson());

class ResultResponseModel {
    List<dynamic>? data;
    int? page;
    int? totalPages;
    int? totalCount;
    bool? hasPreviousPage;
    bool? hasNextPage;
    bool? failed;
    dynamic message;
    bool? succeeded;

    ResultResponseModel({
        this.data,
        this.page,
        this.totalPages,
        this.totalCount,
        this.hasPreviousPage,
        this.hasNextPage,
        this.failed,
        this.message,
        this.succeeded,
    });

    ResultResponseModel copyWith({
        List<dynamic>? data,
        int? page,
        int? totalPages,
        int? totalCount,
        bool? hasPreviousPage,
        bool? hasNextPage,
        bool? failed,
        dynamic message,
        bool? succeeded,
    }) => 
        ResultResponseModel(
            data: data ?? this.data,
            page: page ?? this.page,
            totalPages: totalPages ?? this.totalPages,
            totalCount: totalCount ?? this.totalCount,
            hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
            hasNextPage: hasNextPage ?? this.hasNextPage,
            failed: failed ?? this.failed,
            message: message ?? this.message,
            succeeded: succeeded ?? this.succeeded,
        );

    factory ResultResponseModel.fromMap(Map<String, dynamic> json) => ResultResponseModel(
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        page: json["page"],
        totalPages: json["totalPages"],
        totalCount: json["totalCount"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
        failed: json["failed"],
        message: json["message"],
        succeeded: json["succeeded"],
    );

    Map<String, dynamic> toMap() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "page": page,
        "totalPages": totalPages,
        "totalCount": totalCount,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
        "failed": failed,
        "message": message,
        "succeeded": succeeded,
    };

    factory ResultResponseModel.fromJson(Map<String, dynamic> json) => ResultResponseModel(
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        page: json["page"],
        totalPages: json["totalPages"],
        totalCount: json["totalCount"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
        failed: json["failed"],
        message: json["message"],
        succeeded: json["succeeded"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "page": page,
        "totalPages": totalPages,
        "totalCount": totalCount,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
        "failed": failed,
        "message": message,
        "succeeded": succeeded,
    };
}
