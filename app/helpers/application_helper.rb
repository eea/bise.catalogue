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

end
