import 'package:spendtrkr/app/data/models/coordinate.dart';

class TransactionModel {
  String? _id;
  // @virtual
  String? get id => _id;
  set id(String? id) {
    if (id != _id && _id != null) {
      throw Exception('Id already set');
    }
    _id = id;
  }

  /// @virtual
  String ownerId;

  String title;
  double amount;
  DateTime date;
  bool isCompleted;
  Coordinate? coordinate;

  TransactionModel({
    required this.ownerId,
    required this.title,
    required this.date,
    required this.isCompleted,
    required this.amount,
    this.coordinate,
    String? id,
  }) : _id = id;

  factory TransactionModel.fromMap(
      {required Map data, required String ownerId, String? id}) {
    return TransactionModel(
      id: id,
      ownerId: ownerId,
      title: data['title'],
      amount: data['amount'],
      date: data['date'].toDate(),
      isCompleted: data['isCompleted'],
      coordinate: Coordinate.tryFomList(data['coordinate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
      'isCompleted': isCompleted,
      'coordinate': coordinate?.toJson(),
    };
  }
}
