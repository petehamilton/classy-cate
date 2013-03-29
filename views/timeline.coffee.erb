#///////////////////////////////////////////////////////////////////////////////
#///////////////////////// jQuery Timeline Plugin //////////////////////////////
#
# AUTHOR - Lawrence Jones  / GITHUB - www.github.com/lmj112   /   VERSION - 1.0
#
# DESCRIPTION - A simple timeline plugin that allows a variety of different
#               information to be processed and displayed on the timeline. There
#				is a strong emphasis on event start and termination.
# 
# LICENSE - This work is licensed under Creative Commons Attribution-ShareAlike 
#           3.0 Unported License. To view a copy of this license, visit 
#           http://creativecommons.org/licenses/by-sa/3.0/. 
#
#/////////////// © 2011 Lawrence Jones All Rights Reserved /////////////////////

#///////////////////////////////////////////////////////////////////////////////
# CREATION - USER FUNCTIONS
#///////////////////////////////////////////////////////////////////////////////

#--------------- EXPOSED CREATION CALL, HOOKED ON WINDOW -----------------------
# Run createEmptyTimeline with the first variables, then use the populate
# function to place the array of moments into the current timeline
window.createTimelineWithMoments = (startDate, endDate, interval, jQueryObject, moments, structure) ->
	if startDate? and endDate? and interval? and jQueryObject? and moments? and moments[0]? and structure?
		spine = createEmptyTimeline(
			startDate, endDate, interval 
			jQueryObject, structure )
		m.spine = spine for m in moments
		createMomentsAtSpine moments, spine
		bindExpandAllToOrigin spine.parent().data('originCircle'), moments, spine
		spine.parent()
	else
		console.log "One of the initial variables is invalid."
		console.log moments.length


#--------------- CREATE THE EMPTY TIMELINE INSIDE J_OBJ -----------------------
# Given start/end dates, important intervals ('day' | 'month'), the
# jQuery object into which to insert the timeline div and a structure
# for the moment details content, do it!
createEmptyTimeline = (startDate, endDate, interval, jQueryObject, structure) ->
	container = createTimelineContainer jQueryObject # create the timeline in the jQO
	leftBuffer = 3 # arbitrary choice
	start = parseDate startDate 	# convert the string yyyy-mm-dd
	end = parseDate endDate     	# to the javascript date type
	# setup the container utils property
	setContainerData container, start, end, leftBuffer, structure
	# produce the interval information
	intervals = produceIntervals startDate, endDate, interval
	# create & draw a spine, then draw in the markers and circle
	spine = drawTimelineSpine container, intervals, drawInMarkers, drawTimelineOriginCircle


#---------------------- CREATE AND PLACE ALL MOMENTS --------------------------
# With the given moment, insert that information into the (also given) 
# spine object
createMomentsAtSpine = (moments, spine) ->
	spine.data('moments',moments)
	(m = createMomentAtSpine m, spine, getUtils(spine)) for m in moments
	moments = assignMomentTopValues moments, spine
	m.lblContainer.delay(1700).fadeIn {
		duration : 600
		complete : -> m.animateStartWire() for m in moments
	} for m in moments


#----------------- DEAL WITH A SINGLE MOMENT PLACEMENT ------------------------
# With the given moment, insert it into the given spine
createMomentAtSpine = (m, spine, utils) ->
	createAndPlaceMomentDots m, spine
	createAndPlaceMomentInfo m, spine


#//////////////////////////////////////////////////////////////////////////////
# UTILITIES 
#//////////////////////////////////////////////////////////////////////////////

