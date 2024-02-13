// To parse this JSON data, do
//
//     final profilePagination = profilePaginationFromJson(jsonString);

import 'dart:convert';

ProfilePagination profilePaginationFromJson(String str) => ProfilePagination.fromJson(json.decode(str));

String profilePaginationToJson(ProfilePagination data) => json.encode(data.toJson());

class ProfilePagination {
  List<Content> content;
  Pageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  ProfilePagination({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  factory ProfilePagination.fromJson(Map<String, dynamic> json) => ProfilePagination(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    last: json["last"],
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "last": last,
    "totalPages": totalPages,
    "totalElements": totalElements,
    "size": size,
    "number": number,
    "sort": sort.toJson(),
    "first": first,
    "numberOfElements": numberOfElements,
    "empty": empty,
  };
}

class Content {
  int id;
  String name;
  String email;
  String phone;
  DateTime birthDate;
  String gender;
  String attachUrl;
  String role;
  String address;
  String status;
  bool visible;

  Content({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.attachUrl,
    required this.role,
    required this.address,
    required this.status,
    required this.visible
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    birthDate: DateTime.parse(json["birthDate"]),
    gender: json["gender"],
    attachUrl: json["attachUrl"],
    role: json["role"],
    address: json["address"],
    status: json['status'],
    visible: json['visible']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "attachUrl": attachUrl,
    "role": role,
    "address": address,
    'status':status,
    'visible':visible
  };
}

class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    paged: json["paged"],
    unpaged: json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "sort": sort.toJson(),
    "offset": offset,
    "paged": paged,
    "unpaged": unpaged,
  };
}

class Sort {
  bool empty;
  bool sorted;
  bool unsorted;

  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    empty: json["empty"],
    sorted: json["sorted"],
    unsorted: json["unsorted"],
  );

  Map<String, dynamic> toJson() => {
    "empty": empty,
    "sorted": sorted,
    "unsorted": unsorted,
  };
}
