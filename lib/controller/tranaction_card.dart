import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:spendtrkr/app/data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final Function(TransactionModel)? onDelete;
  final Function(TransactionModel, bool)? onCheckClicked;
  const TransactionCard({
    Key? key,
    required this.transaction,
    this.onDelete,
    this.onCheckClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: context.theme.scaffoldBackgroundColor,
        child: ListTile(
          trailing: IconButton(
            onPressed: () => onDelete?.call(transaction),
            icon: const Icon(Icons.delete),
          ),
          title: Text(transaction.title),
          subtitle: Text('${transaction.amount}\$'),
          leading: IconButton(
            onPressed: () =>
                onCheckClicked?.call(transaction, !transaction.isCompleted),
            icon: Icon(transaction.isCompleted
                ? Icons.check_box
                : Icons.check_box_outline_blank),
          ),
        ),
      ),
    );
  }
}