#------------ INITIALISE THE CONTAINER DATA WITH JQUERY -----------------------
# Set container to hold data on the start date of the current timeline,
# the end date and the buffer for the start of the markers.
setContainerData = (container, start, end, markerLeftBuffer, structure)  ->
	container.data
		utils :
			startDate : start
			endDate : end
			markerLeftBuffer : markerLeftBuffer
			spineWidth : 100 if @spineWidth? #default
			structure : structure
			dateToMarkerNo : (d) ->
				Math.floor (d-@startDate)/(1000*60*60*24)
			noOfIntervals : -> 
				1 + @dateToMarkerNo @endDate
			dateToMarkerLeft : (d) ->
				d = parseDate(d) if typeof d == "string"
				(@markerLeftBuffer + @pctPerInterval()*(@dateToMarkerNo d))+'%'
			pctPerInterval : ->
				(100 - @markerLeftBuffer) / (@noOfIntervals() - 1)
			#toString : -> 
			#	"Start : #{@startDate} 
			#	\nEnd : #{@endDate}  
			#	\nMarkers left buffer : #{@markerLeftBuffer} 
			#	\nNo Of Intervals : #{@noOfIntervals()}  
			#	\nPercent per Interval : #{@pctPerInterval().toFixed(3)}"


#------------ PRODUCE THE INTERVALS (IE, OBJECT ARRAY) ------------------------
#Given start/end dates and an interval type ('day' || 'month') produce
#an array of literals with assigned importance and relevant info
#For a day interval, month starts get value 3, week beginnings get 2
#and days 1, or whatever is the greatest score
produceIntervals = (start, end, interval) ->
	#start and end should be strings of format yyyy-mm-dd
	start = parseDate start
	end = parseDate end
	#start and end are now date type
	result = []
	while start <= end
		result.push 
			date  : start.getDate()
			day   : start.getDay()
			month : start.getMonth()
			year  : 1900+start.getYear()
			
			#toString : -> @date + '/' + @month + '/' + @year + ' day is ' + @day
		start.setDate (start.getDate() + 1)
	setPriority(interval) for interval in result
	result


#------------ SET THE PRIORITY OF A PARTICULAR INTERVAL -----------------------
#Given either a date type, string or object, find priority
setPriority = (interval) ->
		translation = {}
		if not interval['date']?
			if typeof interval == 'string' 
				interval = parseDate(interval)
			translation.day = interval.getDay()
			translation.date = interval.getDate()
			translation.month = interval.getMonth()
			interval = translation
		if interval.date == 1
			interval.priority = 3
		else if interval.day == 1
		 	interval.priority = 2
		else interval.priority = 1


#------------ FIRST RUN, ASSIGN DEFAULT VALUES FOR INFOS-----------------------
#Given all the moments, calculate their respective top values
#Run on start only
assignMomentTopValues = (moments,spine) ->
	utils = getUtils spine
	# sort the moments array in place, via the start date value
	sortMoments(moments)
	# Create arrays to hold the top and bottom moments
	ups = []
	downs = []
	#Assign all moments a collapsed status
	m.isExpanded = false for m in moments
	# Process the moments into these arrays, storing an up 
	# value in each moment
	upDown = (m,i,ups,downs) ->
		m.up = (i%2 == 0)
		if (m.up) then ups.push(m) else downs.push(m)
	upDown(m,i,ups,downs) for m,i in moments
	spine.data('ups',ups)
	spine.data('downs',downs)
	# Ups and downs now hold their respective elements
	# Give each label the ability to calculate it's current furthest
	# leftpoint, rightpoint, it's current width, and a function that
	# states whether a given position intrudes on these
	# Assign each moment the pointer to the spine
	((m) -> 
		m.spine = spine
		m.lblWidth = -> parseFloat @_width
		m.lblHeight = -> @_height
		m.top = -> parseFloat @_top
		m._marginLeft ?= 16
		m.bottom = -> 
			parseFloat @top() + parseFloat @lblHeight()
		m.leftmost = ->
			@leftPctNum - @pctOffset() + '%'
		m.rightmost = ->
			(parseFloat(@leftmost()) + @pctWidth()) + '%'
		m.leftPctNum ?= parseFloat utils.dateToMarkerLeft(@start)
		m.pctWidth = ->
			100*@lblWidth()/(@spine.data('widthPct')/100*@spine.parent().width())
		m.pctOffset = ->
			leftOffset = parseFloat(@_marginLeft)  #_ml = 18
			widthOfSpinePxs = (@spine.data('widthPct')/100*@spine.parent().width())
			100*(leftOffset/widthOfSpinePxs) #maybe 2.13...
		m.inVerticalRange = (m) ->
			#console.log('Test#1 : ' + @top() + ' ' + m.top() + ' ' + @bottom())
			(@top() <= m.top() <= @bottom() or
				@top() <= m.bottom() <= @bottom())
		m.inHorizontalRange = (m) -> 
			#console.log(parseFloat(@leftmost()) + ' ' + parseFloat(m.rightmost()) + ' ' + parseFloat(@rightmost()))			
			a = (parseFloat(@leftmost()) <= parseFloat(m.leftmost()) <= parseFloat(@rightmost()))
			b = (parseFloat(@leftmost()) <= parseFloat(m.rightmost()) <= parseFloat(@rightmost()))
			a or b
		m.clash = (m) -> 
			@inVerticalRange(m) and @inHorizontalRange(m)
	) m for m in moments
	# Next step - process layer values of each label...
	adjustHeights(moments,spine)


