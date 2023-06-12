//단순히 get을 사용하면 헤깔릴까봐
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
    } else {
      throw Error();
    }
  }
}
