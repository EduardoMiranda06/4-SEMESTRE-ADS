import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrinho.dart';
import 'main.dart' show kMarinho, kCoral;

class Destino extends StatefulWidget {
  final String nome;
  final String img;
  final int valord;
  final int valorp;

  const Destino(this.nome, this.img, this.valord, this.valorp, {super.key});

  @override
  State<Destino> createState() => _DestinoState();
}

class _DestinoState extends State<Destino> {
  int n_diarias = 0;
  int n_pessoas = 0;
  int total = 0;

  // B1 - incrementa diárias
  void dias() => setState(() => n_diarias++);

  // B2 - incrementa acompanhantes
  void pessoas() => setState(() => n_pessoas++);

  // B3 - calcula o total e envia ao carrinho (Provider)
  void calctotal() {
    final r = context.read<Carrinho>().calctotal(
          nome: widget.nome,
          nDiarias: n_diarias,
          valord: widget.valord,
          nPessoas: n_pessoas,
          valorp: widget.valorp,
        );
    setState(() => total = r);
  }

  // B4 - zera tudo
  void limpar() {
    context.read<Carrinho>().remover(widget.nome);
    setState(() {
      n_diarias = 0;
      n_pessoas = 0;
      total = 0;
    });
  }

  Widget _contador(String rotulo, int valor, VoidCallback onAdd) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
        decoration: BoxDecoration(
          color: kMarinho.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(rotulo,
                      style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  Text('$valor',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            IconButton.filled(
              onPressed: onAdd,
              style: IconButton.styleFrom(backgroundColor: kCoral),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Image.asset(widget.img, fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.65)],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 12,
                child: Text(widget.nome,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                        label: Text('R\$ ${widget.valord}/dia'),
                        backgroundColor: kCoral.withOpacity(0.15)),
                    Chip(
                        label: Text('R\$ ${widget.valorp}/pessoa'),
                        backgroundColor: kCoral.withOpacity(0.15)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '1 Quarto • banheiro • TV • WiFi • ar-condicionado',
                  style: TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _contador('Dias', n_diarias, dias),
                    const SizedBox(width: 10),
                    _contador('Pessoas', n_pessoas, pessoas),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text('Total  R\$ $total',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800)),
                    ),
                    OutlinedButton(onPressed: limpar, child: const Text('Limpar')),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: calctotal, child: const Text('Calcular')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