#------------ LAYERING PROCESS, FIND CORRECT CSS FOR ALL INFO -----------------
# Given all the moments, run through, apply layering algorithm. Cross & hope.
adjustHeights = (moments,spine) -> 
	#console.log('Does moment 5 clash with 7? ' + moments[4].inHorizontalRange(moments[6]))
	spine = moments[0].spine
	utils = getUtils(spine)
	ups = spine.data('ups')
	downs = spine.data('downs')
	#set all _ css to what they should be for the end of animation
	#should alter width, height and marginLeft properties
	for m in moments
		if m.isExpanded  
			m._marginLeft = m.expanded.marginLeft	
			m._width = m.expanded.width
			m._height = m.expanded.height
		else
			m._marginLeft = m.collapsed.marginLeft
			m._width = m.collapsed.width
			m._height = m.collapsed.height
	## Assign moments their priority
	((m) ->
		pointDate = parseDate m.start
		leftDaySpan = Math.floor((m.leftPctNum - parseFloat m.leftmost()) / 
			utils.pctPerInterval()) + 1
		rightDaySpan = Math.floor(((parseFloat m.rightmost()) - 
			m.leftPctNum) / utils.pctPerInterval()) + 1
		lowestDate = new Date(pointDate)
		lowestDate.setDate(pointDate.getDate() - leftDaySpan)
		pointDate.setDate(pointDate.getDate() + rightDaySpan)
		dates = []
		while lowestDate <= pointDate
			dates.push(setPriority lowestDate)
			lowestDate.setDate(lowestDate.getDate() + 1)
		m.priority = Math.max dates...
		#console.log('From ' + dates + ' we got ' + m.priority)
	) m for m in moments
	## Depending on priority and direction assign first top value
	( (m) -> 
		_top = 0
		if m.up 
			switch m.priority
				when 3 then _top = -35
				when 2 then _top = -30
				when 1 then _top = -23
			_top = _top - parseFloat m._height
		else
			switch m.priority
				when 3 then _top = 20
				when 2 then _top = 16
				when 1 then _top = 12
		m._top = _top
	) m for m in moments
	## Create functions for assigning moments layer values
	adjustForClash = (crrt, others) ->
		clashedWith = (m for m in others when crrt.clash(m))
		if clashedWith.length > 0
			if not m.up
				#console.log(clashedWith[0]._height)
				crrt._top = clashedWith[0]._top + 8 + crrt._height
			else
				crrt._top = clashedWith[0]._top - 8 - crrt._height
			adjustForClash crrt, others
	processLayers = (moments) ->
		for m,i in moments
			adjustForClash(m,(ms for ms in moments when ms!=m))
	## Apply functions to both the ups and the downs separately
	processLayers ups
	processLayers downs
	updateMomentInfoCSS(m) for m in moments
	findMaxTop = (moments) ->
		maxt = 0
		for m in moments
			t = parseFloat m._top
			maxt = t if maxt > t
		return Math.abs maxt
	findMaxBottom = (moments) ->
		maxb = 0
		for m in moments
			b = parseFloat (m._top + m._height)
			maxb = b if maxb < b
		return maxb
	if moments[0]? 
		moments[0].spine.parent().animate {
			height : 2*Math.max(findMaxTop(moments), findMaxBottom(moments)) + 8
		}, {duration : 200}
	return moments


