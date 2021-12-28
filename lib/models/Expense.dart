class Expense {
   String docis;
   String title;
   double expense;
   String authid;

  Expense({
    this.docis,
    this.title,
    this.expense,
    this.authid,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        docis: json["docis"],
        title: json["title"],
        expense: json["expense"],
        authid: json["authid"],
      );

  Map toJson() => {
        "docis": docis,
        "title": title,
        "expense": expense,
        "authid": authid,
      };

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["docis"] = docis;
    map["title"] = title;
    map["expense"] = expense;
    map["authid"] = authid;
    return map;
  }
}
