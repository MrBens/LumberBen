SET @job_name = 'lumberjack';
SET @society_name = 'society_lumberjack';
SET @job_Name_Caps = 'Bûcheron';

INSERT INTO `addon_account` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    (@society_name, @job_Name_Caps, 1)
;

INSERT INTO `jobs` (name, label) VALUES
  (@job_name, @job_Name_Caps)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  (@job_name, 0, 'recrue', 'Recrue', 300, '{}', '{}'),
  (@job_name, 1, 'timber', 'Employé(e)', 300, '{}', '{}'),
  (@job_name, 2, 'workchief', 'Chef de chantier', 300, '{}', '{}'),
  (@job_name, 3, 'viceboss', 'Co-gérant', 500, '{}', '{}'),
  (@job_name, 4, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('wood', 'Bois', 20),
    ('cutted_wood', 'Bois coupé', 20),
    ('packaged_plank', 'Paquet de planches', 20)
;