#------------ UPDATE A MOMENTS CSS TO THE _ VALUES ----------------------------
# To be run on the finish of layer processing
updateMomentInfoCSS = (m) ->
	info = m.lblContainer
	info.animate {
		height : m._height, width : m._width
		marginLeft : m._marginLeft, top : m._top + 'px'
	}, {duration : 200}
	if m.vertical?
		top = m.top() + m.lblHeight()/2
		verticalHeight = Math.abs(top)
		if m.up then verticalTop = top else verticalTop = 0
		m.vertical.animate {
			top : verticalTop, height : verticalHeight
		}, {duration : 200}
		m.horizontal.animate {top : top}, {duration : 200}
		#m.circle.animate {top : top}, {duration : 200}
	if m.startWire.height() != 0 then m.animateStartWire()

#------------ CREATE THE EXPAND ALL FUNCTIONALITY AND BIND IT -----------------
# Given the origin circle, all moments and the spine, bind an expand all toggle
# function to the origin circle's event click
bindExpandAllToOrigin = (originCircle, moments, spine) ->
	originCircle
		.data('clicked',true)
		.click -> 
			e = originCircle.data('clicked')
			notExpanded = (m for m in moments when not m.isExpanded)
			m.isExpanded = e for m in moments
			if e
				adjustHeights moments
				animateEndWires m, getUtils(spine) for m in notExpanded
			else
				adjustHeights moments
				m.removeEndWires() for m in moments
			originCircle.data('clicked',not e)


#------------ SMALL HELPER FUNCTIONS, SELF-EXPLANATORY ------------------------
# Given a month index, return the months name
monthNumToName = (m) ->
	"Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Aug,Nov,Dec".split(',')[m]

# Given an array of moments, sort them by their start date
sortMoments = (moments) ->
	moments.sort((a,b) -> 
		if parseDate(a.start) < parseDate(b.start) then -1 else 1)
	
# Given a spine, will return the owning container. Helps keep code in context
getContainer = (spine) ->
	spine.parent()

# Given the container, grab utils
getUtils = (container) ->
	if container.hasClass('spine')
		return container.parent().data('utils')
	else
		container.data('utils')

# Get the next available timelineId
getNextId = ->
	'timeline_' + $('.timeline').length + 1

# Given an input of yyyy-mm-dd format create a js date
parseDate = (input) ->
	if input.getDate? then return input
	parts = input.match(/(\d+)/g)
	new Date(parts[0], parts[1] - 1, parts[2])
#------------------------------------------------------------------------------

#//////////////////////////////////////////////////////////////////////////////
# DRAWING FUNCTIONS -- CREATING TIMELINE SPINE & CONTAINER
#//////////////////////////////////////////////////////////////////////////////

#------------ CREATE THE MAIN CONTAINER ---------------------------------------
#Given a user created container, start laying the divs with the first container
createTimelineContainer = (userContainer) ->
	userContainer.append timelineContainer = $(document.createElement('div'))
	timelineContainer.attr
		id : getNextId()
		class : 'timelineContainer'
	.css
		position : 'relative', minWidth : '500px'
		minHeight : '150px', height : 'auto', width : '100%'
		backgroundColor  : 'white'


