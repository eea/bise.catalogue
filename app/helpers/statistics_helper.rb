module StatisticsHelper
  def tag_cloud_data
    CatalogueSearch.group(:query).count(:query).map do |t, v|
      { text: t, weight: v }
    end.to_json
  end
end
