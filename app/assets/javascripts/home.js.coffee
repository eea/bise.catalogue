# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  Morris.Donut({
    element: 'articles-graph',
    data: [
      {label: "Published", value: 12},
      {label: "Unpublished", value: 30}
    ],
    colors: [
      '#a5c500',
      '#bf0f3b'
    ]
  })

  Morris.Donut({
    element: 'documents-graph',
    data: [
      {label: "Published", value: 120},
      {label: "Unpublished", value: 30}
    ],
    colors: [
      '#a5c500',
      '#bf0f3b'
    ]
  })

  Morris.Donut({
    element: 'news-graph',
    data: [
      {label: "Published", value: 68},
      {label: "Unpublished", value: 3}
    ],
    colors: [
      '#a5c500',
      '#bf0f3b'
    ]
  })

  Morris.Donut({
    element: 'links-graph',
    data: [
      {label: "Published", value: 2},
      {label: "Unpublished", value: 12 }
    ],
    colors: [
      '#a5c500',
      '#bf0f3b'
    ]
  })

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