#------------ DRAW THE TIMELINE SPINE, CALLBACK THE ORIGN CIRCLE --------------
#Given a timeline container, NB- not user container,
#create the timelines spine and animate it's extension
drawTimelineSpine = (timelineContainer, intervals, nextStep, drawCircle) ->
	leftBuffer = 7;
	rightBuffer = 3;
	tlSpine = $(document.createElement('div'))
		.data 
			'leftBuffer' : leftBuffer
			'rightBuffer' : rightBuffer
	timelineContainer.append tlSpine
	tlSpine.data('widthPct',100-(rightBuffer + leftBuffer))
	tlSpine.attr
		'class' : 'spine'
	.css
		'position' : 'absolute'
		'width' : '0%', 'height' : '1px'
		'top' : '50%'
		'margin-left' : leftBuffer+'%', 'margin-right' : rightBuffer + '%'
		'backgroundColor' : 'black'
	.animate {
		width : 100-(rightBuffer + leftBuffer)+'%'
	}, {
		duration : 1000
		complete : -> 
			tlSpine.find('.intMarker').delay(800).fadeIn(600)
	}
	nextStep tlSpine, intervals, drawCircle


#------------ DRAW THE TIMELINE ORIGIN CIRCLE, RETURN SPINE -------------------
#Create a circle on the leftmost point of the spine,
#layering like so...   .timelineContainer #timeline_0n
#                      |-- .spine
#                      +-- .originCircle
#return the container for use later
drawTimelineOriginCircle = (spine) ->
	container = getContainer(spine)
	circle = makeCircle(12,'black')
		.addClass('originCircle')
		.css
			opacity : 0, cursor : 'pointer'
			top : '50%'
			left : spine.data('leftBuffer') + '%'
		.animate {'opacity':1},
			{duration : '300'}
	container.data('originCircle',circle).append circle
	return spine


#------------ SMALL HELPER FUNCTIONS, SELF-EXPLANATORY ------------------------
#Given a radius and a color, return an jQuery SVG circle element
#NB- circle positioned dead center, due to center call
makeCircle = (r, c, boxShadow) ->
	boxShadow ?= true
	center circle = $(document.createElement('div'))
		.css
			background : c, zIndex : 10
			height : r+'px', width : r+'px'
			position : 'absolute'
			'-moz-border-radius' : r+'px'
			'-webkit-border-radius' : r+'px'
	if boxShadow then circle.css
			'-webkit-box-shadow': '0 0 1px black'
			'-moz-box-shadow': '0 0 1px black'
			boxShadow: '0 0 1px black'
	return circle

#Given a jQuery div representing a circle, center it by accounting
#for it's width and height
center = (c) ->
	c.css
		'margin-top' : -c.height()/2+'px'
		'margin-left': -c.width()/2+'px'

#Given a jQuery circle div, a goal radius size and a speed in 
#miliseconds animate the movement of that circle toward the specified 
#goal, maintaining the centering
animateCircleGrowth = (c,rGoal,speed) ->
	c.animate {
		'height' : rGoal+'px', 'width' : rGoal+'px'
		'-moz-border-radius' : rGoal+'px'
		'-webkit-border-radius' : rGoal+'px'
		'margin-top' : -rGoal/2+'px'
		'margin-left' : -rGoal/2+'px'
	}, {duration : speed}
#------------------------------------------------------------------------------

#//////////////////////////////////////////////////////////////////////////////
# DRAWING FUNCTIONS -- CREATING INTERVALS AND LABELS
#//////////////////////////////////////////////////////////////////////////////

