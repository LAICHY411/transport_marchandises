// src/utils/selectImage.js

/**
 * Ouvre une boîte de sélection d'image et retourne un objet contenant :
 *  - file: le fichier brut
 *  - preview: une URL utilisable pour afficher l'image
 *  - bytes: un ArrayBuffer (équivalent de Uint8List en Dart)
 */
export async function selectImage() {
  return new Promise((resolve, reject) => {
    const input = document.createElement("input");
    input.type = "file";
    input.accept = "image/*";

    input.onchange = async (event) => {
      const file = event.target.files[0];
      if (!file) {
        resolve(null);
        return;
      }

      const reader = new FileReader();

      reader.onload = () => {
        resolve({
          file: file,
          preview: URL.createObjectURL(file), 
          bytes: reader.result, 
        });
      };

      reader.onerror = (error) => reject(error);
      reader.readAsArrayBuffer(file);
    };

    input.click();
  });
}
