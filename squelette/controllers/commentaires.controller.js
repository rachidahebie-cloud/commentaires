// CONTROLEUR des commentaires.
// A ECRIRE : une fonction (req, res, next) par route de CONTRAT.md, comme dans
// controllers/articles.controller.js :
//   1. lire req.params, req.query, req.body ;
//   2. verifier la forme : 400 si un champ obligatoire manque ;
//   3. appeler le service (services/commentaires.service.js) ;
//   4. choisir le code (200, 201 ou 204). Toute erreur part vers next(err).
// Le controleur ne parle JAMAIS a la base : pas de pool ici, seulement le service.

const service = require('../services/commentaires.service');
const ErreurHttp = require('../utils/erreur-http');


async function lister(req, res, next) {
  try {
    const commentaires = await service.lister(Number(req.params.id));
    res.status(200).json(commentaires);
  } catch (err) {
    next(err);
  }
}

async function creer(req, res, next) {
  try {
    const { nom, texte } = req.body;
    if (!nom || !texte) {
      throw new ErreurHttp(400, 'CHAMP_MANQUANT', 'Les champs nom et texte sont obligatoires.');
    }
    const commentaire = await service.creer(Number(req.params.id), nom, texte);
    res.status(201).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function parVisiteur(req, res, next) {
  try {
    const { nom } = req.query;
    if (!nom) {
      throw new ErreurHttp(400, 'NOM_MANQUANT', 'Le paramètre nom est obligatoire.');
    }
    const commentaires = await service.parVisiteur(nom);
    res.status(200).json(commentaires);
  } catch (err) {
    next(err);
  }
}

async function trouver(req, res, next) {
  try {
    const commentaire = await service.trouver(Number(req.params.id));
    res.status(200).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function modifier(req, res, next) {
  try {
    const { texte } = req.body;
    if (!texte) {
      throw new ErreurHttp(400, 'TEXTE_MANQUANT', 'Le champ texte est obligatoire.');
    }
    const commentaire = await service.modifier(Number(req.params.id), texte);
    res.status(200).json(commentaire);
  } catch (err) {
    next(err);
  }
}

async function supprimer(req, res, next) {
  try {
    await service.supprimer(Number(req.params.id));
    res.status(204).end();
  } catch (err) {
    next(err);
  }
}


module.exports = {lister, creer, parVisiteur, trouver, modifier, supprimer};
