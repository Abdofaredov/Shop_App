// POST
//UPDATE
// DELETE
// GET
// 1864a1a8635043b3b9723f791ca8ae8e

// base url : https://newsapi.org/

// method (url) : v2/top-headlines?

// queryies : country=eg&category=business&apiKey=0c78ee17d2d145ac97bb45820552859e

//   https://newsapi.org/v2/everything?q=tesla&apiKey=0c78ee17d2d145ac97bb45820552859e

import 'package:abdo123/modules/shop_app/login/shop_login_screen.dart';
import 'package:abdo123/shared/components/components.dart';
import 'package:abdo123/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, const ShopLoginScreen());
    }
  });
}

// دي ميثود جاهزه بتبرينت فول تيكست علشان لو تيكست كبير محتاج يتعمله برينت
void printFullText(String text) {
  final pattern = RegExp('.{1.800}'); // 800 is size of   each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

dynamic token = '';
dynamic uId = '';
