
import 'dart:convert';

List<Budget> budgetFromJson(String str) =>
    List<Budget>.from(json.decode(str).map((x) =>
        Budget.fromJson(x)));

String budgetToJson(List<Budget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Budget{
  late int id;
  double amount;
  String description;
  String date;
  String month;
  String owner;

  Budget( this.amount, this.description, this.date, this.month,
      this.owner);

  @override
  String toString() {
    return 'Budget{amount: $amount, description: $description, date: $date, month: $month, owner: $owner}';
  }

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
    json["amount"],
    json["description"],
    json["date"],
    json["month"],
    json["owner"],
  );
  Map<String, dynamic> toJson() => {
    "amount": amount,
    "description": description,
    "date": date,
    "month": month,
    "owner": owner,
  };

}
