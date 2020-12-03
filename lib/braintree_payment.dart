// import 'package:flutter/material.dart';
// import 'package:braintree_payment/braintree_payment.dart';
//
//
// class Pay extends StatefulWidget {
//   @override
//   _PayState createState() => _PayState();
// }
//
// class _PayState extends State<Pay> {
//   String clientNonce ="sandbox_d5nfz2pg_d855fjp6yfzjw9g4";
//
//
//
//   payNow() async {
//     BraintreePayment braintreePayment = new BraintreePayment();
//     var data = await braintreePayment.showDropIn(
//         nonce: clientNonce, amount: "2.0", enableGooglePay: true, nameRequired:true);
//     print("Response of the payment $data");
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pay Now"),
//       ),
//       body: Center(
//         child: FlatButton(
//           onPressed: payNow,
//           color: Colors.teal,
//           child: Text(
//             "Pay Now",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }