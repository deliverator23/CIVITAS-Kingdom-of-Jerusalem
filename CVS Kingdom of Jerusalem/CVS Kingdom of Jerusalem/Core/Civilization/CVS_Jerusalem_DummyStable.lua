-- TCS_Jerusalem_DummyStable
-- Author: LeeS
-- DateCreated: 8/31/2017 12:09:37 PM
--------------------------------------------------------------
local iFreeBuildingForCivOnly = GameInfo.Buildings["TCS_BUILDING_STABLE_DUMMY"].Index
local iFreeBuildingForEveryoneElse = GameInfo.Buildings["TCS_BUILDING_STABLE_DUMMY_ALTERNATE"].Index

function CityFoundedFreeBuildings(iPlayer, iCityID)
	if (iPlayer == 63) then return end
	local pPlayer = Players[iPlayer];
	local pCity = pPlayer:GetCities():FindID(iCityID)
	local iCityPlotIndex = Map.GetPlot(pCity:GetX(), pCity:GetY()):GetIndex()
	if (PlayerConfigurations[iPlayer]:GetCivilizationTypeName() == "TCS_CIVILIZATION_JERUSALEM") then
		if pCity:GetBuildings():HasBuilding(iFreeBuildingForEveryoneElse) then
			pCity:GetBuildings():RemoveBuilding(iFreeBuildingForEveryoneElse)
		end
		if not pCity:GetBuildings():HasBuilding(iFreeBuildingForCivOnly) then
			pCity:GetBuildQueue():CreateIncompleteBuilding(iFreeBuildingForCivOnly, iCityPlotIndex, 100);
		else
			if pCity:GetBuildings():IsPillaged(iFreeBuildingForCivOnly) then
				pCity:GetBuildings():SetPillaged(iFreeBuildingForCivOnly, false)
			end
		end
	else
		if pCity:GetBuildings():HasBuilding(iFreeBuildingForCivOnly) then
			pCity:GetBuildings():RemoveBuilding(iFreeBuildingForCivOnly)
		end
		if not pCity:GetBuildings():HasBuilding(iFreeBuildingForEveryoneElse) then
			pCity:GetBuildQueue():CreateIncompleteBuilding(iFreeBuildingForEveryoneElse, iCityPlotIndex, 100);
		else
			if pCity:GetBuildings():IsPillaged(iFreeBuildingForEveryoneElse) then
				pCity:GetBuildings():SetPillaged(iFreeBuildingForEveryoneElse, false)
			end
		end
	end
end
Events.CityInitialized.Add(CityFoundedFreeBuildings)