#------------ DEAL WITH CREATING AND DRAWING IN MARKS AND LBLS ----------------
# Given intervals, draw them onto the spine in the correct placement
# and then call the labelling function
drawInMarkers = (spine, intervals, nextStep) ->
	today = new Date()
	assignCSS = (int) ->
		switch int.priority
			when 3 then r = {w : 3, h : 19, c : 'black'}
			when 2 then r = {w : 2, h : 11, c : 'black'}
			when 1 then r = {w : 1, h : 5,  c : 'black'}
		if (int.date == today.getDate()) and (int.month == today.getMonth())
			r.c = 'blue'
			r.h = 15 if r.h < 15
		return r
	# start interval marking a percentage away from the leftmost edge of the
	# spine, find appropriate value by fetching from the container.data
	utils = getUtils(getContainer(spine))
	buffer = utils.markerLeftBuffer
	pctPerInterval = utils.pctPerInterval() #(100-buffer)/(intervals.length-1)
	for int, i in intervals
		pos = 3 + i*pctPerInterval + '%'
		(mrk = makeMarker assignCSS(int)).css 
			left : pos
		spine.append mrk
		#----- ANIMATION HELPER FUNCTION ----------
		animateMarker = (m) ->
			finalHeight = m.data('finalHeight')
			m.delay(1200).animate({
				height : finalHeight
				marginTop : -finalHeight/2
			}, {duration : 300})
		#------------------------------------------
		animateMarker mrk
		lbl = (buildLabel int)
		if lbl?
			spine.append(lbl.css('left',pos))
			lbl.hide()
	nextStep spine


#------------ CREATE A DOCUMENT ELEMENT MARKER, RETURN $ ----------------------
# Given a width, height and color, create a vertical line to be used
# (typically) as an interval marker
makeMarker = (properties) ->
	h = properties['h']
	w = properties['w']
	$(document.createElement('div')).css
		position : 'absolute', top : 0
		marginTop : 0, 'margin-left' : -w/2
		height : 0, width : w #TODO - SETUP ANIMATION
		backgroundColor : properties['c']
	.data('finalHeight',h)


#------------ BUILD THE LABEL FOR THE A SPECIFIC INTERVAL ---------------------
# Given a specfic interval, create the document element for it's label and
# assign correct CSS properties. Return the $lbl object
buildLabel = (int) ->
	lbl = $(document.createElement('div')).css
		marginTop : -20, width : 40, marginLeft : -20, textAlign : 'center'
		height : 'auto', fontFamily : 'Helvetica Neue', fontSize : '7px'
		position : 'absolute'
	.addClass('intMarker')
	txt = ''
	switch int.priority
		when 3 
			txt = monthNumToName int.month
			lbl.css 
				marginTop : -28
				fontSize : 9
				fontWeight : 'bold'
		when 2 then txt = 'Mon ' + int.date
		when 1 then return null
	lbl.text(txt)


#//////////////////////////////////////////////////////////////////////////////
# DRAWING FUNCTIONS -- CREATING MOMENTS
#//////////////////////////////////////////////////////////////////////////////

#------------ CREATE THE START/END DOTS ON SPINE ------------------------------
#Given a moment and a spine onto which to append the information, create
#two circle divs representing the start and end dots. Start is blue, end is red
#Also assign the hover functions to moment.hoverAnimation for easy access later
createAndPlaceMomentDots = (moment,spine) ->
	utils = getUtils(spine)
	startLeft = utils.dateToMarkerLeft(parseDate moment.start)
	endLeft = utils.dateToMarkerLeft(parseDate moment.end)
	spine.append (moment.startDot = makeCircle(7,'#47ACCA'))
			.delay(1400)
			.css
				left:0, zIndex : 10
			.animate {
				left : startLeft
			}, {duration : 400}
	spine.append (moment.endDot = makeCircle(7,'#E0524E'))
			.delay(1400)
			.css
				left:0, zIndex : 11
			.animate({
				left : endLeft
			}, {duration : 400})
			.hide()
	spine.append (moment.duration = createDurationLine(moment,getUtils(spine),'#5BB35C'))
	spine.append (hoverCircle = makeCircle(14,'white').css {opacity : 0, left : startLeft})
	moment.hoverAnimation = 
		in : moment.duration.data('slideIn')
		out : moment.duration.data('slideOut')


