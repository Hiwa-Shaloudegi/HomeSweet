class CostTable {
  static const String name = 'cost';

  // Fields (Columns)
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String date = 'date';
  static const String amount = 'amount';
  static const String receiptImage = 'receiptImage';

  static final List<String> allColumns = [
    id,
    title,
    description,
    date,
    amount,
    receiptImage,
  ];
}

class Cost {
  int? id;
  String? title;
  String? description;
  String? date;
  int? amount;
  String? receiptImage;

  Cost({
    this.id,
    this.title,
    this.description,
    this.date,
    this.amount,
    this.receiptImage,
  });

  Cost.fromMap(Map<String, dynamic> map) {
    id = map[CostTable.id];
    title = map[CostTable.title];
    description = map[CostTable.description];
    date = map[CostTable.date];
    amount = map[CostTable.amount];
    receiptImage = map[CostTable.receiptImage];
  }

  Map<String, dynamic> toMap() {
    return {
      CostTable.id: id,
      CostTable.title: title,
      CostTable.description: description,
      CostTable.date: date,
      CostTable.amount: amount,
      CostTable.receiptImage: receiptImage,
    };
  }
}
