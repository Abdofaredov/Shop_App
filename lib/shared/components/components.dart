import 'package:abdo123/layout/shop_app/cubit.dart';
import 'package:abdo123/shared/styles/colors.dart';
import 'package:abdo123/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton({
  required String text,
  required Function() function,
  Color? color,
  double? size,
  FontWeight? fontWeight,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase(),
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: fontWeight,
          )),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required Function() function,
  required String text,
}) =>
    Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFromField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  Function()? onTap,
  required String? Function(String?)? validate,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      enabled: isClickable,
      onChanged: onChange,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String txet,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: txet,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

// enm هو عباره لو عندي حاجه جايالي في كذا اختيار وعاوز اتوجل بينهم علشان اسهل بينهم
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
    case ToastStates.ERROR:
      color = Colors.red;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              if (model != null &&
                  model.discount != null &&
                  model.discount! != 0 &&
                  isOldPrice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, height: 1.4),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, height: 1.3, color: defaultColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model != null &&
                        model.discount != null &&
                        model.discount! != 0 &&
                        isOldPrice)
                      Text(
                        model.oldPrice!.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10,
                            height: 1.3,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopLayoutCubit.get(context)
                              .changeFavorites(model.id!);
                          print(model.id.toString());
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopLayoutCubit.get(context)
                                      .favorites[model.id!] !=
                                  null
                              ? ShopLayoutCubit.get(context)
                                      .favorites[model.id!]!
                                  ? defaultColor
                                  : Colors.grey
                              : Colors.grey,
                          radius: 15,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2),
      ),
      titleSpacing: 5.0,
      title: Text(title!),
      actions: actions,
    );