#------------ CREATE THE DURATION LINE BETWEEN START AND END ------------------
# Given a moment, the container utils for position calculations and a string
# color value, create a div between the start and end dates on the spine
# Do not append, just create and return the element.
createDurationLine = (moment, utils, color) ->
	lft = utils.dateToMarkerLeft parseDate moment.start
	right = utils.dateToMarkerLeft parseDate moment.end
	width = (parseFloat(right) - parseFloat(lft)) + '%'
	line = $(document.createElement('div')).css
		height : 2, width : 0, position : 'absolute'
		left : lft, zIndex : 5, backgroundColor : color
	.data
		slideIn : -> if not line.hasClass('inTransition')
			line.addClass('inTransition').stop()
				.css('width',0)
				.animate({
					width : width
				}, {duration : 300,complete : -> 
							line.removeClass('inTransition')})
			moment.endDot.fadeIn(300)
		slideOut : -> 
			delay = 0
			if line.hasClass('inTransition') then delay = 200
			moment.endDot.delay(delay).stop().fadeOut(300)
			line.delay(delay).stop().addClass('inTransition')
				.animate({width : 0}, {duration:300})
				.removeClass('inTransition')


#------------ CREATE AND APPEND THE INFO DIV FOR MOMENT -----------------------
# Given a moment and a spine, create the label for the moment and deal
# with left positioning. Attach the label jQuery element to the moment 
# for easy access. Also make the startWire
createAndPlaceMomentInfo = (moment,spine) ->
	left = getUtils(spine).dateToMarkerLeft(moment.start)
	spine.append (container = $(document.createElement('div')))
	container.addClass('infoBox')
	.css('left',left)
	.click ->
		moment.isExpanded = not moment.isExpanded
		adjustHeights(spine.data('moments'))
		if moment.isExpanded
			animateEndWires moment, getUtils(spine)
		else
			moment.removeEndWires()		
	.hover moment.hoverAnimation.in, moment.hoverAnimation.out
	processTitle(moment,container,getUtils(spine).structure,getUtils(spine)).hide()
	container.css('margin-left',-container.width()/2).data('defaultLeft',left)
	moment.leftPctNum = parseFloat(left)
	createAndPlaceMomentStartWire moment, spine, left
	moment.lblContainer = container
	return moment

#------------ CREATE MOMENT START WIRE AND DEAL WITH ANIMATION ----------------
# Given a moment, timeline spine and a left property, create an appropriate
# div representing the link from the timeline to the info box of the moment.
createAndPlaceMomentStartWire = (moment, spine, left) ->
	spine.append (startWire = $(document.createElement('div')))
	startWire.addClass('wire').css
		position : 'absolute', width : '2', backgroundColor : 'black'
		left : left   # This will always remain the same, wire won't move
		top : 0, '-webkit-box-shadow': '0 0 2px blue', height : 0
		'-moz-box-shadow': '0 0 2px blue', boxShadow: '0 0 2px blue'
	moment.startWire = startWire
	moment.animateStartWire =  ->
		if @up
			@startWire.stop().animate {
				height : Math.abs(@bottom())
				top : @bottom()
			}, {duration : 200, easing : 'linear'}
		else
			@startWire.animate {
				height : @top()
			}, {duration : 200}
# End the function by assigning the jQuery container variable to the
# moment object for manipulation later


#------------- CREATE MOMENT END WIRES AND DETERMINE ANIMATION ----------------
# Given an moment and the container utils, create the end wire elements and
# organise the animation for their movement. Attach the animation and a removal
# function to the moment in question, along with the elements themselves.
animateEndWires = (m, utils) ->
	startWire = m.startWire
	left = ($(startWire).attr('style')).split('left:')[1].split('%')[0] + '%'
	right = parseFloat utils.dateToMarkerLeft(m.end)
	top = m.top() + m.lblHeight()/2
	verticalHeight = Math.abs(top)
	if m.up then verticalTop = top else verticalTop = 0
	m.vertical = $(document.createElement('div')).css
		position : 'absolute', width : '2px', backgroundColor : 'black'
		left : right + '%', height : 0, top : top
		'-webkit-box-shadow': '0 0 2px red'
		'-moz-box-shadow': '0 0 2px red', boxShadow: '0 0 2px red'
	.appendTo(m.spine)
	m.horizontal = $(document.createElement('div')).css
		position : 'absolute', height : '2px', backgroundColor : 'black'
		left : left, width : 0, top : top
		'-webkit-box-shadow': '0 0 2px red'
		'-moz-box-shadow': '0 0 2px red', boxShadow: '0 0 2px red'
	.appendTo(m.spine)
	#m.circle = (makeCircle 3, 'black', false).css
	#			left : right + '%', top : m.horizontal.css('top')
	m.horizontal.animate {
		width : (right - parseFloat left) + '%'
	}, {complete : ->
			#m.circle.appendTo(m.spine)
			m.vertical.animate {
				height : verticalHeight, top : verticalTop
				}, {duration : 200}}
	m.removeEndWires = ->
		m.vertical.remove()
		m.horizontal.remove()
		#m.circle.remove()


