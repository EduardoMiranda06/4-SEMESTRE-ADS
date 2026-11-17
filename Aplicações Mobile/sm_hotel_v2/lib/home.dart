import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';
import 'checkout.dart';
import 'destino.dart';
import 'main.dart' show kCoral;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<Carrinho>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Para onde vamos?'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Badge(
              isLabelVisible: carrinho.itens.isNotEmpty,
              label: Text('${carrinho.itens.length}'),
              backgroundColor: kCoral,
              child: IconButton(
                icon: const Icon(Icons.shopping_bag_outlined),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Checkout())),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Destino("Angra dos Reis", "imagens/angra.jpg", 384, 70),
          Destino("Arraial do Cabo", "imagens/arraial.jpg", 571, 65),
          Destino("Florianópolis", "imagens/flori.jpg", 348, 85),
          Destino("Jericoacoara", "imagens/jeri.jpg", 571, 75),
          Destino("Chile", "imagens/chile.jpg", 446, 95),
          Destino("Madrid", "imagens/madri.jpg", 401, 85),
          Destino("Paris", "imagens/paris.jpg", 546, 95),
          Destino("Roma", "imagens/roma.jpg", 478, 85),
          Destino("Orlando", "imagens/orlando.jpg", 616, 105),
          Destino("LasVegas", "imagens/lasvegas.jpg", 504, 110),
        ],
      ),
    );
  }
}
