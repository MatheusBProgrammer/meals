import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Error extends StatelessWidget {
  const Error({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERRO'),
        centerTitle: true,
      ),
      body: Center(
          child: Text('Pagina não encontrada')
      ),
    );
  }
}