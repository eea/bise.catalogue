class ArticlesController < InheritedResources::Base

  before_filter :authenticate_user!

  def approve_multiple
    if (params[:article_ids].nil?)
      respond_to do |format|
        format.html { redirect_to articles_path, alert: "Please, select at least one article!" }
      end
      return
    end

    @articles = Article.find(params[:article_ids])
    @articles.each do |article|
      article.approved = !article.approved
      article.save!
    end
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

protected
  def collection
    @articles ||= end_of_association_chain.search(params)
  end

end
