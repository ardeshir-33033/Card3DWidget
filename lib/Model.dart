class Card3D {
  String imageAddress;
  String? title;
  String? author;
  int id;

  Card3D(this.imageAddress, this.author, this.title, this.id);
}

List<Card3D> cardList = [
  Card3D("asset/images/sting.jpg", "Sting", "The Police", 1),
  Card3D("asset/images/pinkfloyd.jpg", "PinkFloyd", "The Rainbow", 2),
  Card3D("asset/images/radiohead.jpg", "RadioHead", "Creep", 3),
  Card3D("asset/images/starboy.jpg", "The Weeknd", "Feel it Coming", 4),
  Card3D("asset/images/johnlenon.jpg", "John Lennon","Dream" ,5),
];
