class Bank {
  final String id;
  final String swift;
  final String name;

  Bank({
    required this.id,
    required this.swift,
    required this.name,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      swift: json['swift'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson(String accountNumber) {
    return {
      'id': id,
      'swift': swift,
      'name': name,
      'account_number': accountNumber,
    };
  }

  static final banks = [
    Bank(
      id: "971bd28c-ff80-420b-a0db-0a1a4be6ee8b",
      swift: "ABAYETAA",
      name: "Abay Bank",
    ),
    Bank(
      id: "80a510ea-7497-4499-8b49-ac13a3ab7d07",
      swift: "AWINETAA",
      name: "Awash Bank",
    ),
    Bank(
      id: "32735b19-bb36-4cd7-b226-fb7451cd98f0",
      swift: "ABYSETAA",
      name: "Bank of Abyssinia",
    ),
    Bank(
      id: "96e41186-29ba-4e30-b013-2ca36d7e7025",
      swift: "CBETETAA",
      name: "Commercial Bank of Ethiopia (CBE)",
    ),
    Bank(
      id: "f5dd0ca8-0e84-4dbe-a147-fb153ea97d9c",
      swift: "CBORETA",
      name: "Cooperative Bank of Oromia (COOP)",
    ),
    Bank(
      id: "809814c1-ab98-4750-a5b8-3be5db7bd5f5",
      swift: "DASHETAA",
      name: "Dashen Bank",
    ),
    Bank(
      id: "800144e5-ae3d-4fc9-a25d-0632f31f5c73",
      swift: "UNTDETAA",
      name: "Hibret Bank",
    ),
    Bank(
      id: "853d0598-9c01-41ab-ac99-48eab4da1513",
      swift: "TELEBIRR",
      name: "telebirr",
    ),
    Bank(
      id: "742a2912-01e5-4e04-baab-b2cc4fc20f8b",
      swift: "WEGAETAA",
      name: "Wegagen Bank",
    ),
    Bank(
      id: "32b1c5b7-1ca3-4da0-aedf-3c0aaac5277e",
      swift: "ZEMEETAA",
      name: "Zemen Bank",
    ),
  ];
}
