require 'will_paginate/view_helpers'

WillPaginate::ViewHelpers.pagination_options[:inner_window]   = 2
WillPaginate::ViewHelpers.pagination_options[:outer_window]   = 0
