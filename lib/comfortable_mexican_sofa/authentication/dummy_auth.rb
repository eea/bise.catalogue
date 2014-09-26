module ComfortableMexicanSofa::CatalogueAuth

  # Will always let you in
  def authenticate
    redirect_to root_path unless current_user
  end

end
