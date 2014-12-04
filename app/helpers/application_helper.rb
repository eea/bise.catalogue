module ApplicationHelper

  def biographical_regions
    [
      'Alpine',
      'Anatolian',
      'Artic',
      'Atlantic',
      'Black sea',
      'Boreal',
      'Continental',
      'Macaronesia',
      'Mediterranean',
      'Pannonian',
      'Steppic',
      'Region not detailed'
    ]
  end

  def languages
    [
      'Bulgarian',
      'Croatian',
      'Czech',
      'Danish',
      'Dutch',
      'English',
      'Estonian',
      'Finnish',
      'French',
      'German',
      'Greek',
      'Hungarian',
      'Irish',
      'Italian',
      'Latvian',
      'Lithuanian',
      'Maltese',
      'Polish',
      'Portuguese',
      'Romanian',
      'Slovak',
      'Slovenian',
      'Spanish',
      'Swedish'
    ]
  end

  def tags
    [
      'Agriculture',
      'Air pollution',
      'Biodiversity',
      'Chemicals',
      'Climate change',
      'Coasts and seas',
      'Energy',
      'Environment and health',
      'Environmental scenarios',
      'Environmental technology',
      'Fisheries',
      'Green economy',
      'Household consumption',
      'Industry',
      'Land use',
      'Natural resources',
      'Noise',
      'Policy instruments',
      'Soil',
      'Specific regions',
      'Tourism',
      'Transport',
      'Urban environment',
      'Various other issues',
      'Waste and material resources',
      'Water'
    ]
  end

  def show_approved?
    return false unless params[:approved].present?
    if params[:approved] == 'true'
      true
    else
      false
    end
  end

  def print_process(i)
    if i%4 == 0
      print "\\ Processed => #{i+1}\r"
    elsif i%4 == 1
      print "| Processed => #{i+1}\r"
    elsif i%4 == 2
      print "/ Processed => #{i+1}\r"
    elsif i%4 == 3
      print "- Processed => #{i+1}\r"
    end
  end

  def search_params_available?
    prev = request.referer
    if prev.present? &&
       (
        prev.include?('query') ||
        prev.include?('site') ||
        prev.include?('author') ||
        prev.include?('countries') ||
        prev.include?('languages') ||
        prev.include?('published_on') ||
        prev.include?('source_db') ||
        prev.include?('kingdom') ||
        prev.include?('phylum') ||
        prev.include?('classis') ||
        prev.include?('species_group') ||
        prev.include?('taxonomic_rank') ||
        prev.include?('approved')
       )
      true
    else
      false
    end
  end

  def accessible_libraries
    Site.where(id: current_user.library_roles.where(allowed: true).map(&:site_id))
  end

end
