ALTER TABLE f.Traffic
DROP CONSTRAINT if exists fkDate
GO
ALTER TABLE f.Traffic
DROP CONSTRAINT if exists fkDirection
GO
ALTER TABLE f.Traffic
DROP CONSTRAINT if exists fkHour
GO
ALTER TABLE f.Traffic
DROP CONSTRAINT if exists fkLocal_Authority
GO
ALTER TABLE f.Traffic
DROP CONSTRAINT if exists fkRoad_Category
GO