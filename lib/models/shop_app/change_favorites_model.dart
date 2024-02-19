// هل انا عملت موديل علشان استقبل لا

// ف احنا بنعمل الموديل علشان نستقبل فيه الداتا من الاي بي اي

class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
