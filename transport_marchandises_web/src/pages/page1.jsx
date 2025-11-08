import React from "react";

export default function Profile() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-gray-50 p-6">
      <div className="bg-white shadow-lg rounded-2xl p-8 w-full max-w-md text-center">
        <h1 className="text-3xl font-bold text-yellow-900 mb-4">Profil</h1>
        <p className="text-gray-700">
          Bienvenue sur votre page de profil 👋
        </p>
      </div>
    </div>
  );
}
