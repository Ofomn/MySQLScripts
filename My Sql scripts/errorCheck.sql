USE RoadTraffic;

SELECT count(*) as 'DirectionRow'
FROM dim.Direction;


SELECT count(*) as 'errDirectionRow'
FROM [err].[eDirection];


SELECT count(*) as 'LocalAuthoritiesRow'
FROM [dim].[LocalAuthority];


SELECT count(*) as 'errLocalAuthoritiesRow'
FROM [err].[eLocalAuthority];
 

SELECT count(*)as 'HourRow'
FROM [dim].[Hours];


SELECT count(*)as 'errHourRow'
FROM [err].[eHours];


SELECT count(*)as 'RoadCategoryRow'
FROM [dim].[RoadCategory];


SELECT count(*)as 'errRoadCategoryRow'
FROM [err].[eRoadCategory];


SELECT count(*) as 'CalendarRow'
FROM [dim].[Calendar];


SELECT count(*) as 'UKTrafficRow'
FROM [stg].[Uk_Traffic];


SELECT count(*) as 'fTrafficRow'
FROM [f].[traffic];

