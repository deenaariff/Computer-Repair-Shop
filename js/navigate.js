(function() {

	$(document).ready(function(){

	// current color of navigation
	var NAV_COLOR = '#e575ec'
	// the default color when not clicked
	var DEFAULT_COLOR = '#FFF'

	// get the starting nav item
	var $current = $('#start')

	// set all other items to white
	$('.nav').each(function() {
    	$(this).css('color',DEFAULT_COLOR)
	});

	// set the current to nav color
	$current.css('color',NAV_COLOR)



	// if a nav title is clicked then execute functionality
	$('.nav').click(function() {

		// store the current clicked item in $new
		var $new = $(this)

		// check if current nav title is equal to the new nav title
		// only change page if new nav title is different
		if(!$current.is($new)) {

			// get the item clicked
			value = $new.attr('value');

			// set all other items to white
			$('.nav').each(function() {
	    		$(this).css('color',DEFAULT_COLOR)
			});

			// set this item to nav color
			$new.css('color',NAV_COLOR)

			// navigate to the new page
			var iframe = $('#page');
			iframe.attr('src', value);

			// update current
			$current = $new;
		}
		
	});

	});

})(this);

