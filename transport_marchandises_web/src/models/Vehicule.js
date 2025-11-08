export class Vehicule {
  constructor({
    id = null,
    marque = "",
    modele = "",
    immatriculation = "",
    capacite = 0,
    tarif_km = 0,
  } = {}) {
    this.id = id;
    this.marque = marque;
    this.modele = modele;
    this.immatriculation = immatriculation;
    this.capacite = capacite;
    this.tarif_km = tarif_km;
  }

  /** Convertit l'objet en JSON prêt pour une requête API */
  toJSON() {
    return {
      id: this.id,
      marque: this.marque,
      modele: this.modele,
      immatriculation: this.immatriculation,
      capacite: this.capacite,
      tarif_km: this.tarif_km,
    };
  }

  /** Crée une instance Vehicule à partir du JSON retourné par l'API */
  static fromJSON(data) {
    if (!data) return null;
    return new Vehicule({
      id: data.id,
      marque: data.marque,
      modele: data.modele,
      immatriculation: data.immatriculation,
      capacite: parseFloat(data.capacite),
      tarif_km: parseFloat(data.tarif_km),
    });
  }
}
