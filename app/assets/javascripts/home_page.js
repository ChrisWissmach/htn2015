

$('.pictures').click(function() {
	var pic_id = $(this).attr('id');
	if (pic_id === 'right_pic') {
		$('#right_pic').css('margin-right', '25%');
	}
	$('#' + pic_id).css('width', '150%');
	if (pic_id === 'left_pic') {
		$('#' + pic_id).animate({
			'margin-left': '25%'
		});
	}
	else {
		$('#' + pic_id).animate({
			'margin-right': '25%'
		});
	}
	$('#' + pic_id).delay(200).fadeOut();
	if (pic_id === 'left_pic') {
		$('#right_pic').css('z-index', '-19999');
		$('#right_pic').fadeOut();
	}
	else {
		$('#left_pic').css('z-index', '-19999');
		$('#left_pic').fadeOut();
	}

});