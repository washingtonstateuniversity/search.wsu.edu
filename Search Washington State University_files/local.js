$(document).ready(function() {
  // var search_input = $('input#SearchBox1_TBSearch').value();
  
  var path = window.location.pathname.split( '/' );
  var url = window.location.href;
  if(url.indexOf("site:") != -1) {
  
	  $('body').addClass('subsite-search');
	  
	  var link = '<a href="'+url+'">WSU</a>';
	  var subsite_query = url.substring(url.lastIndexOf("site:")+0);
	  var subsite = subsite_query.replace("site:","");
	  var subsite_link = '<div class="scope"><a href="'+subsite+'">'+subsite+'</a></div>';
	  var global_link = url.replace(subsite_query,"");
	  var tab = '<span><span class="ajax__tab_outer"><span class="ajax__tab_inner"><span class="ajax__tab_tab"><a href="'+global_link+'">WSU</a></span></span></span></span>';
	  var global_link = '<a href="'+global_link+'">WSU</a>';
  
	  $("#__tab_TabContainer1_TabPanel2").text('Subsite');
	  $("#__tab_TabContainer1_TabPanel2").parents('ajax__tab_active').addClass('active-tab');
	  $("#TabContainer1_header > span:first-of-type").after(tab);
	  $('#TabContainer1_body').prepend(subsite_link);
  
  }

});