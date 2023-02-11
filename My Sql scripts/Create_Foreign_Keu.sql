GO
ALTER TABLE f.Traffic
ADD CONSTRAINT fkDate FOREIGN KEY ([kDate])
REFERENCES [dim].[Calendar]([kDate]);

ALTER TABLE f.Traffic
ADD CONSTRAINT fkDirection FOREIGN KEY (k_Direction_of_Travel)
REFERENCES dim.Direction (k_Direction_of_travel);

GO
ALTER TABLE f.Traffic
ADD CONSTRAINT fkHour FOREIGN KEY (k_Hour)
REFERENCES dim.[Hours](k_Hour);

GO
ALTER TABLE [f].[traffic]
ADD CONSTRAINT fkLocal_Authority FOREIGN KEY (k_Local_Authority_id)
REFERENCES dim.LocalAuthority(k_Local_Authority_id);

GO
ALTER TABLE f.Traffic
ADD CONSTRAINT fkRoad_Category FOREIGN KEY (k_Road_category)
REFERENCES dim.RoadCategory (kRoadCategory);  