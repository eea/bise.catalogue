module ArticlesHelper

    def articles_by_year

        # results = Article.group('created_at').count

        # results = Article.count(:all, :group => "strftime('%Y', created_at)")
        data = Array.new

        # results = Article.group { |t| t.due_at.beginning_of_year }
        (7.years.ago.year..Date.today.year).map do |date|
            logger.debug { ":: year => " + date.to_s }

            # r = Article.where("Date('%Y', created_at) = ?", date.to_s).count
            r = Article.where( :created_at == date).count
            logger.debug { r }

            # {
            #     purchased_at: date,
            #     price: Order.where("date(purchased_at) = ?", date).sum(:price)
            # }
        end

        {
            :hola => 'hola'
        }

    end

end
