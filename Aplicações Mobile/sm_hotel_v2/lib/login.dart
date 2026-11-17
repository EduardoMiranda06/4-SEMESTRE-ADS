import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cadastro.dart';
import 'home.dart';
import 'main.dart' show kMarinho, kCoral;

/// Emulador Android: 10.0.2.2 | iOS/Web/Desktop: localhost | celular: IP do PC
const String baseUrl = 'http://10.0.2.2:3000';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  bool _carregando = false;
  bool _ocultarSenha = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _senhaCtrl.dispose();
    super.dispose();
  }

  void _msg(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _entrar() async {
    final email = _emailCtrl.text.trim();
    final senha = _senhaCtrl.text;
    if (email.isEmpty || senha.isEmpty) {
      _msg('Preencha e-mail e senha');
      return;
    }
    setState(() => _carregando = true);
    try {
      final uri = Uri.parse('$baseUrl/usuario')
          .replace(queryParameters: {'email': email, 'senha': senha});
      final resp = await http.get(uri).timeout(const Duration(seconds: 8));
      if (resp.statusCode == 200) {
        final List lista = jsonDecode(resp.body);
        if (lista.isNotEmpty) {
          if (!mounted) return;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Home()));
        } else {
          _msg('E-mail ou senha inválidos');
        }
      } else {
        _msg('Erro no servidor (${resp.statusCode})');
      }
    } catch (e) {
      _msg('Não foi possível conectar ao Json Server');
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kMarinho, Color(0xFF1B4B7A)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  const Icon(Icons.travel_explore, size: 72, color: kCoral),
                  const SizedBox(height: 12),
                  const Text('S&M Hotel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800)),
                  const Text('Sua próxima viagem começa aqui',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 36),
                  TextField(
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'E-mail', prefixIcon: Icon(Icons.email)),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _senhaCtrl,
                    obscureText: _ocultarSenha,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_ocultarSenha
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () =>
                            setState(() => _ocultarSenha = !_ocultarSenha),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _carregando ? null : _entrar,
                      child: _carregando
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Text('Entrar',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Cadastro())),
                    child: const Text('Criar conta',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
