function requestImages(){
	$.post("/competition/get_pictures", {
	}, function(data) {
		if (data.success === true) {
			console.log(data);
			$(".left_pic").attr("src",data.first_image_url).fadeIn("slow");
			$(".left_pic").attr("data-picture_id",data.first_image.id);
			$(".right_pic").attr("src",data.second_image_url).fadeIn("slow");
			$(".right_pic").attr("data-picture_id",data.second_image.id);
		}});
	
};

requestImages();

$(".pic_select").on("click",function(){
	var selected_pic = $(this).attr("data-picture_id");
	var ids = []
	var non_selected_pic;
	ids.push($($(".pic_select")[0]).attr("data-picture_id"));
	ids.push($($(".pic_select")[1]).attr("data-picture_id"));
	var i;
	if (ids[0] == selected_pic){
		non_selected_pic = ids[1];
	}
	else{
		non_selected_pic = ids[0]
	}
	
	$.post("/competition/elo", {
		winner: selected_pic,
		loser: non_selected_pic
	}, function(data) {
		if (data.success === true) {
			console.log(data);
			$(this).css("zoom","150%");
			requestImages();
			}
	});
	
	


})