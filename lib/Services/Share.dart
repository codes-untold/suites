import 'dart:io';

import 'package:http/http.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';



class ShareClass{


  void shareImage(String imageUrl,String about) async {
    final response = await get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final Directory temp = await getTemporaryDirectory();
    final File imageFile = File('${temp.path}/tempImage');
    imageFile.writeAsBytesSync(bytes);
    Share.shareFiles(['${temp.path}/tempImage'], text: about,);
  }
}