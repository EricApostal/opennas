/// Represents system security configuration
class SystemSecurity {
  final bool enableFips;
  final int id;

  SystemSecurity({
    required this.enableFips,
    required this.id,
  });
}
