import 'dart:convert';
import 'package:http/http.dart' as http;

class FetchMeme {
  static Future<String> fetchNewMeme() async {
    final response = await http.get(Uri.parse("https://api.imgflip.com/get_memes"));
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> bodyData = jsonDecode(response.body);
      
      if (bodyData['success']) {
        final List<dynamic> memes = bodyData['data']['memes'];
        
        // Pick a random meme
        final meme = memes[memes.length * ( DateTime.now().millisecondsSinceEpoch % 1000) ~/ 1000];
        
        return meme['url'];
      } else {
        throw Exception('Failed to load memes');
      }
    } else {
      throw Exception('Failed to fetch memes from API');
    }
  }
}


