# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->


  Morris.Bar({
    element: 'overview-graph',
    data: $('#overview-graph').data('overview').map (item) ->
      JSON.parse item
    xkey: 'y',
    ykeys: ['a', 'b'],
    stacked: true,
    hideHover: true,
    hoverCallback: (index, options, content) ->
      row = options.data[index]
      return "Approved:" + row.a + ", Unapproved: " + row.b

    barColors: [ '#95c43a', '#3c5017' ],
    labels: ['Published', 'Unpublished']
  });

  # a = $('#timeline-graph').data('timeline').map (month) ->
  #   console.log month
  #   JSON.parse month

  json = $('#timeline-graph').data('timeline').map (month) ->
    JSON.parse(month)
  console.log json


  Morris.Area({
    element: 'timeline-graph',
    data: $('#timeline-graph').data('timeline').map (month) ->
      JSON.parse month
    hoverCallback: (index, options, content) ->
      row = options.data[index]
      return "<em>" + row.y + "</em>: " + row.a + " Articles, " + row.b + " Documents, " + row.c + " Links."
    parseTime: false,
    continuousLine: false,
    xkey: 'y',
    ykeys: ['a', 'b', 'c'],
    labels: ['Articles', 'Documents', 'Links'],
    lineColors: ['#015666','#05849D','#37B6CE']
  });

  Morris.Donut({
    element: 'eunis-graph',
    data: $('#eunis-graph').data('eunis').map (item) ->
      JSON.parse item
    colors: ['#006c16','#3c6c33','#728e31']
  })


  # Morris.Donut({
  #   element: 'articles-graph',
  #   data: [
  #     {label: "Articles", value: 119 },
  #     {label: "Documents", value: 44 },
  #     {label: "Links", value: 13 },
  #     {label: "News", value: 0},
  #     {label: "Species", value: 280000},
  #     {label: "Habitat", value: 6600},
  #     {label: "Sites", value: 28000}
  #   ]
  #   # colors: [
  #   #   '#a5c500',
  #   #   '#bf0f3b'
  #   # ]
  # })

  # Morris.Donut({
  #   element: 'documents-graph',
  #   data: [
  #     {label: "Published", value: $('#documents-graph').data('approved') },
  #     {label: "Unpublished", value: $('#documents-graph').data('unapproved') }
  #   ],
  #   colors: [
  #     '#a5c500',
  #     '#bf0f3b'
  #   ]
  # })

  # Morris.Donut({
  #   element: 'news-graph',
  #   data: [
  #     {label: "Published", value: 0 },
  #     {label: "Unpublished", value: 0 }
  #   ],
  #   colors: [
  #     '#a5c500',
  #     '#bf0f3b'
  #   ]
  # })

  # Morris.Donut({
  #   element: 'links-graph',
  #   data: [
  #     {label: "Published", value: $('#links-graph').data('approved') },
  #     {label: "Unpublished", value: $('#links-graph').data('unapproved') }
  #   ],
  #   colors: [
  #     '#a5c500',
  #     '#bf0f3b'
  #   ]
  # })

  # Morris.Line({
  #   element: 'timeline-graph',
  #   data: [
  #     { y: '2006', a: 100, b: 90, c: 50, d: 65 },
  #     { y: '2007', a: 75,  b: 55, c: 55, d: 65 },
  #     { y: '2008', a: 50,  b: 40, c: 60, d: 65 },
  #     { y: '2009', a: 75,  b: 65, c: 70, d: 65 },
  #     { y: '2010', a: 50,  b: 40, c: 80, d: 65 },
  #     { y: '2011', a: 75,  b: 65, c: 85, d: 65 },
  #     { y: '2012', a: 100, b: 90, c: 70, d: 65 }
  #   ],
  #   xkey: 'y',
  #   ykeys: ['a', 'b', 'c', 'd'],
  #   lineColors: [ '#f9ca00', '#f95500', '#f900c0', '#b200f9' ]
  #   labels: ['Series A', 'Series B']
  # });


