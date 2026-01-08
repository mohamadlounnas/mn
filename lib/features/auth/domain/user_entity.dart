abstract class UserEntity {
  final int id;
  final String name;
  final String phone;
  final String? image_url;
  final String role;

  UserEntity({
    required this.id,
    required this.name,
    required this.phone,
    this.image_url,
    required this.role
  });
}