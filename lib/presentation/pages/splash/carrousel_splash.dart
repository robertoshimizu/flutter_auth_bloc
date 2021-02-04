class PageItem {
  String imageUrl;
  String title;
  String description;

  PageItem(this.imageUrl, this.title, this.description);
}

List<PageItem> getPageItems() {
  return <PageItem>[
    PageItem('assets/images/4204968.jpg', 'Conheça melhor!',
        'EuIndico.app é um aplicativo que ajuda pessoas a encontrar profissionais através de indicações de sua rede social.'),
    PageItem('assets/images/10746.png', 'Como funciona?',
        'Você recebe uma notificação de um amigo buscando um profissional.'),
    PageItem('assets/images/10745.png', 'Você indica.',
        'Se você conhecer alguém de confiança você faz uma indicação.'),
    PageItem('assets/images/3026173.png', 'Você resolve o problema.',
        'Você ajuda seu amigo a resolver seu problema e um profissional a encontrar trabalho..'),
  ];
}
