function showMap(){
//	callSid("initPage");
	//locateByIpWithZoomLevel("allmap", 14);
//	createMapByCoordinate("allmap", "117.414002,39.146778", 18);
//	enableScrollWheelZoom();
//	enableContinuousZoom();
//	callSid("loadDoorCoordinate");
//	callSid("loadRoadPointCoordinate");

}


var Condition = {};
function queryTrajectory() {
	Condition.licence = $('#licence').val().trim();
	Condition.vin = $('#vin').val().trim();
	Condition.tempLicence = $('#tempLicence').val();

	callSid("queryTrajectoryPoints",Condition);
	
}
function showTrajectoryPoints(results){
//	clearOverlays();
//	if(results == null || results.length == 0) {
//		MsgboxCtrl.showAlertDialog("没有过车数据");
//	}
	var startPoint;
	var endPoint;
	var passCoordinates = new Array();
	for(var i = 0; i< results.length;i++){
		addMarkByCoordinate(results[i].trajectoryPointLocation);
		if(i == 0) {
			startPoint = results[i].trajectoryPointLocation;
		} else if(i == results.length - 1) {
			endPoint = results[i].trajectoryPointLocation;
		} else {
		passCoordinates.push(results[i].trajectoryPointLocation);
//		}
	}
	drawPathByPoints("#1B8BEE",passCoordinates);
	//searchTableData("queryTrajectoryPointsForTable",Condition,"trajectoryPointTable");
}
}
//
//var licenceType;
//function loadPage(result){
//	licenceType=result;
//	var selectObj = document.getElementById("licenceType");
//	selectObj.options.length = 0;
//	var optArray = new Array();
//	var opt = new SelectBoxOption("", -1, 0);
//	optArray.push(opt);
//	for (var i = 0; i < result.length; i++) {
//		var opt = new SelectBoxOption(result[i].licenceTypeName,
//				result[i].licenceTypeCode, i + 1);
//		optArray.push(opt);
//	}
//	SelectBoxCtr.addOptions('licenceType', optArray);
//	query();
//}
//
//function loadDoorCoordinatePage(results) {
//	for(var i = 0; i < results.length;i++) {
//		addMarkByCoordinate(results[i]);
//	}
//}
//function loadRoadPointCoordinatePage(results) {
//	for(var i = 0; i < results.length;i++) {
//		addMarkByCoordinate(results[i]);
//	}
//}

