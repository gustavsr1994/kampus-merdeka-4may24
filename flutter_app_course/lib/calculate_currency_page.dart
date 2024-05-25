import 'package:flutter/material.dart';
import 'package:flutter_app_course/extend/calculate_cube.dart';
import 'package:flutter_app_course/implement/currency_dollar.dart';
import 'package:flutter_app_course/implement/currency_yen.dart';

import 'extend/calculate_prisma.dart';

class CalculateCurrencyPage extends StatefulWidget {
  const CalculateCurrencyPage({super.key});

  @override
  State<CalculateCurrencyPage> createState() => _CalculateCurrencyPageState();
}

class _CalculateCurrencyPageState extends State<CalculateCurrencyPage> {
  TextEditingController amountCurrencyController = TextEditingController();
  TextEditingController alasCurrencyController = TextEditingController();
  TextEditingController tinggiCurrencyController = TextEditingController();
  num totalAmountCurrency = 0;
  num totalAmountVolume = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                    controller: amountCurrencyController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)))),
              ),
              ElevatedButton(
                  onPressed: () {
                    CurrencyYen yen = CurrencyYen();
                    setState(() {
                      totalAmountCurrency = yen.processRupiah(
                          num.parse(amountCurrencyController.text));
                    });
                  },
                  child: const Text('Yen')),
              ElevatedButton(
                  onPressed: () {
                    CurrencyDollar dollar = CurrencyDollar();
                    setState(() {
                      totalAmountCurrency = dollar.processRupiah(
                          num.parse(amountCurrencyController.text));
                    });
                  },
                  child: const Text('Dollar')),
              Text('Result : $totalAmountCurrency'),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                    controller: alasCurrencyController,
                    
                    decoration: const InputDecoration(
                      hintText: 'Masukkan alas',
                      labelText: 'Alas',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)))),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                    controller: tinggiCurrencyController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan Tinggi',
                      labelText: 'Tinggi',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)))),
              ),
              ElevatedButton(
                  onPressed: () {
                    CalculateCube cube = CalculateCube();
                    setState(() {
                      totalAmountVolume = cube.processVolume(
                          num.parse(alasCurrencyController.text), num.parse(tinggiCurrencyController.text));
                    });
                  },
                  child: const Text('Cube')),
              ElevatedButton(
                  onPressed: () {
                    CalculatePrisma prisma = CalculatePrisma();
                    setState(() {
                      totalAmountVolume = prisma.processVolume(
                          num.parse(alasCurrencyController.text), num.parse(tinggiCurrencyController.text));
                    });
                  },
                  child: const Text('Prisma')),
              Text('Result : $totalAmountVolume')
            ],
          ),
        ),
      ),
    );
  }
}
