/// Represents an NTP server configuration
class NtpServer {
  final int id;
  final String address;
  final bool burst;
  final bool iburst;
  final bool prefer;
  final int minpoll;
  final int maxpoll;

  NtpServer({
    required this.id,
    required this.address,
    required this.burst,
    required this.iburst,
    required this.prefer,
    required this.minpoll,
    required this.maxpoll,
  });
}
