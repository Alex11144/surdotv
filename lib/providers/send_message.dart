import 'package:http/http.dart' as http;

class SendMessage {
  String name;
  String email;
  String phone;
  String city;
  String message;

  SendMessage({this.name, this.email, this.phone, this.city, this.message});

  Future<void> sendMail() async {
    final url = Uri.http(
      'api.surdotv.az',
      '/api/send-message',
    );


    final msgBody = {
      'api_key':
          'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789',
      'Content-Type': 'application/x-www-form-urlencoded',
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
      'message': message,
    };
    print(msgBody);

    final resp = await http.post(url, headers: msgBody);
    if (resp.statusCode >= 400) return;
  }
}
