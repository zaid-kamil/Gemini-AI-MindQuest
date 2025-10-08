import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String name;
  final String roll;
  final String branch;
  final String college;
  final String email;
  final String mobile;
  final int timestamp;
  final String createdAt;

  const UserData({
    required this.name,
    required this.roll,
    required this.branch,
    required this.college,
    required this.email,
    required this.mobile,
    required this.timestamp,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roll': roll,
      'branch': branch,
      'college': college,
      'email': email,
      'mobile': mobile,
      'timestamp': timestamp,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [
        name,
        roll,
        branch,
        college,
        email,
        mobile,
        timestamp,
        createdAt,
      ];
}
