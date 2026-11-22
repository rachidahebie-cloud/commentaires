-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.
SELECT nom, texte
FROM commentaires
WHERE article_id = 2
ORDER BY cree_le DESC;

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.
SELECT a.id, a.titre, COUNT(c.id) AS nb_commentaires
FROM articles a
LEFT JOIN commentaires c ON c.article_id = a.id
GROUP BY a.id, a.titre
ORDER BY a.id;

-- R3. Les articles qui n'ont aucun commentaire : id, titre.


-- R4. Pour chaque auteur, le nombre total de commentaires recus sur ses articles,
--     du plus commente au moins commente.


-- R5. Les visiteurs (nom) qui ont commente plus d'un article.


-- R6. Les trois commentaires les plus recents, avec le titre de leur article.