import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:flutter/material.dart';

class CurrentTransactionTransporter extends StatefulWidget {
  final String courierId;
  final String courierTitle;
  final String senderId;
  const CurrentTransactionTransporter(
      {super.key,
      required this.courierId,
      required this.senderId,
      this.courierTitle = ""});

  @override
  State<CurrentTransactionTransporter> createState() =>
      _CurrentTransactionTransporterState();
}

class _CurrentTransactionTransporterState
    extends State<CurrentTransactionTransporter> {
  int _index = 0;
  String? transactionId;
  Map<String, dynamic>? transaction;
  DocumentReference? transactionRef;
  StreamSubscription? subscription;
  @override
  void initState() {
    final uid = auth.currentUser!.uid;
    subscription = firestore
        .collection("transactions")
        .where("courierId", isEqualTo: widget.courierId)
        .where("transporterId", isEqualTo: uid)
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty && value.docs.first.exists) {
        setState(() {
          transactionId = value.docs.first.id;
          transaction = value.docs.first.data();
          transactionRef = value.docs.first.reference;
          setIndex();
        });
      } else {
        firestore.collection("transactions").add({
          "discussed": TransactionAcceptanceState.none.index,
          "courierId": widget.courierId,
          "transporterId": uid
        }).then((value) {
          setState(() async {
            transactionId = value.id;
            transaction = (await value.get()).data();
            transactionRef = value;
            subscription = value.snapshots().listen((event) {
              setState(() {
                transaction = event.data();
              });
            });
          });
        });
      }
    });
    super.initState();
  }

  setIndex() {
    if (transaction!['productDeliveredToReceiver'] ==
        TransactionAcceptanceState.bothAccepted.index) {
      setState(() {
        _index = 5;
      });
    } else if (transaction!['productReceivedFromSender'] ==
        TransactionAcceptanceState.bothAccepted.index) {
      setState(() {
        _index = 4;
      });
    } else if (transaction!['paymentAccepted'] ==
        TransactionAcceptanceState.bothAccepted.index) {
      setState(() {
        _index = 3;
      });
    } else if (transaction!['dealConfirmed'] ==
        TransactionAcceptanceState.bothAccepted.index) {
      setState(() {
        _index = 2;
      });
    } else if (transaction!['discussed'] ==
        TransactionAcceptanceState.bothAccepted.index) {
      setState(() {
        _index = 1;
      });
    } else {
      setState(() {
        _index = 0;
      });
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courierTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: transactionId == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stepper(
                      currentStep: _index,
                      controlsBuilder: (context, details) {
                        return const SizedBox();
                      },
                      steps: <Step>[
                        Step(
                          title: const Text('Discussion',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                const Text("Waiting For Consumer Confirmation"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: transaction!["discussed"] !=
                                              TransactionAcceptanceState
                                                  .transporterAccepted.index
                                          ? () {
                                              updateState();
                                            }
                                          : null,
                                      child: const Text(
                                        'Done',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Discuss',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          isActive: _index == 0,
                          state: transaction!["discussed"] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const Text('Confirm Deal',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              transaction!["dealConfirmed"] !=
                                      TransactionAcceptanceState
                                          .senderAccepted.index
                                  ? const Text(
                                      "Waiting For Consumer Confirmation")
                                  : const Text("Consumer Confirmed"),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: transaction!["dealConfirmed"] !=
                                            TransactionAcceptanceState
                                                .transporterAccepted.index
                                        ? () {
                                            updateState();
                                          }
                                        : null,
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text('|'),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey)),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isActive: _index == 1,
                          state: transaction!['dealConfirmed'] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const Text('Payment Acceptance',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    transaction!["paymentAccepted"] == null ||
                                            transaction!["paymentAccepted"] !=
                                                TransactionAcceptanceState
                                                    .senderAccepted.index
                                        ? const Text("Not yet paid")
                                        : ElevatedButton(
                                            onPressed: updateState,
                                            child: const Text(
                                              'Yes, Payment done',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          isActive: _index == 2,
                          state: transaction!['paymentAccepted'] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const Text(
                              'Did you received courier from Consumer?',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Row(
                            children: [
                              transaction!["productReceivedFromSender"] ==
                                          null ||
                                      transaction![
                                              "productReceivedFromSender"] !=
                                          TransactionAcceptanceState
                                              .senderAccepted.index
                                  ? const Text(
                                      "Wait, Consumer not yet given courier..")
                                  : ElevatedButton(
                                      onPressed: updateState,
                                      child: const Text(
                                        'Yes, received.',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                            ],
                          ),
                          isActive: _index == 3,
                          state: transaction!['productReceivedFromSender'] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const Text('Courier Delivered To Receiver',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Container(
                            alignment: Alignment.centerLeft,
                            child: transaction!["productDeliveredToReceiver"] ==
                                        null ||
                                    transaction![
                                            "productDeliveredToReceiver"] !=
                                        TransactionAcceptanceState
                                            .senderAccepted.index
                                ? const Text("Wait, Receiver not yet confirmed")
                                : ElevatedButton(
                                    onPressed: updateState,
                                    child: const Text(
                                      'Delivered',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                          ),
                          isActive: _index == 4,
                          state: transaction!['productDeliveredToReceiver'] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: const Text('Thank You',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          content: Container(
                            alignment: Alignment.centerLeft,
                          ),
                          isActive: _index == 5,
                          state: transaction!['productDeliveredToReceiver'] ==
                                  TransactionAcceptanceState.bothAccepted.index
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.chat),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.add_location_alt_rounded),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(Icons.report),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  updateState() {
    getState(_index).then((value) {
      setState(() {
        _index = value;
      });
    });
  }

  Future<int> getState(int index) async {
    switch (index) {
      case 0:
        if (transaction!['discussed'] ==
            TransactionAcceptanceState.none.index) {
          await transactionRef!.set({
            "discussed": TransactionAcceptanceState.transporterAccepted.index
          }, SetOptions(merge: true));
        } else if (transaction!['discussed'] ==
            TransactionAcceptanceState.senderAccepted.index) {
          await transactionRef!.set({
            "discussed": TransactionAcceptanceState.bothAccepted.index,
          }, SetOptions(merge: true));
          return 1;
        }
        return index;
      case 1:
        if (transaction!['dealConfirmed'] == null ||
            transaction!['dealConfirmed'] ==
                TransactionAcceptanceState.none.index) {
          await transactionRef!.set({
            "dealConfirmed":
                TransactionAcceptanceState.transporterAccepted.index
          }, SetOptions(merge: true));
        } else if (transaction!['dealConfirmed'] ==
            TransactionAcceptanceState.senderAccepted.index) {
          await transactionRef!.set(
              {"dealConfirmed": TransactionAcceptanceState.bothAccepted.index},
              SetOptions(merge: true));
          return 2;
        }
        return index;
      case 2:
        if (transaction!['paymentAccepted'] == null ||
            transaction!['paymentAccepted'] ==
                TransactionAcceptanceState.none.index) {
          await transactionRef!.set({
            "paymentAccepted":
                TransactionAcceptanceState.transporterAccepted.index
          }, SetOptions(merge: true));
        } else if (transaction!['paymentAccepted'] ==
            TransactionAcceptanceState.senderAccepted.index) {
          await transactionRef!.set({
            "paymentAccepted": TransactionAcceptanceState.bothAccepted.index
          }, SetOptions(merge: true));
          return 3;
        }
        return index;
      case 3:
        if (transaction!['productReceivedFromSender'] == null ||
            transaction!['productReceivedFromSender'] ==
                TransactionAcceptanceState.none.index) {
          await transactionRef!.set({
            "productReceivedFromSender":
                TransactionAcceptanceState.transporterAccepted.index
          }, SetOptions(merge: true));
        } else if (transaction!['productReceivedFromSender'] ==
            TransactionAcceptanceState.senderAccepted.index) {
          await transactionRef!.set({
            "productReceivedFromSender":
                TransactionAcceptanceState.bothAccepted.index
          }, SetOptions(merge: true));
          return 4;
        }
        return index;
      case 4:
        if (transaction!['productDeliveredToReceiver'] == null ||
            transaction!['productDeliveredToReceiver'] ==
                TransactionAcceptanceState.none.index) {
          await transactionRef!.set({
            "productDeliveredToReceiver":
                TransactionAcceptanceState.transporterAccepted.index
          }, SetOptions(merge: true));
        } else if (transaction!['productDeliveredToReceiver'] ==
            TransactionAcceptanceState.senderAccepted.index) {
          await transactionRef!.set({
            "productDeliveredToReceiver":
                TransactionAcceptanceState.bothAccepted.index
          }, SetOptions(merge: true));
          return 5;
        }
        return index;

      default:
        return 0;
    }
  }
}

enum TransactionAcceptanceState {
  none,
  senderAccepted,
  transporterAccepted,
  bothAccepted,
  senderCanceled,
  transporterCanceled
}
