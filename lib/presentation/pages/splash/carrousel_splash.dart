import 'package:flutter/material.dart';

class PageItem {
  String imageUrl;
  String title;
  String description;
  Color buttomColor;

  PageItem(
    this.imageUrl,
    this.title,
    this.description,
    this.buttomColor,
  );
}

List<PageItem> getPageItems() {
  return <PageItem>[
    PageItem(
      'assets/images/lockup-eu-indico.png',
      'Conheça melhor',
      'EuIndico.app é um aplicativo que ajuda pessoas a encontrar profissionais através de indicações de sua rede social.',
      Color(0xFF158FCA),
    ),
    PageItem(
      'assets/images/lockup-eu-indico.png',
      'Como funciona',
      'Você recebe uma notificação de um amigo buscando um profissional.',
      Color(0xFF84BC75),
    ),
    PageItem(
      'assets/images/lockup-eu-indico.png',
      'Você indica',
      'Se você conhecer alguém de confiança você faz uma indicação.',
      Color(0xFFEE6B20),
    ),
    PageItem(
      'assets/images/lockup-eu-indico.png',
      'Você resolve o problema',
      'Você ajuda seu amigo a resolver seu problema e um profissional a encontrar trabalho.',
      Color(0xFF71196F),
    ),
  ];
}
