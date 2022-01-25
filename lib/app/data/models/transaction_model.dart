class TransactionModel {
  String? _id;
  // @virtual
  String? get id => _id;
  void setId(String? id) {
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
  String? contact;
  String? photoUrl;

  TransactionModel({
    required this.ownerId,
    required this.title,
    required this.date,
    required this.isCompleted,
    required this.amount,
    this.contact,
    this.photoUrl,
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
      contact: data['contact'],
      photoUrl: data['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
      'isCompleted': isCompleted,
      'contact': contact,
      'photoUrl': photoUrl,
    };
  }
}
