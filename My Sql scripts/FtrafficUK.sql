SELECT [Count_point_id]
	   ,cal.kDate
      ,d.k_Direction_of_travel
      ,hr.k_Hour
      ,la.k_Local_Authority_ID
      ,rc.[kRoadCategory] as 'k_Road_Category'
      ,uk.[Latitude]
      ,uk.[Longitude]
      ,uk.[Pedal_cycles]
      ,uk.[Two_wheeled_motor_vehicles]
      ,uk.[Cars_and_taxis]
      ,uk.[Buses_and_coaches]
      ,uk.[LGVs]
      ,uk.[HGVs_2_rigid_axle]
      ,uk.[HGVs_3_rigid_axle]
      ,uk.[HGVs_4_or_more_rigid_axle]
      ,uk.[HGVs_3_or_4_articulated_axle]
      ,uk.[HGVs_5_articulated_axle]
      ,uk.[HGVs_6_articulated_axle]
      ,uk.[All_HGVs]
      ,uk.[All_motor_vehicles]
  FROM [RoadTraffic].[stg].[Uk_Traffic] uk
       inner join dim.Direction d
        on d.Direction_of_travel = uk.Direction_of_travel
	   inner join dim.Calendar cal
	     on uk.Count_date = cal.Date
		inner join dim.[Hours] hr
		  on uk.[hour] = hr.[Hour]
		inner join dim.LocalAuthority la
		  on uk.Local_authority_id = la.Local_Authority_ID
		inner join dim.RoadCategory rc
		  on uk.Road_category = rc.RoadCategory