module ProtectedAreasHelper

  def map_exists?(sitecode)

    begin
      base_url = "http://discomap.eea.europa.eu/ArcGIS/rest/services/Bio/Natura2000Centers_Dyna_WM/MapServer/0/query?f=json"
      url = "#{base_url}&&where=SITECODE%20%3D%20'#{sitecode}'"
      resp = Net::HTTP.get_response(URI.parse(url))
      result = JSON.parse(resp.body)

      sitename = result['features'][0]['attributes']['SITENAME']
      # if result.has_key? 'Error'
      #   raise "web service error"
      # end
      sitename.size > 0 ? true : false
    rescue Exception => e
      false
    end
  end

end
