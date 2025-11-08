export class Utilisateur {
  constructor({
    id = null,
    nom = "",
    prenom = "",
    email = "",
    password = "",
    telephone = "",
    adresse = "",
    role = "",
    type_utilisateur = "",
    image_profile = null,
    urlImageProfile = "",
  } = {}) {
    this.id = id;
    this.nom = nom;
    this.prenom = prenom;
    this.email = email;
    this.password = password;
    this.telephone = telephone;
    this.adresse = adresse;
    this.role = role;
    this.type_utilisateur = type_utilisateur;
    this.image_profile = image_profile;
    this.urlImageProfile = urlImageProfile;
  }

  /** Convertit l'objet en JSON prêt à envoyer à l'API */
  toJSON() {
    return {
      id: this.id,
      nom: this.nom,
      prenom: this.prenom,
      email: this.email,
      password: this.password,
      telephone: this.telephone,
      adresse: this.adresse,
      role: this.role,
      type_utilisateur: this.type_utilisateur,
      image_profile: this.image_profile,
    };
  }

  /** Crée une instance Utilisateur à partir d'une réponse JSON */
  static fromJSON(data) {
    if (!data) return null;
    return new Utilisateur({
      id: data.id,
      nom: data.nom,
      prenom: data.prenom,
      email: data.email,
      telephone: data.telephone,
      adresse: data.adresse,
      role: data.role,
      type_utilisateur: data.type_utilisateur,
      urlImageProfile: data.image_profile,
    });
  }
}
export default Utilisateur;
