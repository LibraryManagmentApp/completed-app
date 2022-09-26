class Book {
  final String id;
  final String imageUrl;
  final String name;
  final String category;
  final double price;
  final String description;
  bool isfavorite;
  Book({this.category, this.description, this.imageUrl, this.name, this.price,this.id,this.isfavorite=false,});
}

List<Book> book = [
  Book(
    id:'m1',
    name: 'السببيةوميكانيكاالكم',
    category:'Scientific Books',
    price: 25,
    description:
    'هذا الكتاب يُلقي الضوءَ على قضايا فلسفية وعلمية في غاية الأهمية'
    ' فهو يقدِّم تحريرًا دقيقًا لمفهوم السببية وعَلاقتها بالعلوم المعاصرة'
    'كما يقدِّم براهينَ صلبة ومتماسكة للاستدلال بالسببية على الخالق'
    'وأثناء ذلك يمر على أهم الشبهات والمعارضات ويفنِّدها جميعًا'
    'والسببيةُ مفهوم منفصل ومستقل تمامًا عن الحتمية',
    imageUrl: 'assets/images/ph0.jpg',
  ),
  Book(
    id:'m2',
    name: 'ابق قويا',
    category: 'Scientific Books',
    price: 25,
    description: 'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'mcnhr kgntejgnerm jdnvjkdfbdflb'
        'ndjnvnfbfdkbdfnbdfbfdmnbfnlb'
        'vsdnbvfdvkfsnklosmmek;l,m'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj'
        'kdmenfjnfnfmmkffnkjf'
        'kdjfnmlkdmvndnvjvkllkvj',

    imageUrl: 'assets/images/ph1.jpg',
  ),
  Book(
    id:'m3',
    name: 'رحلتي من الشك الى الايمان',
    category: 'Novels',
    price: 25,
    description:'',
    imageUrl: 'assets/images/ph2.jpg',
  ),
  Book(
    id:'m4',
    name: 'ليلى والذئب',
    category: 'Childrens Book',
    price: 25,
    description:'',
    imageUrl: 'assets/images/ph3.jpg',
  ),
];