#------------ HELPER FUNCTIONS FOR THE INFO BOX CREATION ----------------------
# Given an moment, the infoDiv to which it's content should go and container
# utils, format the moments content using the structure object located
# under the utils object. Process title will deal with storing the CSS props
# for when the info box is collapsed...
processTitle = (m, infoDiv, structure, utils) ->
	textLine = ""
	if structure.title.length != 1
		for i in [0..structure.title.length-2]
			key = structure.title[i]
			if m[key]? then textLine += m[key] + ':'
	textLine += m[structure.title[structure.title.length-1]]
	mainTitle = $(document.createElement('span')).css('display','inline')
		.text(textLine).addClass('title').appendTo(infoDiv)
	#infoDiv.text(textLine).html('<span>' + infoDiv.html() + '</span>')
	m.collapsed = 
		height : infoDiv.height()
		width : infoDiv.width() + 1
		marginLeft : -(infoDiv.width())/2
	processExpanded m, mainTitle, infoDiv, structure, utils, textLine

# ...and processExpanded will take on the expanded view. CSS properties for
# the collapsed and expanded states will be stored in the moment
# object under either collapsed{} or expanded{} respectively
processExpanded = (m, mainTitle, infoDiv, structure, utils, textLine) ->
	# Process the extendedTitle parts
	if structure.extendedTitle.length != 0
		textLine += ' - '
		for i in [0..structure.extendedTitle.length-2]
			key = structure.extendedTitle[i]
			if m.key? then textLine = textLine +  m[key] + ', '
		textLine += m[structure.extendedTitle[structure.extendedTitle.length-1]]
		if /^[\s]+$/.test(textLine.split(' - ')[1]) then textLine = textLine.replace(' - ','')
	mainTitle.text(textLine)
	textLine = ''
	# Create the new line
	infoDiv.html(infoDiv.html() + '<br>')
	# Create content span and assign css, then append
	content = $(document.createElement('span')).css
			whiteSpace:'nowrap', fontSize:'10px'
			fontFamily : "'Helvetica Neue', Helvetica, Arial, sans-serif"
		.appendTo(infoDiv)
	addedContent = false
	if structure.content.names?
		links = []
		for linkKey,i in structure.content.links
			if m[linkKey]?
				link = $(document.createElement('a'))
				link.text(structure.content.names[i])
					.attr('href',m[linkKey])
				links.push link
		addedContent = links.length != 0
		for link,i in links
			if i != links.length-1
				link.appendTo(content)
				content.html(content.html()+ ' / ')
		if links[0]? then content.append link
	else
		for i in [0..structure.content.length-2]
			key = structure.content[i]
			if m[key]? then textLine += (m[key] + ' / ')
		textLine += m[structure.content[structure.content.length-1]]
		addedContent = true
		content.text(textLine)
	m.expanded =
		height : infoDiv.height() + (if addedContent then 4 else 0)
		width : infoDiv.width() + (if addedContent then 4 else 0)
		marginLeft : m.collapsed.marginLeft #TODO - sort out centering
	infoDiv.css
		height : m.collapsed.height
		width : m.collapsed.width
		marginLeft : m.collapsed.marginLeft
#------------------------------------------------------------------------------
