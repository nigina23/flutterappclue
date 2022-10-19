class CatalogModel {
  static final items = [
    Item(
        id: 1,
        name: "Tag mit Daten",
        image:
            "https://cdn.discordapp.com/attachments/819393219460202547/1034196877723312158/IMG_6820.jpg"),
    Item(
        id: 2,
        name: "Tag ohne Daten",
        image:
            "https://cdn.discordapp.com/attachments/819393219460202547/1034196877530382386/IMG_6821.jpg"),
    Item(
        id: 3,
        name: "Tag in der Zukunft",
        image:
            "https://cdn.discordapp.com/attachments/819393219460202547/1034196878046277672/IMG_6822.jpg"),
    Item(
        id: 4,
        name: "Blutung: leicht",
        image:
            "https://cdn.discordapp.com/attachments/819393219460202547/1034196877903675412/IMG_6823.jpg"),
    Item(
        id: 5,
        name: "Blutung: mittel",
        image:
            "https://cdn.discordapp.com/attachments/819393219460202547/1034196877693964378/IMG_6824.jpg"),
    Item(
        id: 6,
        name: "Blutung: stark",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034196877622644806/IMG_6825.jpg"),
    Item(
        id: 7,
        name: "Schmierblutungen",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034196877610065950/IMG_6826.jpg"),
    Item(
        id: 8,
        name: "Voraussichtliche Menstruation",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034196877815582790/IMG_6827.jpg"),
    Item(
        id: 9,
        name: "Eisprung-Tag",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103719669790/IMG_6830.jpg"),
    Item(
        id: 10,
        name: "Hohe Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103749042307/IMG_6831.jpg"),
    Item(
        id: 11,
        name: "Mittlere Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103619006554/IMG_6832.jpg"),
    Item(
        id: 12,
        name: "Geringe Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103803572336/IMG_6833.jpg"),
    Item(
        id: 13,
        name: "Voraussichtlicher Eisprungtag",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103795171450/IMG_6834.jpg"),
    Item(
        id: 14,
        name: "Voraussichtlich hohe Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103858098206/IMG_6835.jpg"),
    Item(
        id: 15,
        name: "Voraussichtlich mittlere Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232104067801120/IMG_6836.jpg"),
    Item(
        id: 16,
        name: "Voraussichtlich geringe Fruchtbarkeit",
        image:
        "https://cdn.discordapp.com/attachments/819393219460202547/1034232103660965918/IMG_6837.jpg"),
  ];
}

class Item {
  final int id;
  final String name;
  final String image;

  Item(
      {required this.id,
      required this.name,
      required this.image});
}
