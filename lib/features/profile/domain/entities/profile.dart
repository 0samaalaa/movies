class Profile {
  final String name;
  final String phone;
  final int avatarId;
  final String? email;

  Profile({
    required this.name,
    required this.phone,
    required this.avatarId,
    this.email,
  });
}
