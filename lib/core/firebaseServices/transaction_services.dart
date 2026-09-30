import 'package:e_stock/model/transaction_model.dart';
import 'package:firebase_database/firebase_database.dart';

import 'auth_services.dart';

class TransactionServices {

  // Auth services
  final AuthServices authServices = AuthServices();

// instance of  the transaction
  final  DatabaseReference transactionsReference= FirebaseDatabase.instance.ref('transactions');


  // Current owner's transactions reference
  DatabaseReference get transactionReference {

    final String? uid = authServices.currentUserId;

    if (uid == null) {
      throw Exception('User is not logged in');
    }

    return transactionsReference.child(uid);
  }
// add the transaction
  Future<void> addTransaction(TransactionModel transaction)async{
    await transactionReference.child(transaction.id).set(transaction.toMap());
  }

  // Get the Transaction
Future<List<TransactionModel>> getTransactions()async{
 final snapshot = await transactionReference.get();

 if(!snapshot.exists){
   return [];
 }
 final data  = Map<String,dynamic>.from(snapshot.value as Map);
 return
   data.values.map((item){
   return TransactionModel.fromMap(Map<String,dynamic>.from(item));
 }).toList();
}
}