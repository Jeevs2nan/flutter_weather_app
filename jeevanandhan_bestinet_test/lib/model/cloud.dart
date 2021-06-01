class Cloud {
  final int all;

  Cloud({required this.all});

  factory Cloud.fromJson(Map<String, dynamic> json) {
    return Cloud(all: json['all']);
  }
}
