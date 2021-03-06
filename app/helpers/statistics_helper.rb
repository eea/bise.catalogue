module StatisticsHelper
  def tag_cloud_data
    CatalogueSearch.where("query != '*'").group(:query).order('count(query) DESC').limit(20).count(:query).map do |t, v|
      { text: t, weight: v }
    end.to_json
  end

  def queries_by_location
    CatalogueSearch.group(:location).count(:location).map do |c, v|
      { country: c, queries: v }
    end
  end
end
