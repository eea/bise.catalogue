module HomeHelper

  def overview_data
    array = Array.new
    indexes = [
      'articles',
      'documents',
      # 'news',
      'links'
      # 'protected_areas',
      # 'habitats',
      # 'species'
    ]
    indexes.map do |index|
      approved = Tire.search "catalogue_#{Rails.env}_#{index}", search_type: 'count' do
        query do
          string 'title:*'
          string 'approved:1'
        end
      end
      unapproved = Tire.search "catalogue_#{Rails.env}_#{index}", search_type: 'count' do
        query do
          string 'title:*'
          string 'approved:0'
        end
      end
      array.push({
        y: index.titleize,
        a: approved.results.total,
        b: unapproved.results.total
      }.to_json)
    end
    array
  end

  def timeline
    array = Array.new
    indexes = [
      'articles',
      'documents',
      # 'news',
      'links'
      # 'protected_areas',
      # 'habitats',
      # 'species'
    ]

    time_start = 12.months.ago
    time = time_start
    while time < 0.seconds.ago
      month_name = Date::MONTHNAMES[time.month]
      date_init = DateTime.new(time.year, time.month, 1)
      date_end = Date.civil(time.year, time.month, -1)
      time = time.advance(months: 1)

      index_counts = Array.new
      indexes.map do |index|
        # Searches count for each index by month
        s = Tire.search "catalogue_#{Rails.env}_#{index}", search_type: 'count' do
          query { string 'title:*' }
          filter :range, created_at: { gte: date_init, lte: date_end }
          facet 'timeline' do
            date :created_at, interval: 'month'
          end
        end
        index_counts.push s.results.total
      end
      array.push({
        y: month_name,
        a: index_counts[0],
        b: index_counts[1],
        c: index_counts[2]
      }.to_json)
    end
    array
  end

  def eunis_data
    array = Array.new
    indexes = [
      'protected_areas',
      'habitats',
      'species'
    ]
    indexes.map do |index|
      s = Tire.search "catalogue_#{Rails.env}_#{index}", search_type: 'count' do
        query do
          string 'uri:*'
        end
      end
      array.push({
        label: index.titleize,
        value: s.results.total
      }.to_json)
    end
    array
  end


end
