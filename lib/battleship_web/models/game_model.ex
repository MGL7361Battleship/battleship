defmodule Battleship.Game do

  def get_json(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end

  def read_initial_state() do
    get_json("lib/battleship_web/models/initial_state.json")
  end

  def update_etat_case(structure, nom_joueur, nom_bateau, position_case, nouveau_statut) do
    id_joueur = Enum.find_index(structure["monde"]["joueurs"], &(&1 == nom_joueur))
    bateau_a_modifier = Enum.at(structure[nom_bateau], id_joueur)
    etat_cases = bateau_a_modifier["etat_cases"]
    nouvel_etat_cases = List.replace_at(etat_cases, position_case, nouveau_statut)
    nouveau_bateau = put_in(bateau_a_modifier["etat_cases"], nouvel_etat_cases)
    put_in(structure[nom_bateau], List.replace_at(structure[nom_bateau], id_joueur, nouveau_bateau))
  end

  def changer_nom_joueur(structure, id_joueur, nom_joueur) do
    nouveaux_joueurs = List.replace_at structure["monde"]["joueurs"], id_joueur, nom_joueur
    put_in structure["monde"]["joueurs"], nouveaux_joueurs
  end

end