-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.
SELECT nom, texte
FROM commentaires
WHERE article_id = 2
ORDER BY cree_le DESC;
-- 2 lignes : Inès, puis Hugo

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.
SELECT a.id, a.titre, COUNT(c.id) AS nb_commentaires
FROM articles a
LEFT JOIN commentaires c ON c.article_id = a.id
GROUP BY a.id, a.titre
ORDER BY a.id;
--6 lignes : articles 1 à 6, avec 3, 2, 0, 1, 2, 0 commentaires

-- R3. Les articles qui n'ont aucun commentaire : id, titre.
SELECT a.id, a.titre
FROM articles a
WHERE NOT EXISTS (SELECT 1 FROM commentaires c WHERE c.article_id = a.id)
ORDER BY a.id;
--2 lignes : les articles 3 et 6

-- R4. Pour chaque auteur, le nombre total de commentaires recus sur ses articles,
--     du plus commente au moins commente.
SELECT au.prenom AS auteur, COUNT(c.id) AS nb_commentaires
FROM auteurs au
JOIN articles a ON a.auteur_id = au.id
JOIN commentaires c ON c.article_id = a.id
GROUP BY au.id, au.prenom
ORDER BY nb_commentaires DESC;
--3 lignes : Marc 5, Théo 2, Sophie 1

-- R5. Les visiteurs (nom) qui ont commente plus d'un article.
SELECT nom
FROM commentaires
GROUP BY nom
HAVING COUNT(DISTINCT article_id) > 1;
--1 ligne : Claire

-- R6. Les trois commentaires les plus recents, avec le titre de leur article.
SELECT c.id, c.nom, c.texte, c.cree_le, a.titre
FROM commentaires c
JOIN articles a ON a.id = c.article_id
ORDER BY c.cree_le DESC
LIMIT 3;
--	3 lignes : les commentaires 8 (Karim), 7 (Claire) et 6 (Lucie)