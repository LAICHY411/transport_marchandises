class Vehicules {
  int? id;
  String? marque;
  String? modele;
  String? immatriculation;
  double? capacite;
  double? tarif_km;
  Vehicules({
    this.id,
    this.marque,
    this.modele,
    this.immatriculation,
    this.capacite,
    this.tarif_km,
  });
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'marque': marque,
      'modele': modele,
      'immatriculation': immatriculation,
      'capacite': capacite,
      'tarif_km': tarif_km,
    };
  }

  static Vehicules? jsonToVehicule(data) {
    if (data == null) return null;

    return Vehicules(
      id: data["id"],
      marque: data['marque'] as String?,
      modele: data['modele'] as String?,
      immatriculation: data['immatriculation'] as String?,
      capacite: double.parse(data['capacite']) as double?,
      tarif_km: double.parse(data['tarif_km']) as double?,
    );
  }
}
